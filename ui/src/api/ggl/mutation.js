import { gql } from "@apollo/client"

const mutateAddCatalogEntry = gql`
    mutation add_catalog_entry ($entry: CatalogEntryInput!) {
        add_catalog_entry (entry: $entry) {
            id
        }
    }
`
const mutateEditCatalogEntry = gql`
    mutation edit_catalog_entry ($id: ID!, $entry: CatalogEntryInput!) {
        edit_catalog_entry (id: $id, entry: $entry) {
            id
        }
    }
`

export {
    mutateAddCatalogEntry,
    mutateEditCatalogEntry
}