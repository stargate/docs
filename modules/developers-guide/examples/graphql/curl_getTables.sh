curl --location --request POST --url {my_base_url}{my_base_api_schema_path} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query GetTables {\n  keyspace(name: \"library\") {\n      name\n      tables {\n          name\n          columns {\n              name\n              kind\n              type {\n                  basic\n                  info {\n                      name\n                  }\n              }\n          }\n      }\n  }\n}","variables":{}}'
