curl -L -X  DELETE 'localhost:8082/v2/namespaces/myworld/collections/fitness?where=\{"id":\{"$eq":"some%2Dstuff"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
