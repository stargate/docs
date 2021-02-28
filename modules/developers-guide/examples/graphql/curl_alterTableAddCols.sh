curl --location --request POST --url {my_base_url}{my_base_api_schema_path} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation alterTableAddCols {\n  alterTableAdd(\n    keyspaceName:\"library\",\n    tableName:\"book\",\n    toAdd:[\n      { name: \"isbn\", type: { basic: TEXT } }\n      { name: \"language\", type: {basic: TEXT} }\n      { name: \"pub_year\", type: {basic: INT} }\n      { name: \"genre\", type: {basic:SET, info:{ subTypes: [ { basic: TEXT } ] } } }\n      { name: \"format\", type: {basic:SET, info:{ subTypes: [ { basic: TEXT } ] } } }\n    ]\n  )\n}","variables":{}}'
