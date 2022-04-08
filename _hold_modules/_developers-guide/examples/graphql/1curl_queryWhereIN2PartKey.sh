curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query fetchLibCollIn {\n  libCollIn(type:[ \"photo\", \"book\" ], lib_id: [ 12345, 12543 ]) {\n      type\n      lib_id\n      lib_name\n  }\n}","variables":{}}'
