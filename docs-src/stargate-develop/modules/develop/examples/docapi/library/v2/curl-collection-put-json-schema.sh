curl --location --request PUT '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection2}/json-schema' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '{
  "title": "Person",
  "type": "object",
  "properties": {
    "firstName": {
      "type": "string",
      "description": "The person'\''s first name."
    },
    "lastName": {
      "type": "string",
      "description": "The person'\''s last name."
    },
    "age": {
      "description": "Age in years which must be equal to or greater than zero.",
      "type": "integer",
      "minimum": 0
    }
  }
}
'