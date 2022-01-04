curl -s -G -L {base_url}{base_rest_schema}/{rkeyspace}/{rtable} \
   -H  "X-Cassandra-Token: $AUTH_TOKEN" \
   -H  "Content-Type: application/json" \
   --data-urlencode 'where={
     "firstname": {"$eq": "Janesha"},
     "lastname": {"$eq": "Doesha"},
     "current_country": {"$eq": "( 'France', '2016-01-01', '2020-02-02' )"}
   }'
