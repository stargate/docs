The step below uses `cURL` to access the REST interface to generate the needed
token.

=== Generate an auth token

First generate an auth token that is required in each subsequent request
in the `X-Cassandra-Token` header.

Note the port for the auth service is 8081.

[source,bash]
----
curl -L -X POST 'http://localhost:8081/v1/auth' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "cassandra",
    "password": "cassandra"
}'
----

You should receive a token in the response.

[source,json]
----
{"authToken":"{auth-token}"}
----
