curl --location --request POST --url {my_base_url}{my_base_api_path}/library \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insert2Books {\n  moby: insertbook(value: {title:\"Moby Dick\", author:\"Herman Melville\"}) {\n    value {\n      title\n    }\n  }\n  catch22: insertbook(value: {title:\"Catch-22\", author:\"Joseph Heller\"}) {\n    value {\n      title\n    }\n  }\n}","variables":{}}'

#ASTRA_CLUSTER_ID=8319febd-e7cf-4595-81e3-34f45d332d2a
#ASTRA_REGION=us-east1
#ASTRA_USERNAME=polandll
#ASTRA_PASSWORD=12345abcd
#  --url https://$ASTRA_CLUSTER_ID-$ASTRA_CLUSTER_REGION.apps.astra.datastax.com/api/graphql/{keyspaceName} \
#  --header 'accept: application/json' \
#  --header 'content-type: application/json' \
#  --header 'x-cassandra-request-id: {unique-UUID}' \
#  --header "x-cassandra-token: $ASTRA_AUTHORIZATION_TOKEN" \
#  --data-raw '{"query":"mutation {
#    objectName: insertName(
#      data:{
#        columnName1:\"value1 A1\"
#        columnName2:\"value2 A.\"
#        columnName3: \"value3\"
#        columnName4: \"value1\"}){
#     value {
#      columnName1
#      columnName2
#      columnName3
#      columnName4
#    }
#   }
#}",
#"variables":{}}'
