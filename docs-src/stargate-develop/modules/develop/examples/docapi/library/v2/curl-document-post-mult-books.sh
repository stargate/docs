curl --location --request POST '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/batch' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' [{
     "book": {
         "title": "Moby Dick",
         "isbn": "12345",
         "author": [
             "Herman Melville"
         ],
         "pub-year": 1899,
         "genre": [
             "adventure",
             "ocean",
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
    },
 {
     "book": {
         "title": "Pride and Prejudice",
         "isbn": "45674",
         "author": [
             "Jane Austen"
         ],
         "pub-year": 1890,
         "genre": [
             "romance",
             "England",
             "regency"
         ],
         "format": [
             "hardback",
             "paperback",
             "epub"
         ],
         "languages": [
             "English",
             "Japanese",
             "French"
         ]
     }
 },
     {
        "book": {
            "title": "The Art of French Cooking",
            "isbn": "19922",
            "author": [
                "Julia Child",
                "Simone Beck",
                "Louisette Bertholle"
            ],
            "pub-year": 1960,
            "genre": [
                "cooking",
                "French cuisine"
            ],
            "format": [
                "hardback",
                "paperback",
                "epub"
            ],
            "languages": [
                "English",
                "German",
                "French",
                "Belgian"
            ]
        }
    }
]'