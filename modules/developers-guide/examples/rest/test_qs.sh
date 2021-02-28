#!/bin/bash

# MUST DO THE URL AND PATH SUBSTITUTIONS BEFORE RUNNING THE TESTS

base_url=http://localhost:8082
base_api_schema_path=/v2/schemas/keyspaces
base_api_path=/v2/keyspaces
keyspaceName=users_keyspace
tableName=users

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed "s#{my_base_url}#$base_url#; s#{my_base_api_schema_path}#$base_api_schema_path#; s#{my_base_api_path}#$base_api_path#; s#{my_keyspace}#$keyspaceName#; s#{my_table}#$tableName#" $FILE > $FILE.tmp;
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

# Drop the keyspace before running test
echo "drop ks"
./curl_drop_ks.sh.tmp

# RUN THE DDL

echo "create users_keyspace"
./curl_simple_ks.sh.tmp | jq -r '.name | test("users_keyspace")'
echo "check existence"
./curl_check_ks_exists.sh.tmp | jq -r '.data[].name | test("users_keyspace")'
echo "check users_keyspace"
./curl_get_particular_ks.sh.tmp | jq '.'> HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_ks.result)

echo "create table users"
./curl_create_table.sh.tmp | jq -r '.name | test("users")'
echo "check existence"
./curl_check_table_exists.sh.tmp | jq '.data[].name | test("users")'
echo "check users"
./curl_get_particular_table.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_table_qs.result)

echo "add column"
./curl_add_column.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_column.result)
echo "check existence"
./curl_check_column_exists.sh.tmp | jq '.data[].name | test("email")'
echo "check column email"
./curl_get_particular_column.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_column_qs.result)

echo "write users"
./curl_write_users.sh.tmp|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_write_users_qs.result)
echo "get users"
./curl_get_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_qs.result)
echo "update users"
./curl_update_users.sh.tmp | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_update_users.result)

# DROP/DELETE ALL SCHEMA
#./curl_delete_row.sh.tmp

# CLEAN UP tmp files
rm *.tmp; rm HOLD;
