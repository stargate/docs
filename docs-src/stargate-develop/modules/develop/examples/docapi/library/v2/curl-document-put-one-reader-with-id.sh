curl --location --request PUT '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/{readerdocid}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw '     {
     "reader": {
        "name": "John Smith",
        "user_id": "12346",
        "birthdate": "11-01-1992",
        "email": {
            "primary": "jsmith@gmail.com",
            "secondary": "john.smith@aol.com"
        },
        "address": {
            "primary": {
                "street": "200 Z St",
                "city": "Evertown",
                "state": "MA",
                "zip-code": 55555
            },
            "secondary": {
                "street": "850 2nd St",
                "city": "Evertown",
                "state": "MA",
                "zip-code": 55556
            }
        },
        "reviews": [
            {
                "book-title": "Moby Dick", 
                "rating": 3, 
                "review-date": "02-02-2002",
                "comment": "It was okay."
            },
            {
                "book-title": "Pride and Prejudice", 
                "rating": 5, 
                "review-date": "03-02-2002",
                "comment": "It was a wonderful book! I loved reading it."
            }
        ]
     }
 }
'
