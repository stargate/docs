curl --location --request DELETE {base_rest_url}{base_rest_schema}/{rkeyspace}/types/address_type \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json'
