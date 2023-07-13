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

let textSchema = typeDefs + queries;

const MEMCACHED_HOST = process.env.MEMCACHED_HOST ? process.env.MEMCACHED_HOST : 'memcached';
const MEMCACHED_PORT = process.env.MEMCACHED_PORT ? process.env.MEMCACHED_PORT : 11211;
const memd = memcached(session);
const store = new memd({ hosts: [`${MEMCACHED_HOST}:${MEMCACHED_PORT}`] });


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

