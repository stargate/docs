#!/bin/bash

# SET THE AUTH_TOKEN FOR ALL THE OTHER COMMANDS

export AUTH_TOKEN=$(curl -s -L -X POST 'http://localhost:8081/v1/auth' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "cassandra",
    "password": "cassandra"
}' | jq -r '.authToken')

# Drop the keyspace before running test
echo "drop ks"
./curl_drop_ks.sh

# RUN THE DDL

echo "create users_keyspace"
./curl_simple_ks.sh | jq -r '.name | test("users_keyspace")'
echo "check existence"
./curl_check_ks_exists.sh | jq -r '.data[].name | test("users_keyspace")'
echo "check users_keyspace"
./curl_get_particular_ks.sh | jq '.'> HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_ks.result)

echo "create table users"
./curl_create_table.sh | jq -r '.name | test("users")'
echo "check existence"
./curl_check_table_exists.sh | jq '.data[].name | test("users")'
echo "check users"
./curl_get_particular_table.sh | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_table_qs.result)

echo "add column"
./curl_add_column.sh | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_add_column.result)
echo "check existence"
./curl_check_column_exists.sh | jq '.data[].name | test("email")'
echo "check column email"
./curl_get_particular_column.sh | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_particular_column_qs.result)

echo "write users"
./curl_write_users.sh|jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_write_users_qs.result)
echo "get users"
./curl_get_users.sh | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_get_users_qs.result)
echo "update users"
./curl_update_users.sh | jq -r '.' > HOLD; diff <(gron HOLD) <(gron ../result/rest_curl_update_users.result)

# DROP/DELETE ALL SCHEMA
#./curl_delete_row.sh
