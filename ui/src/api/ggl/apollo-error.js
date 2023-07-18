import { onError } from '@apollo/client/link/error'

export default onError(
    ({ graphQLErrors, networkError, operation, forward }) => {
      if (graphQLErrors) {
        graphQLErrors.map(({ message, locations, path }) => {
          console.log(
            `[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`
          )
        })
        if (
          graphQLErrors[0]?.extensions?.code === 'FORBIDDEN' ||
          graphQLErrors[0]?.extensions?.code === 'UNAUTHENTICATED'
        ) {
            location.replace(`${location.origin}/auth`)
        }
      }

      if (networkError) {
        console.log(`[Network error]: ${networkError}`)
      }
    }
  )
