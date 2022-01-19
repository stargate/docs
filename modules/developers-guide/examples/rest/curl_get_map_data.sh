curl -s -L -G https://localhost:8082/v2/keyspaces/users_keyspace/users \
   -H  "X-Cassandra-Token: $AUTH_TOKEN" \
   -H  "Content-Type: application/json" \
    -H "Accept: application/json" \
   --data-urlencode 'where={
     "firstname": {"$eq": "Janesha"},
     "lastname": {"$eq": "Doesha"},
     "evaluations": {"$containsKey": "2020"}
   }'
