curl -s -L -X POST {base_rest_url}{base_rest_schema}/{rkeyspace}/{rtable} \
-H  "X-Cassandra-Token: {auth_token}" \
-H  "Content-Type: application/json" \
-H  "Accept: application/json" \
-d '{"firstname": "{user2fn}",
  "lastname": "{user2ln}",
  "favorite color": "grey",
  "top_three_tv_shows": [ "The Magicians", "The Librarians", "Agents of SHIELD" ],
  "evaluations": [ {"key":"2020", "value":"good"}, {"key":"2019", "value":"okay"} ]
}'
