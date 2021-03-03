curl --location --request POST --url {my_base_url}{my_base_api_path}/{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"# query the author to see the UDT\nquery getReaderWithUDT{\n  reader(value: { name:\"Allen Ginsberg\" user_id: \"e0ed81c3-0826-473e-be05-7de4b4592f64\" }) {\n    values {\n      name\n      birthdate\n      addresses {\n        street\n        city\n        zip\n      }\n    }\n  }\n}","variables":{}}'
