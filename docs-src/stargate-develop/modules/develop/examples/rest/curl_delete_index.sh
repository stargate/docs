curl -s --location \
--request DELETE {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes/fav_books_idx \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json"
