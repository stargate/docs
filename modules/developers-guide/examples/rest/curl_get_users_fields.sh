curl -s -L -X GET '{base_url}{base_rest_schema}/{rkeyspace}/{rtable}/Janesha/Doesha?fields=firstname,lastname,top_three_tv_shows \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
