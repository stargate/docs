curl --location --request POST 'localhost:8080/graphql-schema' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation createAddressUDT {\n  createType(\n    keyspaceName: \"users_keyspace\"\n    typeName: \"address_type\"\n    fields: [\n      { name: \"street\", type: { basic: TEXT } }\n      { name: \"city\", type: { basic: TEXT } }\n      { name: \"state\", type: { basic: TEXT } }\n      { name: \"zip\", type: { basic: TEXT } }\n    ]\n  )\n}","variables":{}}'
