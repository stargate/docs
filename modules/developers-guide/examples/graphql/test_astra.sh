#!/bin/bash

# MUST DO THE URL AND PATH SUBSTITUTIONS BEFORE RUNNING THE TESTS

export ASTRA_CLUSTER_ID=8319febd-e7cf-4595-81e3-34f45d332d2a
export ASTRA_REGION=us-east1
export ASTRA_USERNAME=polandll
export ASTRA_PASSWORD=12345abcd

ASTRA_CLUSTER_ID=8319febd-e7cf-4595-81e3-34f45d332d2a
ASTRA_REGION=us-east1
ASTRA_USERNAME=polandll
ASTRA_PASSWORD=12345abcd
base_api_schema_path=/api/graphql-schema
base_api_path=/api/graphql
gkeyspaceName=library

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{my_base_url}#https://$ASTRA_CLUSTER_ID-$ASTRA_REGION.apps.astra.datastax.com#; s#{my_base_api_schema_path}#$base_api_schema_path#; s#{my_base_api_path}#$base_api_path#; s#{keyspaceName}#$gkeyspaceName#; s#{my_table}#$tableName#" $FILE > $FILE.tmp;
      chmod 755 $FILE.tmp;
    fi
done

# SET THE AUTH_TOKEN FOR ALL THE OTHER COMMANDS

export AUTH_TOKEN=$(curl -s -L -X POST 'https://8319febd-e7cf-4595-81e3-34f45d332d2a-us-east1.apps.astra.datastax.com/api/rest/v1/auth' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "polandll",
    "password": "12345abcd"
}' | jq -r '.authToken')

#export AUTH_TOKEN=$(curl -s -L -X POST 'https://$ASTRA_CLUSTER_ID-$ASTRA_REGION.apps.astra.datastax.com/api/rest/v1/auth' \
#  -H 'Content-Type: application/json' \
#  --data-raw '{
#    "username": "$ASTRA_USERNAME",
#    "password": "$ASTRA_PASSWORD"
#}' | jq -r '.authToken')

# RUN THE DDL

#echo -e "\n\ncreate keyspace\n"
#./curl_createKeyspace.sh.tmp 
#| jq -r '.name | test("library")'

echo -e "\n\ncreate udt\n"
./curl_createUDT.sh.tmp 
# | jq -r '.name | test("address_type")'

echo -e "\n\ncreate 2 tables\n"
./curl_create2Tables.sh.tmp
echo -e "\n\ncreate 2 tables if not exists\n"
./curl_create2TablesIfNotExists.sh.tmp
#echo -e "\n\ncreate collection table\n"
#./curl_createCollTable.sh.tmp
echo -e "\n\ncreate map table\n"
./curl_createMapTable.sh.tmp

echo -e "\n\nalter table add columns\n"
./curl_alterTableAddCols.sh.tmp

echo -e "\n\nget keyspace\n"
./curl_getKeyspace.sh.tmp
echo -e "\n\nget tables\n"
./curl_getTables.sh.tmp

echo -e "\n\ninsert 2 books in one mutation\n"
./curl_insertTwoBooks.sh.tmp

echo -e "\n\ninsert book with CL option\n"
./curl_insertBookWithOption.sh.tmp

echo -e "\n\ninsert article using a LIST (authors)\n"
./curl_insertArticle.sh.tmp

echo -e "\n\ninsert reader with UDT\n"
./curl_insertReaderWithUDT.sh.tmp

echo -e "\n\ninsert reader with tuple\n"
./curl_insertJaneWithTuple.sh.tmp

echo -e "\n\ninsert badge\n"
./curl_insertOneBadge.sh.tmp

echo -e "\n\nread one book with primary key title\n"
./curl_readOneBook.sh.tmp

echo -e "\n\nread 3 books with IN filter for primary key title\n"
./curl_readThreeBooks.sh.tmp

echo -e "\n\nread a reader with UDT\n"
./curl_readReaderWithUDT.sh.tmp

echo -e "\n\nupdate a book with isbn\n"
./curl_updateOneBook.sh.tmp

echo -e "\n\nupdate a book with genre\n"
./curl_updateOneBookAgain.sh.tmp

# DELETE ALL WORK

echo -e "\n\ndelete one book - PaP\n"
./curl_deleteOneBook.sh.tmp

echo -e "\n\ndelete one book with CL - PaP\n"
./curl_deleteOneBookCL.sh.tmp

echo -e "\n\nDrop table called article\n"
./curl_dropTableArticle.sh.tmp

#echo -e "\n\ndrop UDT\n"
#./curl_dropType.sh.tmp

#echo -e "\n\ndrop column from table\n"
#./curl_dropColumnFormat.sh.tmp

#echo -e "\n\ndrop table if exists\n"
#./curl_dropTableIfExists.sh.tmp

#echo -e "\n\ndrop keyspace\n"
#./curl_dropKeyspace.sh.tmp
