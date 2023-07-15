import express from 'express';
import cors from 'cors';
import http from 'http';
import { ApolloServer } from '@apollo/server';
import { makeExecutableSchema } from '@graphql-tools/schema';
import { expressMiddleware } from '@apollo/server/express4';
import { GraphQLError } from 'graphql';
import { applyMiddleware } from 'graphql-middleware';
import {
    get_catalog,
    add_catalog_entry,
    edit_catalog_entry,
    terminate_catalog_entry,
    unterminate_catalog_entry,
    get_catalog_report,
    get_user,
} from './resolvers.js';
import { typeDefs, queries } from '../schema/index.js';
import session from 'express-session';

import { auth } from './common/auth.js';
import { logout } from './common/auth.js';
import { keycloak_manager } from './common/keycloak.js';
import { default as memcached } from 'connect-memcached';
import { permissions } from './common/permissions.js';
import { GraphQLDateTime, GraphQLDate } from 'graphql-scalars';

let textSchema = typeDefs + queries;

const MEMCACHED_HOST = process.env.MEMCACHED_HOST ? process.env.MEMCACHED_HOST : 'memcached';
const MEMCACHED_PORT = process.env.MEMCACHED_PORT ? process.env.MEMCACHED_PORT : 11211;
const memd = memcached(session);
const store = new memd({ hosts: [`${MEMCACHED_HOST}:${MEMCACHED_PORT}`] });

let session_object = session({
    secret: 'ThESeCreT0', // TODO: replace to something taken from env
    resave: false,
    saveUninitialized: true,
    store: store,
    cookie: { secure: false, maxAge: 1000 * 60 * 60 },
});

const resolvers = {
    DateTime: GraphQLDate,
    Query: {
        get_catalog: get_catalog,
        get_user: get_user,
    },
    Mutation: {
        add_catalog_entry: add_catalog_entry,
        edit_catalog_entry: edit_catalog_entry,
        terminate_catalog_entry: terminate_catalog_entry,
        unterminate_catalog_entry: unterminate_catalog_entry,
    },
};
const schema = makeExecutableSchema({
    typeDefs: textSchema,
    resolvers: resolvers,
});
// Setup server
const app = express();
app.use(cors());
app.use(session_object);

app.use((req, res, next) => {
    // Intermediate middleware, that sets redirect URL for Keycloak
    // Should be executed before keycloak (or any controller)
    // TODO: probably move to separate module

    let host = req.hostname;
    let port = '';
    if (req.header('Host')) {
        let header_host = req.header('Host').split(':');
        port = header_host[1] ? header_host[1] : '';
        host = header_host[0];
    }
    const protocol = req.header('X-Forwarded-Proto') ?? req.protocol;
    let path = req._parsedOriginalUrl.pathname;
    const self_url = protocol + '://' + host + (port === '' ? '' : ':' + port) + path + '?' + 'auth_callback=1';
    req.session ??= {};
    req.session.auth_redirect_uri = self_url;
    next();
});
const kc = new keycloak_manager({ store: session_object });
app.use(kc.get_keycloak().middleware());

const httpServer = http.createServer(app);

const server = new ApolloServer({
    //    typeDefs: schema,
    schema: applyMiddleware(schema, permissions),
    resolvers,
    formatError: (err) => {
        if (err.message.startsWith('Database Error: ')) {
            return new Error('Внутренняя ошибка сервера');
        }
        return err;
    },
});

await server.start();
app.use(
    '/graphql',
    express.json(),
    expressMiddleware(server, {
        context: async ({ req, res }) => {
            let ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
            let user = await kc.get_user(req, res);
            if (user) {
                return {
                    user: user,
                    ip: ip,
                };
            } else {
                throw new GraphQLError('Пользователь не авторизован', {
                    extensions: {
                        code: 'UNAUTHENTICATED',
                        http: { status: 401 },
                    },
                });
            }
        },
    })
);

app.get('/auth', auth);
app.get('/logout', logout);
app.get('/report', async (req, res) => {
    let user = await kc.get_user(req, res);

    if (!user) return res.status(403).json({ error: 'Пользователь не авторизован или недостаточно прав' });

    let rights = kc.checkRights(req, res, 'report');

    if (!rights) {
        return res.status(403).json({ error: 'Недостаточно прав' });
    }

    try {
        let data = await get_catalog_report(req.query.format);
        if (!data) {
            throw new Error(`No format found ${req.query.format}`);
        }
        let content_type = '';
        switch (req.query.format) {
            case 'csv':
                content_type = 'application/csv';
                break;
            case 'xlsx':
                content_type = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
                break;
            case 'tsv':
                content_type = 'application/tsv';
                break;
            case 'xml':
                content_type = 'text/xml';
                break;
        }
        res.set('Content-Type', content_type);
        res.set('Content-Disposition', `attachment; filename="phone_catalog.${req.query.format}"`);
        res.send(data);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: 'Что-то пошло не так...' });
    }
});
const port = process.env.BACK_PORT || 8090;
await new Promise((resolve) => {
    httpServer.listen({ port: port }, resolve);
    // Enable keepalive internally
    httpServer.keepAliveTimeout = 60 * 1000 + 1000;
    httpServer.headersTimeout = 60 * 1000 + 2000;
});

console.log(`Server ready at ${port}`);

