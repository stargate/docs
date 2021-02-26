curl -L -X  GET '{my_base_url}{my_base_api_path}/namespaces/myworld/collections/fitness?where=\{"firstname":\{"$eq":"Janet"\},"lastname":\{"$eq":"Doe"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'
