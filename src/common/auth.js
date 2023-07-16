'use strict';

import { keycloak_manager } from './keycloak.js';
import UUID from 'keycloak-connect/uuid.js';

export async function auth(req, res, next) {
    if (process.env.DISABLE_AUTH == '1') {
        return res.redirect('/');
    }

    try {
        const keycloak = new keycloak_manager();
        let redirect_url = get_redirect_url(req);

        if (!req.kauth || !req.kauth.grant) {
            return res.redirect(redirect_url);
        }

        let result = await keycloak.get_user(req, res);
        if (!result) {
            return res.redirect(redirect_url);
        }
    } catch (error) {
        console.error('Error in auth ', error);
        req.session && req.session.destroy();
    }

    return res.redirect('/');
}

function get_redirect_url(req) {
    let prev_url = encodeURIComponent(req.get('Referer'));
    let self_url = req.session.auth_redirect_uri;
    const uuid = UUID();

    let manager = new keycloak_manager();
    let kc = manager.get_keycloak();

    const login_url = kc.loginUrl(uuid, encodeURI(self_url));
    return login_url;
}

export async function logout(req, res, next) {
    res.clearCookie('connect.sid', { path: '/' });
    req.session && req.session.destroy();
    res.redirect('/');
}
