{
  "data": {
    "Joey": {
      "firstname": "Joey",
      "lastname": "Doe",
      "friends": [
        {"firstname": "Mary", "lastname": "Smith"},
        {"firstname": "James", "lastname": "Doe"}
      ]
    },
    "Martha": {
      "firstname": "Martha",
      "lastname": "Smith",
      "friends": [
        {"firstname": "Mary", "lastname": "Smith"},
        {"firstname": "Joey", "lastname": "Doe"}
      ]
    }
  }
}





12:29
Lorina Poland (she/her) If that would work.
12:29
Eric Borczuk ah ok
12:30
well for the above, both documents would match {"friends.[0].firstname": { "$eq": "Mary"}}
