curl --location --request PUT '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{bookdocid}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '     {
        "book": {
            "title": "Native Son",
            "isbn": "12322",
            "author": [
                "Richard Wright"
            ],
            "pub-year": 1930,
            "genre": [
                "poverty",
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
    }
'
