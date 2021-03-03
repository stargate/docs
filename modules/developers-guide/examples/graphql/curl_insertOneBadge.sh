curl --location -g --request POST --url {my_base_url}{my_base_api_path}/{keyspaceName} \
--header "X-Cassandra-Token: $AUTH_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation insertOneBadge {\n  editor1: insertbadge(value: { user_id: "b5b5666b-2a37-4d0b-a5eb-053e54fc242b", badge_type: \"Editor\", badge_id: 100, earned: {key:\"Gold\", value:\"2020-11-20\"} } ) {\n    value {\n      user_id\n      badge_type\n      badge_id\n      earned\n    }\n  }\n}","variables":{}}'
