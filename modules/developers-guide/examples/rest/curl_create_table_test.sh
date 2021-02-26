curl -s --location \
--request POST {my_base_url}{my_base_api_schema_path}/keyspaces/users_keyspace/tables \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
	"name": "users2",
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
