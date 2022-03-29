curl --location --request POST {base_url}{base_gql_schema} \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation createIndexes {\n  book: createIndex(\n    keyspaceName:\"library\",\n    tableName:\"book\",\n    columnName:\"author\",\n    indexName:\"author_idx\"\n  )\n  reader: createIndex(\n      keyspaceName:\"library\",\n      tableName:\"reader\",\n      columnName:\"birthdate\",\n      indexName:\"reader_bdate_idx\"\n  )\n  reader2: createIndex(\n      keyspaceName:\"library\",\n      tableName:\"reader\",\n      columnName:\"email\",\n      indexName:\"reader_email_idx\"\n  )\n}","variables":{}}'
