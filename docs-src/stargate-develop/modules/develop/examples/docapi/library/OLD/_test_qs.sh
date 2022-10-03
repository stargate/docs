#!/bin/bash

# SET THE AUTH_TOKEN FOR ALL THE OTHER COMMANDS

export AUTH_TOKEN=$(curl -s -L -X POST 'http://localhost:8081/v1/auth' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "cassandra",
    "password": "cassandra"
}' | jq -r '.authToken')

echo "drop ns to clear all data: "
#./curl_drop_ns.sh

# RUN THE DDL

echo "create namespace "
./curl_create_ns.sh | jq -r '.name | test("myworld")'

# CHECK EXISTENCE
echo "check existence"
#test $(./curl_check_ns_exists.sh | jq '.| length') -eq 1 && echo "PASS" || echo "FAIL"
./curl_check_ns_exists.sh | jq -r '.data[].name | test("myworld")'
echo "check ns myworld"
./curl_get_particular_ns.sh | jq '.'> HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_particular_ns.result)

# RUN THE DML
echo "create collection/documents"
echo "write noDocId"
./curl_post_noDocId.sh|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_post_noDocId.result)
echo "put janet"
./curl_put_janet.sh|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_put_janet.result)

echo "get all docs"
./curl_get_all_docs.sh|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_all_docs.result)
echo "get one docs"
./curl_get_one_doc.sh|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_one_doc.result)
echo "get doc where"
./curl_get_doc_where.sh|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_doc_where.result)
echo "get doc multi-where"

echo "patch janet"
./curl_patch_janet.sh| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_janet.result)
echo "check patch janet"
./curl_patch_check_janet.sh| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_check_janet.result)

# DROP/DELETE ALL SCHEMA
#./curl_delete_doc.sh
#./curl_drop_ns.sh
