curl -s -L -X GET 'http://localhost:8082/v2/keyspaces/users_keyspace/users/Janesha/Doesha?fields=firstname,lastname,top_three_tv_shows \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
