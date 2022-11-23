curl --location --request GET {base_rest_url}{base_rest_schema}/{rkeyspace}/types \
-H "X-Cassandra-Token: {auth_token}" \
-H 'accept: application/json' \
-H 'content-type: application/json'
