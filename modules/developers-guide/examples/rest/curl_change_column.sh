curl -L \
-X PUT "http://localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns/firstname" \
-H 'X-Cassandra-Token: $AUTH_TOKEN' \
-H 'Content-Type: application/json' \ 
 -d '{  
 "name": "first",  
 "typeDefinition": "varchar"
}'
