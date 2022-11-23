curl -s --location \
--request POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
  "column": "favorite_books",
  "name": "fav_books_idex",
  "ifNotExists": true
}'

curl -s --location \
--request POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
  "column": "top_three_tv_shows",
  "name": "tv_idx",
  "ifNotExists": true
}'

curl -s --location \
--request POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
  "column": "evaluations",
  "name": "evalv_idx",
  "ifNotExists": true
}'

curl -s --location \
--request POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
  "column": "evaluations",
  "name": "evalk_idx",
  "kind": "KEYS",
  "ifNotExists": true
}'

curl -s --location \
--request POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
  "column": "evaluations",
  "name": "evale_idx",
  "kind": "ENTRIES",
  "ifNotExists": true
}'

curl -s --location \
--request POST {base_rest_url}{base_rest_schema}/{rkeyspace}/tables/{rtable}/indexes \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
  "column": "current_country",
  "name": "country_idx",
  "ifNotExists": true
}'
