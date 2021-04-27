curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertCSRMPhoto {\n  insertLibCollection(libColl: { type: \"photo\", lib_id: 12543, lib_name: \"West Sacramento Historical Society\" }) {\n    type\n    lib_id\n    lib_name\n  }\n}\n","variables":{}}'
