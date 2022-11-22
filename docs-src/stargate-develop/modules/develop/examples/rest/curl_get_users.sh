curl -s -L -G '{base_rest_url}{base_rest_api}/{rkeyspace}/{rtable}' \
   -H "X-Cassandra-Token: {auth_token}" \
   -H "Content-Type: application/json" \
   -H "Accept: application/json" \
   --data-urlencode 'where={
     "firstname": {"$in": ["Janesha","Mookie"]}
   }'
