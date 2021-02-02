curl --location --request POST 'localhost:8082/v2/schemas/keyspaces' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
    "name": "users_keyspace"
}'

curl -L -X POST 'localhost:8082/v2/schemas/keyspaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "name": "users_keyspace",
    "replicas": 1
}'

curl -L -X POST 'localhost:8082/v2/schemas/keyspaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
-d '{
    "name": "users_keyspace_dcs",
    "datacenters": [ {"name": "dc1"}, {"name": "dc2", "replicas": 5} ]
}'

curl --location \
--request POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data '{
	"name": "users",
	"columnDefinitions":
	  [
        {
	      "name": "firstname",
	      "typeDefinition": "text"
	    },
        {
	      "name": "lastname",
	      "typeDefinition": "text"
	    },
        {
	      "name": "favorite color",
	      "typeDefinition": "text"
	    }
	  ],
	"primaryKey":
	  {
	    "partitionKey": ["firstname"],
	    "clusteringKey": ["lastname"]
	  },
	"tableOptions":
	  {
	    "defaultTimeToLive": 0,
	    "clusteringExpression":
	      [{ "column": "lastname", "order": "ASC" }]
	  }
}'

curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  'accept: application/json' \
-H 'Content-Type: application/json' \
-d '{  
   "name": "email",  
   "typeDefinition": "text"
}'

curl -L \
-X PUT "http://localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns/firstname" \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json' \
 -d '{
 "name": "first",
 "typeDefinition": "varchar"
}'

# ***** SET EXAMPLE ******
curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H  'accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
   "name": "favorite_books",
   "typeDefinition": "set<text>"
}'

# ***** LIST EXAMPLE *****
curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
 -H "X-Cassandra-Token: $AUTH_TOKEN" \
 -H  'accept: application/json' \
 -H 'Content-Type: application/json' \
 -d '{
    "name": "top_three_tv_shows",
    "typeDefinition": "list<text>"
 }'


# ***** MAP EXAMPLE *****
curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
 -H "X-Cassandra-Token: $AUTH_TOKEN" \
 -H  'accept: application/json' \
 -H 'Content-Type: application/json' \
 -d '{
    "name": "evaluations",
    "typeDefinition": "map<int,text>"
 }'


# ***** TUPLE EXAMPLE *****
curl -L -X POST 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns' \
  -H "X-Cassandra-Token: $AUTH_TOKEN" \
  -H  'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
     "name": "current_country",
     "typeDefinition": "tuple<text, date, date>"
  }'


curl -L -X GET 'localhost:8082/v2/schemas/keyspaces' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H 'Content-Type: application/json'

curl -L -X GET 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables' \
-H "X-Cassandra-Token: $AUTH_TOKEN" \
-H "accept: application/json" 

curl -L \
-X GET 'localhost:8082/v2/schemas/keyspaces/'users_keyspace'/tables/users/columns' \
-H "accept: application/json" \
-H "content-type: application/json" \
-H "X-Cassandra-Token: $AUTH_TOKEN"

curl --location
--request DELETE 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users/columns/email'
--header "X-Cassandra-Token: $AUTH_TOKEN"
--header "Content-Type: application/json"

curl --location \
--request DELETE 'localhost:8082/v2/schemas/keyspaces/users_keyspace/tables/users' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"

curl --location \
--request DELETE 'localhost:8082/v2/schemas/keyspaces/users_keyspace' \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json"
