curl -X POST localhost:8081/v1/auth/token/generate \
--header "Content-Type: application/json" \
--data '{"key":"cassandra","secret":"cassandra"}'
