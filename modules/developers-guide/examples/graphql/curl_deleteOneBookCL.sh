curl --location --request POST --url {my_base_url}{my_base_api_path}{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation deleteOneBookCL {\n  PaP: deletebook(value: {title:\"Pride and Prejudice\", author: \"Jane Austen\"}, ifExists: true, options: {consistency: LOCAL_ONE }) {\n    value {\n      title\n    }\n  }\n}","variables":{}}'
