curl -s --location \
--request DELETE {my_base_url}{my_base_api_schema_path}/keyspaces/users_keyspace/tables/users/columns/email \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
