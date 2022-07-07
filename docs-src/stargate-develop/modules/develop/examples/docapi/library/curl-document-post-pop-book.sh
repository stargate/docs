curl --location --request POST '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/0bf03bf3-5aaa-451f-9e85-20ec086a4257/book/genre/function' \
--header "X-cassandra-token: {auth_token" \
--header 'Content-Type: application/json' \
--data-raw '{
 "operation": "$pop"
}'
