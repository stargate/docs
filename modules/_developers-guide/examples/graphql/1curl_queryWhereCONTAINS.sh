curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query fetchReadersCONTAINS {\n  readerCONTAINS( reviews: {\n          bookTitle: \"Moby Dick\"\n          comment: \"It'\''s about a whale.\"\n          rating: 3\n          reviewDate: \"2021-04-01\"\n        } ) {\n    name\n    user_id\n    birthdate\n  }\n}","variables":{}}'
