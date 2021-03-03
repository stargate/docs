curl --location --request POST --url {my_base_url}{my_base_api_schema_path} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation createMapTable {\n  badge: createTable (\n    keyspaceName:\"library\",\n    tableName: \"badge\",\n    partitionKeys: [\n      { name: \"user_id\", type: {basic: UUID} },\n      { name: \"badge_type\", type: {basic:TEXT} }\n    ]\n    clusteringKeys: [\n      { name: \"badge_id\", type: { basic: INT} }\n    ],\n    ifNotExists:true\n    values: [ \n        { name: \"earned\", type:{basic:MAP, info:{ subTypes: [ { basic: TEXT }, {basic: DATE}]}} }\n    ]\n  )\n}","variables":{}}'
