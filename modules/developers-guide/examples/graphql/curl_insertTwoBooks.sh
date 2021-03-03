curl --location --request POST --url {my_base_url}{my_base_api_path}/{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insert2Books {\n  moby: insertbook(value: {title:\"Moby Dick\", author:\"Herman Melville\"}) {\n    value {\n      title\n    }\n  }\n  catch22: insertbook(value: {title:\"Catch-22\", author:\"Joseph Heller\"}) {\n    value {\n      title\n    }\n  }\n}","variables":{}}'
