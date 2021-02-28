curl -s --location \
--request DELETE {my_base_url}{my_base_api_schema_path}/{my_keyspace}/tables/{my_table} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
