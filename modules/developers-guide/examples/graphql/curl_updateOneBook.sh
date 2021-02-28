curl --location --request POST --url {my_base_url}{my_base_api_path}{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation updateOneBook {\n  moby: updatebook(value: {title:\"Moby Dick\", author:\"Herman Melville\", isbn: \"9780140861723\"}, ifExists: true ) {\n    value {\n      title\n      author\n      isbn\n    }\n  }\n}","variables":{}}'
