#!/bin/bash

# SET VARIABLES FOR STARGATE
base_url=http://localhost:8080
base_api_schema_path=/graphql-schema
base_api_path=/graphql
gkeyspaceName=library

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{my_base_url}#$base_url#; s#{my_base_api_schema_path}#$base_api_schema_path#; s#{my_base_api_path}#$base_api_path#; s#{keyspaceName}#$gkeyspaceName#;" $FILE > $FILE.tmp;
      chmod 755 $FILE.tmp;
    fi
done


#GET AND SET AUTH_TOKEN
export AUTH_TOKEN=$(curl -s -L -X POST 'http://localhost:8081/v1/auth' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "cassandra",
    "password": "cassandra"
}' | jq -r '.authToken')


# RUN THE DDL

echo -e "\n\ncreate keyspace\n"
./curl_createKeyspace.sh.tmp 
#| jq -r '.name | test("library")'
echo -e "\n\ncreate udt\n"
./curl_createUDT.sh.tmp 
# | jq -r '.name | test("address_type")'

echo -e "\n\ncreate 2 tables\n"
./curl_create2Tables.sh.tmp
echo -e "\n\ncreate 2 tables if not exists\n"
./curl_create2TablesIfNotExists.sh.tmp
echo -e "\n\ncreate collection table\n"
./curl_createCollTable.sh.tmp
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
