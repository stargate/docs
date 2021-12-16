curl -s --location \
--request POST {base_url}{base_rest_schema}/{rkeyspace}/tables \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--data '{
	"name": "{rtable}",
	"columnDefinitions":
	  [
        {
	      "name": "{rpartitionkey}",
	      "typeDefinition": "text"
	    },
        {
	      "name": "{rclusteringkey}",
	      "typeDefinition": "text"
	    },
        {
	      "name": "favorite color",
	      "typeDefinition": "text"
	    }
	  ],
	"primaryKey":
	  {
	    "partitionKey": ["{rpartitionkey}"],
	    "clusteringKey": ["{rclusteringkey}"]
	  },
	"tableOptions":
	  {
	    "defaultTimeToLive": 0,
	    "clusteringExpression":
	      [{ "column": "{rclusteringkey}", "order": "ASC" }]
	  }
}'
