curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertjanedoe {\n  insertReader(\n    reader: {\n      name: \"Jane Doe\"\n      user_id: \"f02e2894-db48-4347-8360-34f28f958590\"\n      reviews: [\n        {\n          bookTitle: \"Moby Dick\"\n          comment: \"It'\''s about a whale.\"\n          rating: 3\n          reviewDate: \"2021-04-01\"\n        }\n        {\n          bookTitle: \"Native Son\"\n          comment: \"An awesome work of art.\"\n          rating: 5\n          reviewDate: \"2021-01-01\"\n        }\n      ]\n    }\n  ) {\n    name\n    user_id\n  }\n}","variables":{}}'
