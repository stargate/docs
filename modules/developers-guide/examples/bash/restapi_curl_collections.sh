**************
SET EXAMPLE:
**************

CREATE TABLE SCHEMA:
curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  'accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
   "name": "favorite_books",
   "typeDefinition": "set<text>"
}'

INSERT DATA:
curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096" \
-H  "Content-Type: application/json" \
-d "{\"firstname\": \"Janesha\",
  \"lastname\": \"Doesha\",
  \"favorite color\": \"grey\",
  \"favorite_books\": \"{ 'Emma', 'The Color Purple' }\"
}"

READ DATA:
This GET may need an index created in CQL on "favorite_books" before it will
process correctly.

CREATE INDEX books_idx ON users_keyspace.users (values(favorite_books));

The WHERE CLAUSE is:
{ "firstname": {"$eq": "Janesha" },
 "lastname": {"$eq": "Doesha" },
 "favorite_books": {"$contains": "Emma"}}

curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
where=%7B%20%22firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%22lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%22favorite_books%22%3A%20%7B%22%24contains%22%3A%20%22Emma%22%7D%7D" \
 -H  "accept: application/json" \
 -H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096"

**************
 LIST EXAMPLE:
**************

 CREATE TABLE SCHEMA:
 curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
 -H "X-Cassandra-Token: $AUTH_TOKEN" \
 -H  'accept: application/json' \
 -H 'Content-Type: application/json' \
 -d '{
    "name": "top_three_tv_shows",
    "typeDefinition": "list<text>"
 }'

 INSERT DATA:
 curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
 -H  "accept: application/json" \
 -H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096" \
 -H  "Content-Type: application/json" \
 -d "{\"firstname\": \"Janesha\",
   \"lastname\": \"Doesha\",
   \"favorite color\": \"grey\",
   \"top_three_tv_shows\": \"[ 'The Magicians', 'The Librarians', 'Agents of SHIELD' ]\"
 }"

 READ DATA:
 This GET may need an index created in CQL on "top_three_tv_shows" before it will
 process correctly.

 CREATE INDEX tv_idx ON users_keyspace.users (VALUES (top_three_tv_shows));

 The WHERE CLAUSE is:
 { "firstname": {"$eq": "Janesha" },
  "lastname": {"$eq": "Doesha" },
  "top_three_tv_shows": {"$contains": "The Magicians"}}

curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
where=%7B%20%22firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%22lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%22top_three_tv_shows%22%3A%20%7B%22%24contains%22%3A%20%22The%20Magicians%22%7D%7D" \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096"

**************
 MAP EXAMPLE:
**************

 CREATE TABLE SCHEMA:
 curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
 -H "X-Cassandra-Token: $AUTH_TOKEN" \
 -H  'accept: application/json' \
 -H 'Content-Type: application/json' \
 -d '{
    "name": "evaluations",
    "typeDefinition": "map<int,text>"
 }'

 INSERT DATA:
 curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
 -H  "accept: application/json" \
 -H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096" \
 -H  "Content-Type: application/json" \
 -d "{\"firstname\": \"Janesha\",
   \"lastname\": \"Doesha\",
   \"favorite color\": \"grey\",
   \"top_three_tv_shows\": \"[ 'The Magicians', 'The Librarians', 'Agents of SHIELD' ]\",
   \"evaluations\": \"{ "2020":"good", "2019":"okay" }\"
 }"

 READ DATA:
 This GET may need an index created in CQL on "evaluations" before it will
 process correctly.

 CREATE INDEX eval_idx ON users_keyspace.users (KEYS (evaluations));

 The WHERE CLAUSE is:
 { "firstname": {"$eq": "Janesha" },
  "lastname": {"$eq": "Doesha" },
  "evaluations": {"$containsKey": "2020"}}

  Curl

  curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
  where=%7B%20%22firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%22lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%22evaluations%22%3A%20%7B%22%24containsKey%22%3A%20%222020%22%7D%7D" \
  -H  "accept: application/json" \
  -H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096"


  **************
  TUPLE EXAMPLE:
  *************

  CREATE TABLE SCHEMA:
  curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
  -H "X-Cassandra-Token: $AUTH_TOKEN" \
  -H  'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
     "name": "current_country",
     "typeDefinition": "tuple<text, date, date>"
  }'

  INSERT DATA:
  curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
  -H  "accept: application/json" \
  -H  "X-Cassandra-Token: 48bcfab2-b1c6-44fd-a56f-9f2221930096" \
  -H  "Content-Type: application/json" \
  -d "{\"firstname\": \"Janesha\",
    \"lastname\": \"Doesha\",
    \"favorite color\": \"grey\",
    \"current_country\": \"( 'France', '2016-01-01', '2020-02-02' )\"
  }"

  READ DATA:
  This GET may need an index created in CQL on "top_three_tv_shows" before it will
  process correctly.

  CREATE INDEX tv_idx ON users_keyspace.users (VALUES (top_three_tv_shows));

  The WHERE CLAUSE is:
  { "firstname": {"$eq": "Janesha" },
   "lastname": {"$eq": "Doesha" },
   "current_country": {"$eq": "( 'France', '2016-01-01', '2020-02-02' )"}}

 curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
 where=%20%20%7B%20%22firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%20%20%20%22lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%20%20%20%22current_country%22%3A%20%7B%22%24eq%22%3A%20%22(%20'France'%2C%20'2016-01-01'%2C%20'2020-02-02'%20)%22%7D%7D" \
 -H  "accept: application/json" \
 -H  "X-Cassandra-Token: d8cfe62a-5648-4067-9758-f426da895da4"

  ************
  UDT EXAMPLE:
  ***********
