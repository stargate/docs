curl --location --request POST --url {my_base_url}{my_base_api_path}{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertBookWithOption {\n  nativeson: insertbook(value: {title:\"Native Son\", author:\"Richard Wright\"}, options: {consistency: LOCAL_QUORUM, ttl:86400}) {\n    value {\n      title\n    }\n  }\n}","variables":{}}'
