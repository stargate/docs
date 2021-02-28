curl --location --request POST --url {my_base_url}{my_base_api_path}{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"# get one book using the primary key title with a value\nquery oneBook {\n    book (value: {title:\"Moby Dick\"}) {\n      values {\n        title\n        author\n      }\n    }\n}","variables":{}}'
