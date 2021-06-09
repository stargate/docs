curl --location --request POST '{base_url}{base_gql_api}/{gkeyspace}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertherman {\n  insertReader(\n    reader: {\n      name: \"Herman Melville\"\n      user_id: \"e0ec47e1-2b46-41ad-961c-70e6de629810\"\n      birthdate: \"1900-01-01\"\n      email: [\"hermy@mobydick.org\", \"herman.melville@gmail.com\"]\n      address: {\n        street: \"100 Main St\"\n        city: \"Boston\"\n        state: \"MA\"\n        zipCode: \"50050\"\n      }\n    }\n  ){\n    name\n    user_id\n  }\n}\n","variables":{}}'
