curl -s -L -X GET 'http://localhost:8082/v2/keyspaces/users_keyspace/users?where=\{"firstname":\{"$eq":"Janesha"\},"favorite_books":\{"$contains":"Emma"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
