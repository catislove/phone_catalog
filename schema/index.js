'use strict';

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const basename = path.dirname(__filename);

let typeDefs = '';
fs.readdirSync(basename + '/types')
    .filter((file) => {
        return (
            file.indexOf('.') !== 0 &&
            file !== basename &&
            file.slice(-4) === '.gql'
        );
    })
    .forEach((file) => {
        typeDefs += fs.readFileSync(basename + '/types/' + file);
    });

let queries = '';
fs.readdirSync(basename + '/queries')
    .filter((file) => {
        return (
            file.indexOf('.') !== 0 &&
            file !== basename &&
            file.slice(-4) === '.gql'
        );
    })
    .forEach((file) => {
        queries += fs.readFileSync(basename + '/queries/' + file);
    });

// console.log("TYPEDEFS: ", typeDefs);
// console.log("QUERIES: ", queries);

export { typeDefs, queries as queries };
