curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query fetchJane {\n  reader(name: \"Jane Doe\", user_id: \"f02e2894-db48-4347-8360-34f28f958590\") {\n    name\n    user_id\n    birthdate\n    email\n    address {\n      street\n      city\n      state\n      zipCode\n    }\n    reviews {\n      bookTitle\n      comment\n      rating\n      reviewDate\n    }\n  }\n}\nquery fetchHerman {\n  reader(\n    name: \"Herman Melville\"\n    user_id: \"e0ec47e1-2b46-41ad-961c-70e6de629810\"\n  ) {\n    name\n    user_id\n    birthdate\n    email\n    address {\n      street\n      city\n      state\n      zipCode\n    }\n  }\n}","variables":{}}'
