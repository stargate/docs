#!/bin/bash

# MUST DO THE URL AND PATH SUBSTITUTIONS BEFORE RUNNING THE TESTS

base_url=http://localhost:8082
base_api_schema_path=/v2/schemas
base_api_path=/v2/namespaces
namespaceName=myworld
collectionName=fitness

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{my_base_url}#$base_url#; s#{my_base_api_schema_path}#$base_api_schema_path#; s#{my_base_api_path}#$base_api_path#; s#{my_namespace}#$namespaceName#; s#{my_collection}#$collectionName#" $FILE > $FILE.tmp;
      chmod 755 $FILE.tmp;
    fi
done

# SET THE AUTH_TOKEN FOR ALL THE OTHER COMMANDS

export AUTH_TOKEN=$(curl -s -L -X POST 'http://localhost:8081/v1/auth' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "cassandra",
    "password": "cassandra"
}' | jq -r '.authToken')

echo "drop ns to clear all data: "
#./curl_drop_ns.sh.tmp

# RUN THE DDL

echo "create namespace "
# this test won't work when many namespaces/keyspaces exist
./curl_create_ns.sh.tmp | jq -r '.name | test("myworld")'

# HOW TO TEST THE ALTERNATE CREATE_NS?? NEED TO FIGURE IT OUT
#./curl_simple_ns.sh.tmp | jq -r '.name | test("myworld")'
#echo "create ns_dcs: "
#./curl_ns_dcs.sh.tmp | jq -r '.name | test("myworld_dcs")'

# CHECK EXISTENCE
echo "check existence"
#test $(./curl_check_ns_exists.sh.tmp | jq '.| length') -eq 1 && echo "PASS" || echo "FAIL"
# this test won't work when many namespaces/keyspaces exist
./curl_check_ns_exists.sh.tmp | jq -r '.data[].name | test("myworld")'
echo "check ns myworld"
./curl_get_particular_ns.sh.tmp | jq '.'> HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_particular_ns.result)

# RUN THE DML
echo "create collection/documents"
echo "write noDocId"
./curl_post_noDocId.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_post_noDocId.result)
echo "put janet"
./curl_put_janet.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_put_janet.result)
echo "put joey"
./curl_put_joey_subdoc.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_put_joey_subdoc.result)

echo "get all docs"
./curl_get_all_docs.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_all_docs.result)
echo "get one docs"
./curl_get_one_doc.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_one_doc.result)
echo "get doc where"
./curl_get_doc_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_doc_where.result)
echo "get doc multi-where"
./curl_get_doc_mult_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_doc_mult_where.result)
echo "get subdoc where"
./curl_get_subdoc_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_subdoc_where.result)
echo "get subdoc multi-where"
./curl_get_subdoc_mult_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_subdoc_mult_where.result)
echo "get joey"
./curl_get_joey.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_joey.result)
echo "get joey weights"
./curl_get_joey_weights.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_joey_weights.result)
echo "post martha"
./curl_post_martha.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_post_martha.result)
echo "get document path wildcard"
./curl_get_json_path_wildcard.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_json_path_wildcard.result)

echo "patch janet"
./curl_patch_janet.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_janet.result)
echo "check patch janet"
./curl_patch_check_janet.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_check_janet.result)
echo "patch partial"
./curl_patch_partial.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_partial.result)
echo "check patch partial"
./curl_patch_check_partial.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_check_partial.result)
echo "patch subdoc"
./curl_patch_subdoc.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_subdoc.result)
echo "check patch subdoc"
./curl_patch_check_subdoc.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_check_subdoc.result)

# DROP/DELETE ALL SCHEMA
#./curl_delete_doc.sh.tmp
#./curl_delete_doc_where.sh.tmp
#./curl_delete_collection.sh.tmp
#./curl_delete_ns.sh.tmp

# CLEAN UP tmp files
rm *.tmp; rm HOLD;
