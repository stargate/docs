#!/bin/bash

# Attribution for functions that I am using: https://github.com/hitta-skyddsrum/services/blob/78db77d36a5eddef8ef8b4f8178b64e63e0171d9/e2e/shelters.sh.tmp

# MUST SET THE URL AND PATH SUBSTITUTIONS BEFORE RUNNING THE TESTS

base_doc_url=http://localhost:8082
base_doc_schema=/v2/schemas/namespaces
base_doc_api=/v2/namespaces
namespace=test
dcnamespace=test-dcs
collection=library
collection2=library2
user1=Jane
user2=Amy
docid=2545331a-aaad-45d2-b084-9da3d8f4c311
bookdocid=native-son-doc-id

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
      s#{collection2}#$collection2#; \
      s#{user1}#$user1#; \
      s#{user1}#$user1#; \
      s#{user2}#$user2#; \
      s#{user2}#$user2#; \
      s#{docid}#$docid#; \
      s#{bookdocid}#$bookdocid#; \
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

# RUN THE DML
# CREATE COLLECTIONS
echo "Create collections" 
echo "Create an empty collection called library"
./curl-collection-post-empty.sh.tmp | jq -r '.'
echo "Create an empty collection called library2"
./curl-collection2-post-empty.sh.tmp | jq -r '.'

# CREATE COLLECTION WITH JSON SCHEMA
echo "Put JSON schema for a particular collection"
./curl-collection-put-json-schema.sh.tmp | jq -r '.'

# LIST COLLECTIONS
echo "Get all collections, to check that the 2 collections are made."
./curl-collection-get-all.sh.tmp|jq -r '.'
# LIST JSON SCHEMA FOR A PARTICULAR COLLECTION
echo "Get JSON schema for a particular collection"
./curl-collection-get-json-schema.sh.tmp | jq -r '.'

# INSERT DOCUMENTS
# IF A SPECIFIC DOCUMENT ID IS REQUIRED, PUT IS USED, NOT POST
echo "Create a document in the collection with a document-id with PUT"
./curl-document-put-withDocId.sh.tmp | jq -r '.' 
echo "Create a document in the collection with no document-id with POST"
./curl-document-post-noDocId.sh.tmp | jq -r '.' 
#> HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_post_noDocId.result)
echo "Create document for one reader with POST"
./curl-document-post-one-reader.sh.tmp|jq -r 
echo "Create document for one book with PUT"
./curl-document-put-one-book.sh.tmp|jq -r '.'
echo "Get one book document using documentId"
./curl-document-get-one-book.sh.tmp | jq -r '.'
echo "Create document for multiple readers with batch POST"
./curl-document-post-mult-readers.sh.tmp | jq -r '.'
# SET UP THE REST OF THE DATA FOR FURTHER WORK
echo "Create document for multiple books with batch POST"
./curl-document-post-mult-books.sh.tmp | jq -r '.'

# MODIFY DOCUMENTS
echo "Update/replace a document with a document-id with PUT"

# MODIFY DOCUMENTS WITH BUILT-IN FUNCTIONS
# FIRST, VIEW THE BUILT-IN FUNCTIONS
echo "Get built-in functions for a particular namespace"
./curl-ns-get-functions.sh.tmp | jq -r '.'
echo "Push an array element into a document"
./curl-document-post-push-book.sh.tmp | jq -r '.'
echo "Look at the array"
./curl-document-get-array-change.sh.tmp | jq -r '.'
echo "Pop an array element into a document"
./curl-document-post-pop-book.sh.tmp | jq -r '.'
echo "Look at the array"
./curl-document-get-array-change.sh.tmp | jq -r '.'

# WRITE MORE INSERTS WITH PUTS and PATCHES
echo "Replace a document with a PUT using document-id"
./curl-document-put-replace.sh.tmp | jq -r '.'
echo "Check that data is included"
./curl-document-get-one.sh.tmp | jq -r '.'
echo "Patch some information into a document using document-id"
./curl-document-patch.sh.tmp | jq -r '.'
echo "Check that data is included"
./curl-document-get-one.sh.tmp | jq -r '.'
echo "Patch some more information into a document using document-id"
./curl-document-patch2.sh.tmp | jq -r '.'
echo "Check that 2nd data is included"
./curl-document-get-one.sh.tmp | jq -r '.'

