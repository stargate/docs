curl -L -X GET 'localhost:8082/v2/schemas/keyspaces/users_keyspace' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'

curl -L \
-X GET 'localhost:8082/v2/schemas/keyspaces/'users_keyspace'/tables/users' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "accept: application/json" 

curl -L -X GET 'localhost:8082/v2/keyspaces/users_keyspace/users/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'

curl -L \
-X GET 'localhost:8082/v2/schemas/keyspaces/'users_keyspace'/tables/users/columns/email' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "accept: application/json" \
-H "content-type: application/json"

curl -L -X GET 'http://localhost:8082/v2/keyspaces/users_keyspace/users?where=\{"firstname":\{"$in":\["Janesha","Mookie"\]\}\}' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'

curl -L -X GET 'http://localhost:8082/v2/keyspaces/users_keyspace/users?where=\{"firstname":\{"$eq":"Mookie"\}\}' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json'

curl -L -X PATCH 'localhost:8082/v2/keyspaces/users_keyspace/users/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "email": "mookie.betts.email@email.com"
}'

curl -L -X PUT 'localhost:8082/v2/keyspaces/users_keyspace/users/Mookie/Betts' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "email": "mookie.betts.new-email@email.com"
}'

curl --location --request POST 'localhost:8082/v2/keyspaces/users_keyspace/users' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "Mookie",
    "lastname": "Betts",
    "email": "mookie.betts@gmail.com",
    "favorite color": "blue"
}'

curl --location --request POST 'localhost:8082/v2/keyspaces/users_keyspace/users' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "firstname": "Janesha",
    "lastname": "Doesha",
    "email": "janesha.doesha@gmail.com",
    "favorite color": "grey"
}'

# ***** SET EXAMPLE *****
# INSERT DATA:
curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json" \
-H  "Content-Type: application/json" \
-d "{\"firstname\": \"Janesha\",
     \"lastname\": \"Doesha\",
     \"favorite color\": \"grey\",
     \"favorite_books\": \"{ 'Emma', 'The Color Purple' }\"
}"

# READ DATA:
# This GET may need an index created in CQL on "favorite_books" before it will
# process correctly.

# CREATE INDEX books_idx ON users_keyspace.users (values(favorite_books));

# The WHERE CLAUSE is:
# { "firstname": {"$eq": "Janesha" },
#  "lastname": {"$eq": "Doesha" },
#  "favorite_books": {"$contains": "Emma"}}

curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
where=%7B%20%22\
firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%22\
lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%22\
favorite_books%22%3A%20%7B%22%24contains%22%3A%20%22Emma%22%7D%7D" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json"

# ***** LIST EXAMPLE *****
# INSERT DATA:
curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json" \
-H  "Content-Type: application/json" \
-d "{\"firstname\": \"Janesha\",
     \"lastname\": \"Doesha\",
     \"favorite color\": \"grey\",
     \"top_three_tv_shows\": \"[ 'The Magicians', 'The Librarians', 'Agents of SHIELD' ]\"
}"

#  READ DATA:
#  This GET may need an index created in CQL on "top_three_tv_shows" before it will
#  process correctly.

#  CREATE INDEX tv_idx ON users_keyspace.users (VALUES (top_three_tv_shows));

#  The WHERE CLAUSE is:
#  { "firstname": {"$eq": "Janesha" },
#   "lastname": {"$eq": "Doesha" },
#   "top_three_tv_shows": {"$contains": "The Magicians"}}

curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
where=%7B%20%22\
firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%22\
lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%22\
top_three_tv_shows%22%3A%20%7B%22%24contains%22%3A%20%22The%20Magicians%22%7D%7D" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json"

# ***** MAP EXAMPLE *****
# INSERT DATA:
curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json" \
-H  "Content-Type: application/json" \
-d "{\"firstname\": \"Janesha\",
     \"lastname\": \"Doesha\",
     \"favorite color\": \"grey\",
     \"top_three_tv_shows\": \"[ 'The Magicians', 'The Librarians', 'Agents of SHIELD' ]\",
     \"evaluations\": \"{ "2020":"good", "2019":"okay" }\"
}"

#  READ DATA:
#  This GET may need an index created in CQL on "evaluations" before it will
#  process correctly.

#  CREATE INDEX eval_idx ON users_keyspace.users (KEYS (evaluations));

#  The WHERE CLAUSE is:
#  { "firstname": {"$eq": "Janesha" },
#   "lastname": {"$eq": "Doesha" },
#   "evaluations": {"$containsKey": "2020"}}

curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
where=%7B%20%22\
firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%22\
lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%22\
evaluations%22%3A%20%7B%22%24containsKey%22%3A%20%222020%22%7D%7D" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json"

# ***** TUPLE EXAMPLE *****
# INSERT DATA:
curl -X POST "http://localhost:8082/v2/keyspaces/users_keyspace/users" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json" \
-H  "Content-Type: application/json" \
-d "{\"firstname\": \"Janesha\",
     \"lastname\": \"Doesha\",
     \"favorite color\": \"grey\",
     \"current_country\": \"( 'France', '2016-01-01', '2020-02-02' )\"
}"

#  READ DATA:
#  This GET may need an index created in CQL on "top_three_tv_shows" before it will
#  process correctly.

#  CREATE INDEX tv_idx ON users_keyspace.users (VALUES (top_three_tv_shows));

#  The WHERE CLAUSE is:
#  { "firstname": {"$eq": "Janesha" },
#   "lastname": {"$eq": "Doesha" },
#   "current_country": {"$eq": "( 'France', '2016-01-01', '2020-02-02' )"}}

curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
where=%20%20%7B%20%22\
firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%20%20%20%22\
lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%20%20%20%22\
current_country%22%3A%20%7B%22%24eq%22%3A%20%22(%20'France'%2C%20'2016-01-01'%2C%20'2020-02-02'%20)%22%7D%7D" \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "accept: application/json"

