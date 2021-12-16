curl -s --location --request POST '{base_url}{base_rest_schema}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "{rkeyspace}"
}'
