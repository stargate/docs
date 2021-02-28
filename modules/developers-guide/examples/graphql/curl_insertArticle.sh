curl --location --request POST --url {my_base_url}{my_base_api_path}{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertArticle {\n  magarticle: insertarticle(value: {title:\"How to use GraphQL\", authors: [\"First author\", \"Second author\"], mtitle:\"Database Magazine\"}) {\n    value {\n      title\n      mtitle\n      authors\n    }\n  }\n}","variables":{}}'
