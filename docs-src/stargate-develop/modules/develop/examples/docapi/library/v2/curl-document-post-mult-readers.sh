curl --location --request POST '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}/batch' \
--header "X-Cassandra-Token: {auth_token}" \
--header 'Content-Type: application/json' \
--data-raw ' [{
     "reader": {
        "name": "Jane Doe",
        "user_id": "12345",
        "birthdate": "10-01-1980",
        "email": {
            "primary": "jdoe@gmail.com",
            "secondary": "jane.doe@aol.com"
        },
        "address": {
            "primary": {
                "street": "100 Main St",
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
  },
  {
    "reader": {
       "name": "John Jones",
       "user_id": "54321",
       "birthdate": "06-11-2000",
       "email": {
           "primary": "jjones@gmail.com",
           "secondary": "johnnyj@aol.com"
       },
       "address": {
           "primary": {
               "street": "4593 Webster Ave",
               "city": "Paradise",
               "state": "CA",
               "zip-code": 95534
           }
       },
       "reviews": [
           {
               "book-title": "Moby Dick", 
               "rating": 2, 
               "review-date": "03-15-2020",
               "comment": "Boring book that I had to read for class."
           },
           {
               "book-title": "Pride and Prejudice", 
               "rating": 2, 
               "review-date": "0-02-2020",
               "comment": "Another boring book."
           }
       ]
    }
}
 ]'