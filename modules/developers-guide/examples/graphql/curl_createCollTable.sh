curl --location --request POST --url {my_base_url}{my_base_api_schema_path} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation createCollTable {\n  badges: createTable (\n    keyspaceName:\"library\",\n    tableName: \"badges\",\n    partitionKeys: [\n      {name: \"btype\", type: {basic:TEXT}}\n    ],\n    ifNotExists:true,\n    values: [\n      {name: \"earned\", type:{basic: DATE}},\n      {name: \"category\", type:{basic:SET, info:{ subTypes: [ { basic: TEXT }]}}}\n    ]\n  )\n}","variables":{}}'
