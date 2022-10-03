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
      gsed "s#{base_url}#$base_url#; s#{base_gql_schema}#$base_gql_schema#; s#{base_gql_admin}#$base_gql_admin#;s#{base_gql_api}#$base_gql_api#; s#{gkeyspace}#$gkeyspace#; s#{table}#$table#; s#{auth_token}#$AUTH_TOKEN#;" $FILE > $FILE.tmp;
      chmod 755 $FILE.tmp;
    fi
done

# RUN THE DDL

echo -e "\n\ncreate keyspace\n"
./1curl_createKeyspace.sh.tmp
#| jq -r '.name | test("library")'

echo -e "\nDeploy the graphql schema\n"
cp ./schema.graphql /tmp
./1createDeployFile.graphql.tmp

# There is also a need to check redeploying with an expectedVersion supplied:
# ./1DeployFileAgain.graphql.tmp

# There is also a need to test createDeploy, but I'm not sure how to work it in
# need a 1curl_* version
#./1createDeploy.graphql.tmp

echo -e "\nGet keyspace schema\n"
echo -e "\nAll schema\n"
./1curl_getAllKsSchema.sh.tmp
echo -e "\nSchema for library\n"
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

echo -e "\nFetch readers\n"
./1curl_fetchReaders.sh.tmp

echo -e "\nWHERE queries\n"
./1curl_queryWhereCONTAINS.sh.tmp
./1curl_queryWhereGT.sh.tmp
./1curl_queryWhereGT-2.sh.tmp
./1curl_queryWhereGT-3.sh.tmp
./1curl_queryWhereLT.sh.tmp
./1curl_queryWhereLT-2.sh.tmp
./1curl_queryWhereIN.sh.tmp
./1curl_queryWhereIN2PartKey.sh.tmp

echo -e "\nDelete Lib Coll\n"
./1curl_deleteLibColl.sh.tmp
echo -e "\nDelete book Pap\n"
./1curl_deleteBook.sh.tmp

#echo -e "\nUndeploy schema\n"
#./1curl_Undeploy.sh.tmp

# CLEAN UP tmp files
#rm *.tmp; rm HOLD;
