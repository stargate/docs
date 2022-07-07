curl --location --request PUT '{base_doc_url}{base_doc_api}/{namespace}/collections/{collection2}/json-schema' \
--header 'X-Cassandra-Token: 448523ac-5444-464b-9e7a-a02099edb26a' \
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