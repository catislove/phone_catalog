import { gql } from "@apollo/client";

const queryGetCatalog = gql`
  query get_catalog  {
    get_catalog {
        id
        first_name
        last_name
        middle_name
        gender
        birthdate
        phone_number
        mail
        address
        termination_date
    }
  }
`

export {
  queryGetCatalog
}