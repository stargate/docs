curl --location --request POST --url {my_base_url}{my_base_api_path}/{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query ThreeBooks {\n  book(filter: { title: { in: [\"Native Son\", \"Moby Dick\", \"Catch-22\"] } } ) {\n      values {\n        title\n        author\n     }\n   }\n}","variables":{}}'
