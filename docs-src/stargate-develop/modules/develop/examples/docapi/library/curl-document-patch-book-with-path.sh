curl -X 'PATCH' \
  'http://{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}/book' \
  -H 'accept: application/json' \
  -H "X-Cassandra-Token: {auth_token}" \
  -H 'Content-Type: application/json' \
  -d '{
  "book": {
    "title": "Native Daughter",
    "isbn": "12322",
    "author": [
        "Richard Wright"
    ],
    "pub-year": 1930,
    "genre": [
        "slavery",
        "action"
    ],
    "format": [
        "hardback",
        "paperback",
        "epub"
    ],
    "languages": [
        "English",
        "German",
        "French"
    ]
  }
}'
