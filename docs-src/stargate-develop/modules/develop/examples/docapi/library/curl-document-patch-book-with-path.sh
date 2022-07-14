curl -X 'PATCH' \
  'http://{base_doc_url}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}/book' \
  -H 'accept: application/json' \
  -H 'X-Cassandra-Token: 018d894e-dd86-486f-ba9a-df9d132096bf' \
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
