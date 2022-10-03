curl --location --request POST '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' {
    "reader": {
       "name": "Amy Smith",
       "user_id": "12345",
       "birthdate": "10-01-1980",
       "email": {
           "primary": "asmith@gmail.com",
           "secondary": "amyispolite@aol.com"
       },
       "address": {
           "primary": {
               "street": "200 Antigone St",
               "city": "Nevertown",
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
               "rating": 4, 
               "review-date": "04-25-2002",
               "comment": "It was better than I thought."
           },
           {
               "book-title": "Pride and Prejudice", 
               "rating": 2, 
               "review-date": "12-02-2002",
               "comment": "It was just like the movie."
           }
       ]
    }
}'
