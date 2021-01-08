curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096" \
-H  "Content-Type: application/json" \
-d "{\"firstname\": \"Janesha\",
  \"lastname\": \"Doesha\",
  \"favorite color\": \"grey\",
  \"favorite_books\": \"{ 'Emma', 'The Color Purple' }\"
}"
