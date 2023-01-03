curl -s --location \
--request POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
  "column": "favorite_books",
  "name": "fav_books_idx",
  "ifNotExists": true
}'
