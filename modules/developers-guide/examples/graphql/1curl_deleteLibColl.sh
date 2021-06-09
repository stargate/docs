curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation deleteDHM {\n  deleteLibCollection(libColl: { type:\"book\", lib_id: 66666 })\n}","variables":{}}'
