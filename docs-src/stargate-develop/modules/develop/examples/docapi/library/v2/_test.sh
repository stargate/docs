#!/bin/bash

# Attribution for functions that I am using: 
# https://github.com/hitta-skyddsrum/services/blob/78db77d36a5eddef8ef8b4f8178b64e63e0171d9/e2e/shelters.sh.tmp

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
# Several Antora asciidoc attributes are used throughout the examples
# The substitutions must be changed before the tests can be run,
# so the substitutions are done in files with the ".tmp" suffix for the test.

base_doc_url_v2=http://localhost:8180
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
readerdocid=John-Smith

for FILE in *;
 do
    if [[ "$FILE" != "_test"* ]]
    then
      gsed "s#{base_doc_url_v2}#$base_doc_url_v2#; \
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
      s#{readerdocid}#$readerdocid#; \
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

# DELETE THE NAMESPACE TO CLEAR ALL DATA
# There is no response from a delete, so nothing to assert
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
# There is no response from a delete, so nothing to assert
./curl-ns-delete.sh.tmp
echo "Create namespace with DCs"
response=$(./curl-ns-dcs.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "test-dcs"
# There is no response from a delete, so nothing to assert
./curl-ns-delete-dcs.sh.tmp

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

# NOTES from https://github.com/stargate/stargate/pull/1043
# Add an endpoint to allow writing multiple documents in a single request.
# Data sent to this endpoint is expected to be in JSON lines format (1 document per line)
# Additionally, you can supply an id-path query parameter to use the value at a particular path in 
# each document as the document's key in the database, so if all your documents have an id field, 
# you could set id-path=id and treat the value in id as the document's key. 
# You can also use any valid path syntax (globs not allowed), e.g. id-path=user.emails.[0].id
# If id-path is excluded, random UUID's will be assigned to every document, and the response will 
# have the ID's created corresponding in the same order as the documents were supplied in.
echo "Create document for multiple readers with batch POST"
./curl-document-post-mult-readers.sh.tmp | jq -r '.'
# SET UP THE REST OF THE DATA FOR FURTHER WORK
echo "Create document for multiple books with batch POST"
./curl-document-post-mult-books.sh.tmp | jq -r '.'
echo "Write one reader with an document-id for later use"
./curl-document-put-one-reader-with-id.sh.tmp | jq -r '.'

# BIG PATCH WARNING: 
# One thing to note: PATCH expects that the data present at the path is 
# already a JSON object {}. if you have an array or some scalar value, 
# those values will be blown away and overwritten

# MODIFY DOCUMENTS
echo "Replace a document with a PUT using document-id"
./curl-document-put-replace.sh.tmp | jq -r '.'
echo "Check that data is included"
./curl-document-get-one.sh.tmp | jq -r '.'
echo "PATCH some information into a document using document-id"
./curl-document-patch.sh.tmp | jq -r '.'
echo "Check that data is included"
./curl-document-get-one.sh.tmp | jq -r '.'
echo "PATCH some more information into a document using document-id"
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
# DOCUMENT-PATH DEFINES WHERE IN A DOCUMENT YOU WANT TO EXECUTE SOMETHING
# EX: PUT {{base_rest_url}}{{base_doc_api}}/{{namespace}}/collections/{{collection}}/{{bookdocid}}/book/genre
echo "PUT a document with document-path; replaces current data"
./curl-document-put-book-with-path.sh.tmp | jq -r '.'
echo "PATCH a document with document-path - overwrites"
./curl-document-patch-book-with-path.sh.tmp | jq -r '.'

# MODIFY DOCUMENTS WITH BUILT-IN FUNCTIONS WITH DOCUMENT-PATH
# FIRST, VIEW THE BUILT-IN FUNCTIONS
# ERICB said this is deleted
# echo "Get built-in functions for a particular namespace"
# ./curl-ns-get-functions.sh.tmp | jq -r '.'
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
echo "Get a document with fields, without a WHERE clause"
./curl-document-get-one-with-fields.sh.tmp | jq '.'
##### HOW CAN I GET THE PAGING STATE DYNAMICALLY?? OTHERWISE THIS NEXT TEST WILL FAIL
echo "Get documents with paging-state set"
./curl-document-get-all-docs-with-paging.sh.tmp | jq '.'

### SEARCH COLLECTION FOR DOCUMENTS WITH WHERE CLAUSE
echo "Get all documents where name eq a particular reader"
./curl-document-get-where-name.sh.tmp | jq -r '.'
echo "Get all documents where name eq a particular reader with fields"
./curl-document-get-where-name-eq.sh.tmp | jq -r '.'
# $ne selects the documents where the value of the field is not equal to the specified value. 
# This includes documents that do not contain the field.
echo "Get all documents where name ne using $and a particular reader"
./curl-document-get-where-name-ne-and.sh.tmp | jq -r '.'
echo "Get all documents where name ne using multi a particular reader"
./curl-document-get-where-name-ne-mult.sh.tmp | jq -r '.'
echo "Get all documents where name equals Amy Smith OR Jane Doe"
./curl-document-get-where-names-or.sh.tmp | jq -r '.'
echo "Get all documents where book title does not equal Moby Dick"
./curl-document-get-where-books-not.sh.tmp | jq -r '.'
echo "Get all documents where the reader rating is gt 3 and lte 5"
./curl-document-get-where-rating-gt3-lte5.sh.tmp | jq -r '.'
### Document search with path segment and $in may require a note: https://github.com/stargate/stargate/issues/1049
echo "Get a document where names are in field"
./curl-document-get-where-name-in.sh.tmp | jq -r '.'
echo "Get a document where names are in field but one name fails"
./curl-document-get-where-name-in-1fail.sh.tmp | jq -r '.'
# $nin selects the documents where: the field value is not in the specified array or the 
# field does not exist.
echo "Get a document where names are not in (\$nin) field"
./curl-document-get-where-name-nin.sh.tmp | jq -r '.'

#### MULTI WHERE, WITH EXPLANATIONS OF WHEN OR WHERE THEY CAN BE USED
### Next example also demonstrates the use of multiple fields with a comma: reader.address.primary,secondary.city
echo "Get all documents where the address.primary,secondary.city eq a value"
./curl-document-get-where-address-city.sh.tmp | jq -r '.'
### EXAMPLES WITH ARRAYS BY NUMBER OR WILDCARD (*)
echo "Get all documents where book title eq a particular book in reviews"
./curl-document-get-where-book-eq.sh.tmp | jq -r '.'

########## NEED ARRAY ExAMPLE WITH NUMBER - THERE IS A IN-DOC example below

############# NOT WORKING - FIX IT!
########## CANNOT SEARCH ON ARRAY DIRECTLY, since * or [*] cannot BE THE LAST IN A PATH
echo "Get a document where a value is contained in an array"
./curl-document-get-where-contains.sh.tmp | jq -r '.'
echo "Get a document with a where wildcard on book format"
./curl-document-get-wildcard.sh.tmp | jq -r '.'

# LIST A PARTICULAR DOCUMENT USING DOCUMENTID AND CONDITIONS
echo "Get one particular document using documentId"
./curl-document-get-one.sh.tmp | jq -r '.'

# LIST A DOCUMENT-PATH's CONTENTS - SEARCHING FOR DATA IN A DOCUMENT
echo "Get a book title using a document-id and document path"
./curl-data-get-path-in-document.sh.tmp  | jq -r '.'
### USED ABOVE, ANOTHER EXAMPLE: ./curl-document-get-array-change.sh
echo "Get the second book-title in a reader's reviews by array number using a document-id and document path"
./curl-data-get-path-array-in-document.sh.tmp  | jq -r '.'
echo "Get data from a document using a WHERE clause and the document-path"
./curl-data-where-with-document-path.sh.tmp  | jq -r '.'

# DELETE ALL SCHEMA and DATA
# DELETES DO NOT RETURN ANYTHING
#./curl-document-delete.sh.tmp
#./curl-document-delete-where.sh.tmp
#./curl-collection-delete.sh.tmp
#./curl-ns-delete.sh.tmp