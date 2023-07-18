import { ApolloClient, createHttpLink, from, InMemoryCache } from '@apollo/client';
import onError from "./apollo-error"

const httpLink = createHttpLink({
    uri: '/graphql',
    credentials: 'same-origin'
  });
const cache = new InMemoryCache();
const apolloClient = new ApolloClient({
  link: from([
      onError,
      httpLink,
  ]),
  cache,
})
export { apolloClient };