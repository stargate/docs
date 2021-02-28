curl --location --request POST --url {my_base_url}{my_base_api_path}{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"# insert a reader record that uses a TUPLE\nmutation insertJaneWithTuple{\n   jane: insertreader(\n     value: {\n       user_id: \"b5b5666b-2a37-4d0b-a5eb-053e54fc242b\"\n       name: \"Jane Doe\"\n       birthdate: \"2000-01-01\"\n       email: [\"janedoe@gmail.com\", \"janedoe@yahoo.com\"]\n       reviews: { item0: \"Moby Dick\", item1: 5, item2: \"2020-12-01\" }\n     }\n   ) {\n     value {\n       user_id\n       name\n       birthdate\n       reviews {\n        item0\n        item1\n        item2\n      }\n     }\n   }\n}","variables":{}}'
