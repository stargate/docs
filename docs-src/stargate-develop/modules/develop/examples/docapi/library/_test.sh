#!/bin/bash

# Attribution for functions that I am using: 
# https://github.com/hitta-skyddsrum/services/blob/78db77d36a5eddef8ef8b4f8178b64e63e0171d9/e2e/shelters.sh.tmp

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

Errors=0

Green='\033[0;32m'
Red='\033[0;31m'
Color_Off='\033[0m'

Check_Mark='\xE2\x9C\x94'

assert_equals () {
  if [ "$1" = "$2" ]; then
    echo -e "$Green $Check_Mark Success $Color_Off"
  else
    echo -e "$Red Failed $Color_Off"
    echo -e "$Red Expected $1 to equal $2 $Color_Off"
    Errors=$((Errors  + 1))
  fi
}

get_json_value () {
  echo $1 | jq -r $2
}

get_json_array_length () {
  echo $1 | jq ". | length"
}

get_json_select () {
  echo $1 | jq '.[] | select($2==$3)'
}

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
response=$(./curl-ns-simple.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "test"
echo "Set replicas on ns"
response=$(./curl-ns-set-replicas.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "test"
./curl-ns-delete.sh.tmp
# There is no response from a delete, so nothing to assert
# response=$(./curl-ns-delete.sh.tmp)
# assert_equals "$(get_json_value "$response" ".name")" "test"
echo "Create namespace with DCs"
response=$(./curl-ns-dcs.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "test-dcs"
./curl-ns-delete-dcs.sh.tmp
# response=$(./curl-ns-delete-dcs.sh.tmp)
# assert_equals "$(get_json_value "$response" ".name")" "test-dcs"

# NOW RUN THE CREATE NAMESPACE FOR THE REST OF THE TEST
echo "Create namespace for test"
response=$(./curl-ns-create.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "test"

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
# IF A SPECIFIC DOCUMENT-ID IS REQUIRED, PUT IS USED, NOT POST
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

############# BIG PATCH WARNING: 
############# One thing to note: PATCH expects that the data present at the path is 
############# already a JSON object {}. if you have an array or some scalar value, 
############# those values will be blown away and overwritten

# MODIFY DOCUMENTS
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

# WRITE INSERTS WITH DOCUMENT-PATH
# DOCUMENT-PATCH DEFINES WHERE IN A DOCUMENT YOU WANT TO EXECUTE SOMETHING
# EX: PUT {{base_rest_url}}{{base_doc_api}}/{{namespace}}/collections/{{collection}}/{{bookdocid}}/book/genre
echo "Put a document with document-path; replaces current data"
./curl-document-put-book-with-path.sh.tmp | jq -r '.'
echo "Patch a document with document-path - overwrites"
./curl-document-patch-book-with-path.sh.tmp | jq -r '.'

# MODIFY DOCUMENTS WITH BUILT-IN FUNCTIONS WITH DOCUMENT-PATH
# FIRST, VIEW THE BUILT-IN FUNCTIONS
echo "Get built-in functions for a particular namespace"
./curl-ns-get-functions.sh.tmp | jq -r '.'
# PUSH AND POP REQUIRE A DOCUMENT-PATH
echo "Push an array element into a document at a document-path"
./curl-document-post-push-book.sh.tmp | jq -r '.'
echo "Look at the array"
./curl-document-get-array-change.sh.tmp | jq -r '.'
echo "Pop an array element into a document at a document-path"
./curl-document-post-pop-book.sh.tmp | jq -r '.'
echo "Look at the array"
./curl-document-get-array-change.sh.tmp | jq -r '.'

# LIST DOCUMENTS - SEARCHING FOR DOCUMENTS IN A COLLECTION
echo "Get all documents"
./curl-document-get-all.sh.tmp | jq -r '.'

### DECORATIONS FOR GET DOCUMENTS: PAGING-SIZE, PAGING-STATE, FIELDS
echo "Get 6 documents with paging-size set"
./curl-document-get-6.sh.tmp | jq -r '.'
echo "Get a document with fields"
./curl-document-get-one-with-fields.sh.tmp | jq '.'
#############echo "Get documents with paging-state set"
#############get documents with paging-state 
### SEARCH COLLECTION FOR DOCUMENTS WITH WHERE CLAUSE
echo "Get all documents where name eq a particular reader"
./curl-document-get-where-name.sh.tmp | jq -r '.'
echo "Get all documents where name eq a particular reader with fields"
./curl-document-get-where-name-eq.sh.tmp | jq -r '.'
echo "Get all documents where name ne using $and a particular reader"
./curl-document-get-where-name-ne-and.sh.tmp | jq -r '.'
echo "Get all documents where name ne using multi a particular reader"
./curl-document-get-where-name-ne-mult.sh.tmp | jq -r '.'
echo "Get all documents where the address.primary,secondary.city eq a value"
############# NEED $OR AND $NOT EXAMPLES
./curl-document-get-where-address-city.sh.tmp | jq -r '.'
echo "Get all documents where book title eq a particular book in reviews"
./curl-document-get-where-book-eq.sh.tmp | jq -r '.'
echo "Get all documents where the reader rating is gt 3 and lte 5"
./curl-document-get-where-rating-gt3-lte5.sh.tmp | jq -r '.'
echo "Get a document where names are in field"
./curl-document-get-where-name-in.sh.tmp | jq -r '.'
echo "Get a document where names are in field but one name fails"
./curl-document-get-where-name-in-1fail.sh.tmp | jq -r '.'
echo "Get a document where names are not in ($nin) field"
./curl-document-get-where-name-nin.sh.tmp | jq -r '.'

# LIST A PARTICULAR DOCUMENT USING DOCUMENTID AND CONDITIONS
echo "Get one particular document using documentId"
./curl-document-get-one.sh.tmp | jq -r '.'
# LIST DOCUMENTS - SEARCHING FOR DATA IN A DOCUMENT
################## /book/title?WHERE title = "Native Son"
### SEARCH USING DOCUMENTID WITH WHERE CLAUSE
# CANNOT SEARCH ON ARRAY DIRECTLY, since * or [*] cannot BE THE LAST IN A PATH
echo "Get a document where a value is contained in an array"
./curl-document-get-where-contains.sh.tmp | jq -r '.'

echo "Get a document with a where wildcard on book format"
./curl-document-get-wildcard.sh.tmp | jq -r '.'
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
