'use strict';

import keycloak from 'keycloak-connect';
import UUID from 'keycloak-connect/uuid.js';

import { get_client } from '../resolvers.js';

const keycloak_config = {
    'realm': process.env.REALM,
    'realm-public-key': process.env.REALM_PUBLIC_KEY,
    'publicClient': false,
    'clientId': process.env.CLIENT_ID || 'phone_catalog-back',
    'bearerOnly': false,
    'serverUrl': process.env.KEYCLOAK_SERVER_URL,
    'secret': process.env.REALM_SECRET,
    'redirectUrl': '/',
};

let _instance;

export class keycloak_manager {
    static _keycloak;

    constructor(options) {
        if (_instance) {
            return _instance;
        }

        if (this._keycloak) {
            console.error('Trying to init Keycloak again!');
        } else {
            let memoryStore = options.store;
            this._keycloak = new keycloak({ store: memoryStore, onLoad: 'login-required' }, keycloak_config);
            this._keycloak.authenticated = async (req) => {
                try {
                    await this.check_and_create_user(req);
                } catch (error) {
                    // response is unavailable here
                    return;
                }
            };
            this._keycloak.accessDenied = async (req, res, next) => {
                console.warn('Access denied');
                await req.session.destroy();
                req.session = null;
                if (res) {
                    res.clearCookie('connect.sid', { path: '/' });
                }
                res.redirect('/');
            };
        }

        _instance = this;
        return _instance;
    }

    async check_and_create_user(req) {
        let client = get_client();
        let user_info = await this._keycloak.grantManager.userInfo(req.kauth.grant.access_token); // TODO: rethink
        try {
            let result = await get_client().query(`SELECT * FROM users WHERE remote_id = $1`, [user_info['sub']]);
            result = result.rows;

            if (!result || !result.length) {
                result = await get_client().query(`INSERT INTO users (remote_id, name, email, login) VALUES ($1,$2,$3,$4) RETURNING *`, [
                    user_info['sub'],
                    user_info['name'],
                    user_info['email'],
                    user_info['preferred_username'],
                ]);

            } else {
                result = await get_client().query(`UPDATE users SET name = $1, email = $2, login = $3 WHERE remote_id = $4 RETURNING *`, [
                    user_info['name'],
                    user_info['email'],
                    user_info['preferred_username'],
                    user_info['sub'],
                ]);
            }
            result = result.rows[0];
            return result;
        } catch (error) {
            console.error('ERROR loading user from database: ', error);
            throw error;
        }
    }

    static get_keycloak() {
        if (!this._keycloak) console.error('Keycloak has not been initialized. Please call init first.');
        return this._keycloak;
    }
    get_keycloak() {
        if (!this._keycloak) console.error('Keycloak has not been initialized. Please call init first.');
        return this._keycloak;
    }

    async get_user(req, res) {
        if (process.env.DISABLE_AUTH == '1') {
            return {
                id: 0,
                remote_id: '0',
                name: 'System',
                email: 'empty@email',
                email_verified: 0,
                username: 'System user',
                login: 'system',
                roles: ['can_read', 'can_edit', 'can_add', 'can_report'],
                location: {},
            };
        }

        if (!req || !req.kauth || !req.kauth.grant) {
            console.warn('User is not authorized');
            return 0;
        }

        let user_info, db_user_info;

        try {
            user_info = await this._keycloak.grantManager.userInfo(req.kauth.grant.access_token);
            db_user_info = await get_client().query(`SELECT * FROM users WHERE remote_id = $1`, [user_info['sub']]);
            db_user_info = db_user_info.rows;
            // db_user_info = await db.users.findOne({
            //     where: { remote_id: [user_info['sub']] },
            // });

            if (!db_user_info || !db_user_info[0].id) {
                console.error('User is authorized, but no such user in DB: ', db_user_info, user_info);
                return 0;
            }
        } catch (error) {
            console.error('Error ', error);
            await req.session.destroy();
            if (res) {
                res.clearCookie('connect.sid', { path: '/' });
            }
            console.error('Cannot get user info by access token');
            return 0;
        }

        let roles = '';
        if (req.kauth.grant.access_token.content.realm_access && req.kauth.grant.access_token.content.realm_access.roles) {
            roles = req.kauth.grant.access_token.content.realm_access.roles || [];
            roles = roles.join();
        }
        if (req.kauth.grant.access_token.content.resource_access) {
            let appRoles = req.kauth.grant.access_token.content.resource_access[keycloak_config.clientId];
            if (appRoles) {
                roles += ',' + appRoles.roles;
            }
        }

        roles = roles.split(/,/);
        db_user_info = db_user_info[0];
        return {
            id: db_user_info.id,
            remote_id: db_user_info.remote_id,
            name: db_user_info.name,
            email: db_user_info.email,
            login: db_user_info.login,
            roles: roles,
        };
    }

    validateRights(req, res, model, rightsType) {
        if (process.env.DISABLE_AUTH == 1) {
            return 1;
        }

        if (req.kauth && req.kauth.grant) {
            // User is authorized, but he have not permisssions to access this model
            if (!req.kauth.grant.access_token.hasRole(model + '_' + rightsType) && !req.kauth.grant.access_token.hasRole('admin')) {
                // No appropriate role, such as passport-read
                return 0;
            }
            // Temporary disable, unless UI will learn to not redirect on 403
            //    if (model === 'user' && !req.kauth.grant.access_token.hasRole('admin')) {
            //      return 0
            //    }
            return 1;
        } else {
            // User is not authorized
            return 0;
        }
    }

    async checkRights(req, res, arg) {
        let user = await this.get_user(req, res);
        if (!user) {
            console.error('Cannot get user info from Keycloak');
            res.status(401).json({ error: 'cannot get user info' });
            return Promise.resolve(user);
        }

        if (process.env.DISABLE_AUTH != '1') {
            let hasRights = this.validateRights(req, res, 'can', arg);
            return Promise.resolve(hasRights ? user : false);
        }
        return Promise.resolve(user);
    }

    async checkWriteRights(req, res, arg) {
        let user = await this.get_user(req, res);
        if (!user) {
            console.error('Cannot get user info from Keycloak');
            res.status(401).json({ error: 'cannot get user info' });
            return Promise.resolve(user);
        }

        if (process.env.DISABLE_AUTH != '1') {
            let canWrite = this.validateRights(req, res, arg, 'write');
            return Promise.resolve(canWrite ? user : false);
        }
        return Promise.resolve(user);
    }

    async checkReadRights(req, res, arg) {
        let user = await this.get_user(req, res);
        if (!user) {
            console.error('Cannot get user info from Keycloak');
            res.status(401).json({ error: 'cannot get user info' });
            return Promise.resolve(user);
        }

        if (process.env.DISABLE_AUTH != '1') {
            let canRead = this.validateRights(req, res, arg, 'read');
            return Promise.resolve(canRead ? user : false);
        }
        return Promise.resolve(user);
    }
}
