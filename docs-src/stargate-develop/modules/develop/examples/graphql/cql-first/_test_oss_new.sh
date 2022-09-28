#!/bin/bash

cd -P -- "$(dirname -- "$0")" # switch to this dir
source ../test_oss_common.sh

# SET VARIABLES FOR STARGATE
# FOR v1
base_url=https://localhost:8080
# FOR v2
base_url=https://localhost:8085
base_gql_schema=/graphql-schema
base_gql_admin=/graphql-admin
base_gql_api=/graphql
gkeyspace=library

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{base_url}#$base_url#; s#{base_gql_schema}#$base_gql_schema#; s#{base_gql_api}#$base_gql_api#; s#{gkeyspace}#$gkeyspace#; s#{table}#$table#; s#{auth_token}#$AUTH_TOKEN#;" $FILE > $FILE.tmp;
      chmod 755 $FILE.tmp;
    fi
done

# RUN THE DDL

#echo -e "\n\ncreate keyspace\n"
#./curl_createKeyspace.sh.tmp
#| jq -r '.name | test("library")'

echo -e "\nDeploy the graphql schema\n"
cp ./schema.graphql /tmp
./1createDeployFile.graphql.tmp
# There is also a need to check redeploying with an expectedVersion supplied:
# ./1DeployFileAgain.graphql.tmp

echo -e "\nGet keyspace schema\n"
./1curl_getAllKsSchema.sh.tmp
./1curl_getParticularKsSchema.sh.tmp

echo -e "\nInsert 2 books\n"
./1curl_insertNativeSon.sh.tmp
./1curl_insertMobyDick.sh.tmp

echo -e "\nInsert 2 books with same title\n"
./1curl_insertgroundswell1.sh.tmp
./1curl_insertgroundswell2.sh.tmp

echo -e "\nInsert another book\n"
./1curl_insertPapBook.sh.tmp

echo -e "\nInsert 2 readers\n"
./1curl_insertReaderJane.sh.tmp
./1curl_insertReaderHerman.sh.tmp

echo -e "\nInsert 4 library collections\n"
./1curl_insertCSRMphoto.sh.tmp
./1curl_insertCSRMbook.sh.tmp
./1curl_insertWSACphoto.sh.tmp
./1curl_insertDHMbook.sh.tmp

echo -e "\nUpdate Pride and Prejudice\n"
./1curl_updatePap.sh.tmp

echo -e "\nFetch books\n"
./1curl_fetchBook.sh.tmp
./1curl_fetchSameBooks.sh.tmp

echo -e "\nDelete book Pap\n"
./1curl_deleteBook.sh.tmp

<< 'BLOCK-OUT-UNTIL-TESTED'
echo -e "\n\ncreate udt\n"
./curl_createUDT.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_createUDT.result) || exit_on_failure
# | jq -r '.name | test("address_type")'

echo -e "\n\ncreate 2 tables\n"
./curl_create2Tables.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_create2Tables.result) || exit_on_failure

echo -e "\n\ncreate 2 tables if not exists\n"
./curl_create2TablesIfNotExists.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_create2TablesIfNotExists.result) || exit_on_failure
#echo -e "\n\ncreate collection table\n"
#./curl_createCollTable.sh.tmp
echo -e "\n\ncreate map table\n"
./curl_createMapTable.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_createMapTable.result) || exit_on_failure

echo -e "\n\nalter table add columns\n"
./curl_alterTableAddCols.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_alterTableAddCols.result) || exit_on_failure

echo -e "\n\nget keyspace\n"
./curl_getKeyspace.sh.tmp #| jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_getKeyspace.result) || exit_on_failure

echo -e "\n\nget tables\n"
./curl_getTables.sh.tmp #| jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_getTables.result) || exit_on_failure

echo -e "\n\ninsert 2 books in one mutation\n"
./curl_insertTwoBooks.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_insertTwoBooks.result) || exit_on_failure

echo -e "\n\ninsert book with CL option\n"
./curl_insertBookWithOption.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_insertBookWithOption.result) || exit_on_failure

echo -e "\n\ninsert article using a LIST (authors)\n"
./curl_insertArticle.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_insertArticle.result) || exit_on_failure

echo -e "\n\ninsert reader with UDT\n"
./curl_insertReaderWithUDT.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_insertReaderWithUDT.result) || exit_on_failure

echo -e "\n\ninsert reader with tuple\n"
./curl_insertJaneWithTuple.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_insertJaneWithTuple.result) || exit_on_failure

echo -e "\n\ninsert badge\n"
./curl_insertOneBadge.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_insertOneBadge.result) || exit_on_failure

echo -e "\n\nread one book with primary key title\n"
./curl_readOneBook.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_readOneBook.result) || exit_on_failure

echo -e "\n\nread 3 books with IN filter for primary key title\n"
./curl_readThreeBooks.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_readThreeBooks.result) || exit_on_failure

echo -e "\n\nread a reader with UDT\n"
./curl_readReaderWithUDT.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_readReaderWithUDT.result) || exit_on_failure

echo -e "\n\nupdate a book with isbn\n"
./curl_updateOneBook.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_updateOneBook.result) || exit_on_failure

echo -e "\n\nupdate a book with genre\n"
./curl_updateOneBookAgain.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_updateOneBookAgain.result) || exit_on_failure

# DELETE ALL WORK

echo -e "\n\ndelete one book - PaP\n"
./curl_deleteOneBook.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_deleteOneBook.result) || exit_on_failure

echo -e "\n\ndelete one book with CL - PaP\n"
./curl_deleteOneBookCL.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_deleteOneBookCL.result) || exit_on_failure

echo -e "\n\nDrop table called article\n"
./curl_dropTableArticle.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_dropTableArticle.result) || exit_on_failure

echo -e "\n\nDrop table called reader\n"
./curl_dropTableReader.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_dropTableReader.result) || exit_on_failure

echo -e "\n\ndrop column from table\n"
./curl_dropColumnFormat.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_dropColumnFormat.result) || exit_on_failure

echo -e "\n\ndrop table if exists\n"
./curl_dropTableIfExists.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_dropTableIfExists.result) || exit_on_failure

echo -e "\n\nDrop table called book\n"
./curl_dropTableBook.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_dropTableBook.result) || exit_on_failure

echo -e "\n\ndrop UDT\n"
./curl_dropType.sh.tmp | jq -r -e '.' > HOLD; diff <(gron HOLD) <(gron ../result/gql_dropType.result) || exit_on_failure

#echo -e "\n\ndrop keyspace\n"
#./curl_dropKeyspace.sh.tmp

# CLEAN UP tmp files
rm *.tmp; rm HOLD;
BLOCK-OUT-UNTIL-TESTED

