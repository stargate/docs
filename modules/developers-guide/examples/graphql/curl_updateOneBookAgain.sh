curl --location --request POST --url {my_base_url}{my_base_api_path}/{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation updateOneBookAgain {\n moby: updatebook(value: {title:\"Moby Dick\", author:\"Herman Melville\", genre: [\"Drama\", \"Classic lit\"]}, ifExists: true ) {\n   value {\n     title\n     author\n     genre\n   }\n }\n}","variables":{}}'
