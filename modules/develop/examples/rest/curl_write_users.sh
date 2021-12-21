curl -s --location --request POST '{base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "Mookie",
    "lastname": "Betts",
    "email": "mookie.betts@gmail.com",
    "favorite color": "blue"
}'
curl -s --location --request POST '{base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "Janesha",
    "lastname": "Doesha",
    "email": "janesha.doesha@gmail.com",
    "favorite color": "grey"
}'
