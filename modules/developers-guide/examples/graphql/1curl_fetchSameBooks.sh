curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query fetchSameBooks {\n  books(title: \"Groundswell\") {  \n    data {\n      title,\n      author\n    },\n    pagingState\n }\n}\n","variables":{}}'
