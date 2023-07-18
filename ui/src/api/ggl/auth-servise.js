import { apolloClient } from "./my-apollo-client"
import { queryUser } from "../api/gql/user"

const ROLE_VIEW = 'can_read'
const ROLE_ADD = 'can_add'
const ROLE_EDIT = 'can_edit'
const ROLE_DOWNLOAD = 'can_report'

const roles = [
    {
        role: 'admin',
        permissions: [ROLE_VIEW, ROLE_ADD, ROLE_EDIT, ROLE_DOWNLOAD]
    },
    {
        role: 'editor',
        permissions: [ROLE_VIEW, ROLE_EDIT, ROLE_DOWNLOAD]
    },
    {
        role: 'reader',
        permissions: [ROLE_VIEW, ROLE_DOWNLOAD]
    }
]
