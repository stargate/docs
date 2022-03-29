curl -s -L -X POST {base_rest_url}{base_rest_schema}/{rkeyspace}/types \
-H "X-Cassandra-Token: {auth_token}" \
-H 'Content-Type: application/json' \
-d '{
  "name": "address_type",
  "fields":[
    {
      "name": "street",
      "typeDefinition": "text"
    },
    {
      "name": "city",
      "typeDefinition": "text"
    },
    {
      "name": "state",
      "typeDefinition": "text"
    },
    {
      "name": "zip",
      "typeDefinition": "text"
    }
  ]
}'
