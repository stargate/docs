# The WHERE CLAUSE is:
#  { "firstname": {"$eq": "Janesha" },
#   "lastname": {"$eq": "Doesha" },
#   "current_country": {"$eq": "( 'France', '2016-01-01', '2020-02-02' )"}}

curl -X GET "http://localhost:8082/v2/keyspaces/users_keyspace/users?\
where=%20%20%7B%20%22\
firstname%22%3A%20%7B%22%24eq%22%3A%20%22Janesha%22%20%7D%2C%20%20%20%20%22\
lastname%22%3A%20%7B%22%24eq%22%3A%20%22Doesha%22%20%7D%2C%20%20%20%20%22\
current_country%22%3A%20%7B%22%24eq%22%3A%20%22(%20'France'%2C%20'2016-01-01'%2C%20'2020-02-02'%20)%22%7D%7D" \
-H  "accept: application/json" \
-H  "X-Cassandra-Token: d8cfe62a-5648-4067-9758-f426da895da4"
