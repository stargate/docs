curl -s -L -X POST http://localhost:8082/v2/keyspaces/users_keyspace/users \
-H  "X-Cassandra-Token: $AUTH_TOKEN" \
-H  "Content-Type: application/json" \
-H  "Accept: application/json" \
-d '{"firstname": "Janesha",
  "lastname": "Doesha",
  "favorite color": "grey",
  "top_three_tv_shows": [ "The Magicians", "The Librarians", "Agents of SHIELD" ],
  "evaluations": [ {"key":"2020", "value":"good"}, {"key":"2019", "value":"okay"} ]
}'
