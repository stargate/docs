curl --location --request POST 'https://8319febd-e7cf-4595-81e3-34f45d332d2a-us-east1.apps.astra.datastax.com/api/graphql-schema' \
--header 'X-Cassandra-Token: AstraCS:txZMMdsloiGKPZhosGAnMsHY:0d54c888f49f4c5f3201a057c5e7124c30fa573a687fd16f23cb9c98167c26c8' \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation dropIndexBdate {\n\n  reader: dropIndex(\n      keyspaceName:\"library\",\n      indexName:\"reader_bdate_idx\"\n  )\n}","variables":{}}'
