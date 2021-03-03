#!/bin/bash

# MUST DO THE URL AND PATH SUBSTITUTIONS BEFORE RUNNING THE TESTS

base_url=http://localhost:8082
base_api_schema_path=/v2/schemas/keyspaces
base_api_path=/v2/keyspaces
rkeyspaceName=users_keyspace
rtableName=users

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{my_base_url}#$base_url#; s#{my_base_api_schema_path}#$base_api_schema_path#; s#{my_base_api_path}#$base_api_path#; s#{my_keyspace}#$rkeyspaceName#; s#{my_table}#$rtableName#" $FILE > $FILE.tmp;
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

echo -e "\n\ndrop ks to clear all data: \n"
./curl_drop_ks.sh.tmp

# RUN THE DDL

echo -e "\n\ncreate keyspace \n"
./curl_create_ks.sh.tmp | jq -r '.name | test("users_keyspace")'

# HOW TO TEST THE ALTERNATE CREATE_KS?? NEED TO FIGURE IT OUT
#./curl_simple_ks.sh.tmp | jq -r '.name | test("users_keyspace")'
#echo -e "create ks_dcs: "
#./curl_ks_dcs.sh.tmp | jq -r '.name | test("users_keyspace_dcs")'

# UDT must currently be created in CQL
#cqlsh -f ../cql/create_udt.cql
#echo -e "create udt"
#./curl_create_udt.sh.tmp | jq -r '.name | test("address_type")'

# create the UDT with graphQL instead
echo -e "\n\ncreate UDT with graphql \n"
./curl_createUDT_gql.sh


echo -e "\n\ncreate table and add columns \n"
./curl_create_table.sh.tmp | jq -r '.name | test("users")'

echo -e "\na\ndd_column: \n"
./curl_add_column.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_column.result)
echo -e "\n\nadd_set_to_table: \n"
./curl_add_set_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_set_to_table.result)
echo -e "\n\nadd_list_to_table: \n"
./curl_add_list_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_list_to_table.result)
echo -e "\n\nadd map to table: \n"
./curl_add_map_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_map_to_table.result)
echo -e "\n\nadd tuple to table: \n"
./curl_add_tuple_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_tuple_to_table.result)
echo -e "\n\nadd udt to table: \n"
./curl_add_udt_to_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_udt_to_table.result)

# NEED TO CHECK CURL_CHANGE_COLUMN.SH, BUT IT MESSES UP REST OF WORK, SO CHANGE BACK
echo -e "\n\nChange column and back: \n"
./curl_change_column.sh.tmp
./curl_change_column_back.sh.tmp

# CHECK EXISTENCE OF SCHEMA
echo -e "\n\ncheck existence \n"
#test $(./curl_check_ks_exists.sh.tmp | jq '.| length') -eq 1 && echo -e "PASS" || echo -e "FAIL"
./curl_check_ks_exists.sh.tmp | jq -r '.data[].name | test("users_keyspace")'
echo -e "\n\ncheck ks users_keyspace \n"
./curl_get_particular_ks.sh.tmp | jq '.'> HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_ks.result)
./curl_check_table_exists.sh.tmp | jq '.data[].name | test("users")'
echo -e "\n\ncheck table users \n"
./curl_get_particular_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_table.result)
echo -e "\n\nemail test 1 \n"
./curl_check_column_exists.sh.tmp | jq '.data[].name | test("email")'
echo -e "\n\nemail test 2 \n"
./curl_check_column_exists.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_check_column_exists.result)
echo -e "\n\ncheck column email \n"
./curl_get_particular_column.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_column.result)

# CQL INDEXES ARE REQUIRED FOR SOME DML, MUST CREATE IN CQLSH
#cqlsh -f ../cql/create_index_set.cql
#cqlsh -f ../cql/create_index_list.cql
#cqlsh -f ../cql/create_index_map.cql
#cqlsh -f ../cql/create_index_tuple.cql

# create the indexes with graphQL instead
echo -e "\n\ncreate indexes with graphql \n"
./curl_createIndexes_gql.sh

# RUN THE DML
echo -e "\n\nwrite users \n"
./curl_write_users.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_write_users.result)
echo -e "\n\nwrite set \n"
./curl_insert_set_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_set_data.result)
echo -e "\n\nwrite list \n"
./curl_insert_list_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_list_data.result)
echo -e "\n\nwrite map \n"
./curl_insert_map_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_map_data.result)
echo -e "\n\nwrite tuple \n"
./curl_insert_tuple_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_tuple_data.result)
echo -e "\n\nwrite udt \n"
./curl_insert_udt_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_udt_data.result)

echo -e "\n\npatch users \n"
./curl_patch_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_patch_users.result)
echo -e "\n\nupdate users \n"
./curl_update_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_update_users.result)

echo -e "\n\nget prim key \n"
./curl_get_primKey.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_primKey.result)
# THESE NEED 2i
echo -e "\n\nget set \n"
./curl_get_set_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_set_data.result)
echo -e "\n\nget list \n"
./curl_get_list_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_list_data.result)
echo -e "\n\nget map \n"
./curl_get_map_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_map_data.result)
echo -e "\n\nget tuple \n"
./curl_get_tuple_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_tuple_data.result)
# END OF NEED 2i

# UDT IS NOT WORKING - BUG IN SG8 CODE
#echo -e "\n\nget udt \n"
#./curl_get_udt_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_udt_data.result)

echo -e "\n\nget users \n"
./curl_get_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users.result)
echo -e "\n\nget users where \n"
./curl_get_users_where.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_where.result)
echo -e "\n\nget users mult where \n"
./curl_get_users_mult_where.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_mult_where.result)

# DROP/DELETE ALL SCHEMA
#./curl_delete_row.sh.tmp
#./curl_drop_column.sh.tmp
#./curl_drop_table.sh.tmp
#./curl_drop_ks.sh.tmp

# CLEAN UP tmp files
#rm *.tmp; rm HOLD;
