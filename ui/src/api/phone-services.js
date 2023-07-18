import { apolloClient } from "./my-apollo-client"
import { queryGetCatalog } from "../api/gql/query"
import { mutateAddCatalogEntry, mutateEditCatalogEntry } from './gql/mutation'
import { format } from 'date-fns'

class PhoneServices {
    async getCatalog() {
        try {
            const response = await apolloClient.query({
                query: queryGetCatalog,
                fetchPolicy: 'no-cache'
            })
            if (response) {
                return response?.data?.get_catalog
            }
            return []
        }
        catch(e) {
            console.log(e)
            return []
        }
    }
    async add(data) {
        try {
            const response = await apolloClient.mutate({
                mutation: mutateAddCatalogEntry,
                variables: {
                    entry: {
                        ...data,
                        birthdate: data.birthdate ? format(new Date(data.birthdate), 'yyyy.MM.dd') : null,
                        termination_date: data.termination_date ? format(new Date(data.termination_date), 'yyyy.MM.dd') : null
                    }
                }
            })
            if (response) {
                return response?.data?.add_catalog_entry
            }
            return null
        }
        catch(e) {
            console.log(e)
            return null
        }
    }
    async edit(id, data) {
        try {
            const response = await apolloClient.mutate({
                mutation: mutateEditCatalogEntry,
                variables: {
                    id,
                    entry: {
                        ...data,
                        birthdate: data.birthdate ? format(new Date(data.birthdate), 'yyyy.MM.dd') : null,
                        termination_date: data.termination_date ? format(new Date(data.termination_date), 'yyyy.MM.dd') : null
                    }
                }
            })
            if (response) {
                return response?.data?.edit_catalog_entry
            }
            return null
        }
        catch(e) {
            console.log(e)
            return null
        }
    }
}

export default PhoneServices