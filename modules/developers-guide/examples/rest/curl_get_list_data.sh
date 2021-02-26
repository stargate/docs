curl -s -L -G {my_base_url}{my_base_api_path}/keyspaces/users_keyspace/users \
   -H  "X-Cassandra-Token: $AUTH_TOKEN" \
   -H  "Content-Type: application/json" \
   -H "Accept: application/json" \
   --data-urlencode 'where={
     "firstname": {"$eq": "Janesha"},
     "lastname": {"$eq": "Doesha"},
     "top_three_tv_shows": {"$contains": "The Magicians"}
   }'