# DECORATIONS FOR POST/PUT/PATCH: TTL, PROFILING
echo "Patch some more information with profiling using document-id"
./curl-document-patch3-profiling.sh.tmp | jq -r '.'
echo "Check that 3rd data is included"
./curl-document-get-one.sh.tmp | jq -r '.'
echo "Patch some more information with TTL using document-id"
./curl-document-put-ttl.sh.tmp | jq -r '.'
echo "Check that 4th data is included"
./curl-document-get-one.sh.tmp | jq -r '.'

# INSERTS WITH DOCUMENT-PATH
# DOCUMENT-PATCH DEFINES WHERE IN A DOCUMENT YOU WANT TO EXECUTE SOMETHING
# EX: PUT {{base_rest_url}}{{base_doc_api}}/{{namespace}}/collections/{{collection}}/{{bookdocid}}/book/genre
echo "Put a document"
#############PUT replace data at a path in a document (document-path)
echo "Patch a document"
#############PATCH update data at a path in a document (document-path)
echo "Push to an array"
#############POST execute a built-in function (push, pop) in a document-path in a particular doc (uses document-id)
echo "Pop to an array"
#############POST execute a built-in function (push, pop) in a document-path in a particular doc (uses document-id)

############# BIG PATCH WARNING: 
############# One thing to note: PATCH expects that the data present at the path is 
############# already a JSON object {}. if you have an array or some scalar value, 
############# those values will be blown away and overwritten

# LIST DOCUMENTS - SEARCHING FOR DOCUMENTS IN A COLLECTION
echo "Get all documents"
./curl-document-get-all.sh.tmp | jq -r '.'
echo "Get one particular document using documentId"
./curl-document-get-one.sh.tmp | jq -r '.'

# DECORATIONS FOR GET DOCUMENTS: PAGING-SIZE, PAGING-STATE, FIELDS
echo "Get 6 documents with paging-size set"
./curl-document-get-6.sh.tmp | jq -r '.'
echo "Get a document with fields"
./curl-document-get-one-with-fields.sh.tmp | jq '.'
echo "Get documents with paging-state set"
#############get documents with paging-state 

# LIST DOCUMENTS USING WHERE CLAUSES

#############get a document with a doc id using where
#############search documents in a collection using a where

echo "Get a document where the address.primary,secondary.city matches a value"
./curl-document-get-where-address-city.sh.tmp | jq -r '.'
### EXAMPLES WITH ARRAYS BY NUMBER OR WILDCARD (*)
#### MULTI WHERE, WITH EXPLANATIONS OF WHEN OR WHERE THEY CAN BE USED

# LIST DOCUMENTS - SEARCHING FOR DATA IN A DOCUMENT

# LIST A DOCUMENT-PATH
#############get a path in a document (uses document-id)
#####Like GET /v2/namespaces/X/collections/Y/1/a/b
##### ./curl-document-get-array-change.sh IS THIS TYPE, USED ABOVE


# echo "put janet"
# ./curl_put_janet.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_put_janet.result)
# echo "put joey"
# ./curl_put_joey_subdoc.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_put_joey_subdoc.result)

# echo "get all docs"
# ./curl_get_all_docs.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_all_docs.result)
# echo "get one docs"
# ./curl_get_one_doc.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_one_doc.result)
# echo "get doc where"
# ./curl_get_doc_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_doc_where.result)
# echo "get doc multi-where"
# ./curl_get_doc_mult_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_doc_mult_where.result)
# echo "get subdoc where"
# ./curl_get_subdoc_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_subdoc_where.result)
# echo "get subdoc multi-where"
# ./curl_get_subdoc_mult_where.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_subdoc_mult_where.result)
# echo "get joey"
# ./curl_get_joey.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_joey.result)
# echo "get joey weights"
# ./curl_get_joey_weights.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_joey_weights.result)
# echo "post martha"
# ./curl_post_martha.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_post_martha.result)
# echo "get document path wildcard"
# ./curl_get_json_path_wildcard.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_get_json_path_wildcard.result)

# echo "patch janet"
# ./curl_patch_janet.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_janet.result)
# echo "check patch janet"
# ./curl_patch_check_janet.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_check_janet.result)
# echo "patch partial"
# ./curl_patch_partial.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_partial.result)
# echo "check patch partial"
# ./curl_patch_check_partial.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_check_partial.result)
# echo "patch subdoc"
# ./curl_patch_subdoc.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_subdoc.result)
# echo "check patch subdoc"
# ./curl_patch_check_subdoc.sh.tmp| jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/docapi_curl_patch_check_subdoc.result)




# DELETE ALL SCHEMA and DATA
#./curl-document-delete.sh.tmp
#./curl-document-delete-where.sh.tmp
#./curl-collection-delete.sh.tmp
#./curl-ns-delete.sh.tmp
