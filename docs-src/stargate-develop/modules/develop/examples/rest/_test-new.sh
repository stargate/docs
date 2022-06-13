#!/bin/bash

# Attribution for functions that I am using: https://github.com/hitta-skyddsrum/services/blob/78db77d36a5eddef8ef8b4f8178b64e63e0171d9/e2e/shelters.sh

# MUST SET THE URL AND PATH SUBSTITUTIONS BEFORE RUNNING THE TESTS

base_rest_url=http://localhost:8082
base_rest_schema=/v2/schemas/keyspaces
base_rest_api=/v2/keyspaces
rkeyspace=users_keyspace
rtable=users
rpartitionkey=firstname
rclusteringkey=lastname
user1fn=Mookie
user1ln=Betts
user2fn=Janesha
user2ln=Doesha

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
      gsed "s#{base_rest_url}#$base_rest_url#; \
      s#{base_rest_schema}#$base_rest_schema#; \
      s#{base_rest_api}#$base_rest_api#; \
      s#{rkeyspace}#$rkeyspace#; \
      s#{rtable}#$rtable#; \
      s#{rpartitionkey}#$rpartitionkey#; \
      s#{rclusteringkey}#$rclusteringkey#; \
      s#{user1fn}#$user1fn#; \
      s#{user1ln}#$user1ln#; \
      s#{user2fn}#$user2fn#; \
      s#{user2ln}#$user2ln#; \
      s#{auth_token}#\$AUTH_TOKEN#;" \
      $FILE > $FILE.tmp;
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

echo "drop ks to clear all data: "
./curl_drop_ks.sh.tmp

# RUN THE DDL

echo "create keyspace "
response=$(./curl_create_ks.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "users_keyspace"

# HOW TO TEST THE ALTERNATE CREATE_KS?? NEED TO FIGURE IT OUT
#./curl_simple_ks.sh.tmp | jq -r '.name | test("users_keyspace")'
#echo "create ks_dcs: "
#./curl_ks_dcs.sh.tmp | jq -r '.name | test("users_keyspace_dcs")'

echo "create udt "
response=$(./curl_create_udt.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "address_type"

echo "create table and add columns "
response=$(./curl_create_table.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "users"
echo "add_column: "
response=$(./curl_add_column.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "email"
echo "add_set_to_table: "
response=$(./curl_add_set_to_table.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "favorite_books"
echo "add_list_to_table: "
response=$(./curl_add_list_to_table.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "top_three_tv_shows"
echo "add map to table: "
response=$(./curl_add_map_to_table.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "evaluations"
echo "add tuple to table: "
response=$(./curl_add_tuple_to_table.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "current_country"
echo "add udt to table: "
response=$(./curl_add_udt_to_table.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "address"
# CHECK CHANGING COLUMN NAME
echo "Change column and back: "
response=$(./curl_change_column.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "first"
response=$(./curl_change_column_back.sh.tmp)
assert_equals "$(get_json_value "$response" ".name")" "firstname"

# CHECK EXISTENCE OF SCHEMA
echo "check keyspace existence: "
response=$(./curl_check_ks_exists.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "1"
echo "check ks users_keyspace"
response=$(./curl_get_particular_ks.sh.tmp)
assert_equals "$(get_json_value "$response" ".data.name")" "users_keyspace"
echo "check table existence"
response=$(./curl_check_table_exists.sh.tmp)
assert_equals "$(get_json_value "$response" ".data[].name")" "users"
echo "check udt address_type"
response=$(./curl_get_udt.sh.tmp)
assert_equals "$(get_json_value "$response" ".data[].name")" "address_type"
echo "check table users"
response=$(./curl_get_particular_table.sh.tmp)
assert_equals "$(get_json_value "$response" ".data[].name")" "users"
echo "check column existence"
#++++++++++++++++ FIX NEXT ITEM +++++++++++++++
response=$(./curl_check_column_exists.sh.tmp)
assert_equals "$(get_json_select "$response" "success" "true")"
#./curl_check_column_exists.sh.tmp | jq '.data[].name | test("email")'
#++++++++++++++++ FIX NEXT ITEM +++++++++++++++
echo "check column email"
response=$(./curl_get_particular_column.sh.tmp)
assert_equals "$(get_json_value "$response" ".data[0].name")" "email"
#./curl_get_particular_column.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_column.result)

echo "create indexes"
response=$(./curl_create_index.sh.tmp)
assert_equals "$(get_json_value "$response" ".success")" "true"
#++++++++++++++++ FIX NEXT ITEM +++++++++++++++
#  RETURN 5 {success: true} and messes up assertion
echo "create additional indexes"
response=$(./curl_create_addl_indexes.sh.tmp)
assert_equals "$(get_json_value "$response" ".success")" "true"
echo "==================="

# RUN THE DML
#++++++++++++++++ FIX NEXT ITEM +++++++++++++++
echo "write users"
response=$(./curl_write_users.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_write_users.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_write_users.result)
echo "write set"
response=$(./curl_insert_set_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_insert_set_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_set_data.result)
echo "write list"
response=$(./curl_insert_list_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_insert_list_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_list_data.result)
echo "write map"
response=$(./curl_insert_map_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_insert_map_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_map_data.result)
echo "write tuple"
response=$(./curl_insert_tuple_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_insert_tuple_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_tuple_data.result)
echo "write udt"
response=$(./curl_insert_udt_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_insert_udt_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_insert_udt_data.result)

echo "patch users"
response=$(./curl_patch_users.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "1"
#./curl_patch_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_patch_users.result)
echo "update users"
response=$(./curl_update_users.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "1"
#./curl_update_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_update_users.result)

echo "get prim key"
response=$(./curl_get_primKey.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_get_primKey.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_primKey.result)
# THESE NEED 2i
echo "get set"
response=$(./curl_get_set_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_get_set_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_set_data.result)
echo "get list"
response=$(./curl_get_list_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
#./curl_get_list_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_list_data.result)
echo "get map"
response=$(./curl_get_map_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
# ./curl_get_map_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_map_data.result)
echo "get tuple"
response=$(./curl_get_tuple_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
# ./curl_get_tuple_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_tuple_data.result)
# END OF NEED 2i
echo "get udt"
response=$(./curl_get_udt_data.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
# ./curl_get_udt_data.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_udt_data.result)

echo "get users"
response=$(./curl_get_users.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
# ./curl_get_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users.result)
echo "get users where"
response=$(./curl_get_users_where.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
# ./curl_get_users_where.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_where.result)
echo "get users multi where"
response=$(./curl_get_users_mult_where.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"
# ./curl_get_users_multi_where.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_mult_where.result)
echo "get users fields"
response=$(./curl_get_users_fields.sh.tmp)
assert_equals "$(get_json_array_length "$response" )" "2"

# DROP/DELETE ALL SCHEMA
#./curl_delete_row.sh.tmp
#./curl_drop_column.sh.tmp
#./curl_drop_table.sh.tmp
#./curl_delete_udt.sh.tmp
#./curl_drop_ks.sh.tmp

if [ "$Errors" -gt "0" ]; then
  exit 1
else
  exit 0
fi
