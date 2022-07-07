#!/bin/bash

# Attribution for functions that I am using: https://github.com/hitta-skyddsrum/services/blob/78db77d36a5eddef8ef8b4f8178b64e63e0171d9/e2e/shelters.sh.tmp

# MUST SET THE URL AND PATH SUBSTITUTIONS BEFORE RUNNING THE TESTS

base_doc_url=http://localhost:8082
base_doc_schema=/v2/schemas/namespaces
base_doc_api=/v2/namespaces
namespace=test
dcnamespace=test-dcs
collection=library
user1=Jane
user2=Amy
docid=2545331a-aaad-45d2-b084-9da3d8f4c311

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{base_doc_url}#$base_doc_url#; \
      s#{base_doc_schema}#$base_doc_schema#; \
      s#{base_doc_api}#$base_doc_api#; \
      s#{namespace}#$namespace#; \
      s#{dcnamespace}#$dcnamespace#; 
      s#{collection}#$collection#; \
      s#{user1}#$user1#; \
      s#{user1}#$user1#; \
      s#{user2}#$user2#; \
      s#{user2}#$user2#; \
      s#{docid}#$docid#; \
      s#{auth_token}#\$AUTH_TOKEN#;" \
      $FILE > $FILE.tmp;
      chmod 755 $FILE.tmp;
    fi
done

# SET THE AUTH_TOKEN FOR ALL THE OTHER COMMANDS

echo "Set auth token"
export AUTH_TOKEN=$(curl -s -L -X POST 'http://localhost:8081/v1/auth' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "cassandra",
    "password": "cassandra"
}' | jq -r '.authToken')

echo "Delete namespace to clear all data: "
./curl-ns-delete.sh.tmp

# RUN THE DDL

#TEST ALTERNATES FOR CREATE NAMESPACE FIRST
echo "Create simple namespace"
./curl-ns-simple.sh.tmp | jq -r '.name | test("test")'
echo "Set replicas on ns"
./curl-ns-set-replicas.sh.tmp | jq -r '.name | test("test")'
./curl-ns-delete.sh.tmp
echo "Create namespace with DCs"
./curl-ns-dcs.sh.tmp | jq -r '.'
#'.name | test("test-dcs")'
./curl-ns-delete-dcs.sh.tmp

# NOW RUN THE CREATE NAMESPACE FOR THE REST OF THE TEST

echo "Create namespace for test"
./curl-ns-create.sh.tmp | jq -r '.name | test("test")'

# LIST NAMESPACES
echo "Get all namespaces"
#test $(./curl-ns-get-all.sh.tmp | jq '.| length') -eq 1 && echo "PASS" || echo "FAIL"
./curl-ns-get-all.sh.tmp | jq -r '.'
#'.data[].name | test("test")'
echo "Get a particular namespace"
./curl-ns-get-particular.sh.tmp | jq '.'
#> HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_particular_ns.result)
echo "Get built-in functions for a particular namespace"
./curl-ns-get-functions.sh.tmp

# RUN THE DML

echo "Create collection/documents" 
echo "Create an empty collection called library"
./curl-collection-post-empty.sh.tmp | jq -r '.'
echo "List all collections, to check that library collection is made."
./curl-collection-get-all.sh.tmp|jq -r '.'
echo "Create a document in the collection with a document-id"
./curl-document-post-withDocId.sh.tmp | jq -r '.' 
echo "Create a document in the collection with no document-id"
./curl-document-post-noDocId.sh.tmp | jq -r '.' 
#> HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_post_noDocId.result)
echo "Create document for one reader"
./curl-document-post-one-reader.sh.tmp|jq -r '.' 
echo "Create document for multiple readers with batch"
./curl-document-post-mult-readers.sh.tmp | jq -r '.'
# SET UP THE REST OF THE DATA FOR FURTHER WORK
echo "Create document for multiple books with batch"
./curl-document-post-mult-books.sh.tmp | jq -r '.'

# LIST COLLECTIONS
echo "Get all collections"
./curl-collection-get-all.sh.tmp|jq -r '.'

# LIST DOCUMENTS
echo "Get all documents"
./curl-document-get-all.sh.tmp | jq -r '.'
echo "Get one particular document using documentId"
./curl-document-get-one.sh.tmp | jq -r '.'
echo "Get 6 documents with paging-size set"
./curl-document-get-6.sh.tmp | jq -r '.'

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

# COLLECTIONS WITH JSON SCHEMA
echo "Put JSON schema for a particular collection"
./curl-collection-put-json-schema.sh.tmp | jq -r '.'
echo "Get JSON schema for a particular collection"
./curl-collection-get-json-schema.sh.tmp | jq -r '.'


# DROP/DELETE ALL SCHEMA
#./curl_delete_doc.sh.tmp
#./curl_delete_doc_where.sh.tmp
#./curl-collection-delete.sh.tmp
#./curl-ns-delete.sh.tmp
