curl --location --request POST --url {my_base_url}{my_base_api_path}/{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertReaderWithUDT{\n  ag: insertreader(\n    value: {\n      user_id: \"e0ed81c3-0826-473e-be05-7de4b4592f64\"\n      name: \"Allen Ginsberg\"\n      birthdate: \"1926-06-03\"\n      addresses: [{ street: \"Haight St\", city: \"San Francisco\", zip: \"94016\" }]\n    }\n  ) {\n    value {\n      user_id\n      name\n      birthdate\n      addresses {\n        street\n        city\n        zip\n      }\n    }\n  }\n }","variables":{}}'
