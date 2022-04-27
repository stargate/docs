curl -s -L -G {base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable} \
   -H  "X-Cassandra-Token: {auth_token}" \
   -H  "Content-Type: application/json" \
   -H "Accept: application/json" \
   --data-urlencode 'where={
     "firstname": {"$eq": "Janesha"},
     "lastname": {"$eq": "Doesha"},
     "top_three_tv_shows": {"$contains": "The Magicians"}
   }'
