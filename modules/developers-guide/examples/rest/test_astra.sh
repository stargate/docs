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
base_api_schema_path=/api/rest/v2/schemas
base_api_path=/api/rest/v2/keyspaces
rkeyspaceName=users_keyspace
rtableName=users

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{my_base_url}#https://$ASTRA_CLUSTER_ID-$ASTRA_REGION.apps.astra.datastax.com#; s#{my_base_api_schema_path}#$base_api_schema_path#; s#{my_base_api_path}#$base_api_path#; s#{my_keyspace}#$rkeyspaceName#; s#{my_table}#$rtableName#" $FILE > $FILE.tmp;
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

printenv |grep AUTH_TOKEN

echo -e "\n\ndrop ks to clear all data: "
#./curl_drop_ks.sh.tmp

# RUN THE DDL

#echo -e "\n\ncreate keyspace "
#./curl_create_ks.sh.tmp | jq -r '.name | test("users_keyspace")'

# HOW TO TEST THE ALTERNATE CREATE_KS?? NEED TO FIGURE IT OUT
#./curl_simple_ks.sh.tmp | jq -r '.name | test("users_keyspace")'
#echo -e "\n\ncreate ks_dcs: "
#./curl_ks_dcs.sh.tmp | jq -r '.name | test("users_keyspace_dcs")'

# create the UDT with graphQL instead
echo -e "\n\ncreate UDT with graphql \n"
./curl_createUDT_gql_astra.sh

echo -e "\n\ncreate table and add columns "
./curl_create_table.sh.tmp | jq -r '.name | test("users")'

echo -e "\n\nadd_column: "
./curl_add_column.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_column.result)
echo -e "\n\nadd_set_to_table: "
./curl_add_set_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_set_to_table.result)
echo -e "\n\nadd_list_to_table: "
./curl_add_list_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_list_to_table.result)
echo -e "\n\nadd map to table: "
./curl_add_map_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_map_to_table.result)
echo -e "\n\nadd tuple to table: "
./curl_add_tuple_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_tuple_to_table.result)
echo -e "\n\nadd udt to table: "
./curl_add_udt_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_udt_to_table.result)

# NEED TO CHECK CURL_CHANGE_COLUMN.SH, BUT IT MESSES UP REST OF WORK, SO CHANGE BACK
echo -e "\n\nChange column and back: "
./curl_change_column.sh.tmp
./curl_change_column_back.sh.tmp

# CHECK EXISTENCE OF SCHEMA
echo -e "\n\ncheck existence"
#test $(./curl_check_ks_exists.sh.tmp | jq '.| length') -eq 1 && echo -e "\n\nPASS" || echo -e "\n\nFAIL"
./curl_check_ks_exists.sh.tmp | jq -r '.data[].name | test("users_keyspace")'
echo -e "\n\ncheck ks users_keyspace"
./curl_get_particular_ks.sh.tmp | jq '.'> HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_ks.result)
./curl_check_table_exists.sh.tmp | jq '.data[].name | test("users")'
echo -e "\n\ncheck table users"
./curl_get_particular_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_table.result)
echo -e "\n\nemail test 1"
./curl_check_column_exists.sh.tmp | jq '.data[].name | test("email")'
echo -e "\n\nemail test 2"
./curl_check_column_exists.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_check_column_exists.result)
echo -e "\n\ncheck column email"
./curl_get_particular_column.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_column.result)

# CQL INDEXES ARE REQUIRED FOR SOME DML, MUST CREATE IN CQLSH
# CREATE INDEX books_idx ON users_keyspace.users (VALUES(favorite_books));
# CREATE INDEX tv_idx ON users_keyspace.users (VALUES (top_three_tv.sh.tmpows));
# CREATE INDEX eval_idx ON users_keyspace.users (KEYS (evaluations));
# CREATE INDEX country_idx ON users_keyspace.users (current_country);

# create the indexes with graphQL instead
echo -e "\n\ncreate indexes with graphql \n"
./curl_createIndexes_gql_astra.sh

# RUN THE DML
echo -e "\n\nwrite users"
./curl_write_users.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_write_users.result)
echo -e "\n\nwrite set"
./curl_insert_set_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_set_data.result)
echo -e "\n\nwrite list"
./curl_insert_list_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_list_data.result)
echo -e "\n\nwrite map"
./curl_insert_map_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_map_data.result)
echo -e "\n\nwrite tuple"
./curl_insert_tuple_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_tuple_data.result)
echo -e "\n\nwrite udt"
./curl_insert_udt_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_udt_data.result)

echo -e "\n\npatch users"
./curl_patch_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_patch_users.result)
echo -e "\n\nupdate users"
./curl_update_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_update_users.result)

echo -e "\n\nget prim key"
./curl_get_primKey.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_primKey.result)
# THESE NEED 2i
echo -e "\n\nget set"
./curl_get_set_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_set_data.result)
echo -e "\n\nget list"
./curl_get_list_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_list_data.result)
echo -e "\n\nget map"
./curl_get_map_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_map_data.result)
echo -e "\n\nget tuple"
./curl_get_tuple_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_tuple_data.result)
# END OF NEED 2i

# UDT IS NOT WORKING - BUG IN SG8 CODE
#echo -e "\n\nget udt"
#./curl_get_udt_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_udt_data.result)

echo -e "\n\nget users"
./curl_get_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users.result)
echo -e "\n\nget users where"
./curl_get_users_where.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_where.result)
echo -e "\n\nget users mult where"
./curl_get_users_mult_where.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_mult_where.result)

# DROP/DELETE ALL SCHEMA
#./curl_delete_row.sh.tmp
#./curl_drop_column.sh.tmp
#./curl_drop_table.sh.tmp
#./curl_drop_ks.sh.tmp

# CLEAN UP tmp files
#rm *.tmp; rm HOLD;
