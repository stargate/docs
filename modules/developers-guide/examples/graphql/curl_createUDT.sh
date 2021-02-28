curl --location --request POST --url {my_base_url}{my_base_api_schema_path} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation createAddressUDT {\n  createType(\n    keyspaceName: \"library\"\n    typeName: \"address_type\"\n    fields: [\n      { name: \"street\", type: { basic: TEXT } }\n      { name: \"city\", type: { basic: TEXT } }\n      { name: \"state\", type: { basic: TEXT } }\n      { name: \"zip\", type: { basic: TEXT } }\n    ]\n  )\n}","variables":{}}'
