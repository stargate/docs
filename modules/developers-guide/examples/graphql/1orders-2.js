const typeDefs = gql`

  # need to declare types used by cql
  scalar Uuid
  scalar Date

  type Order @key(fields: "checkout_id reader books") {
    checkout_id: Int!
    reader: Reader
    books: [Book]
  }

  # Stub of the book entity from Stargate:
  # Add an extension for Order to find a checkout for a book
  extend type Book @key(fields: "title isbn") {
    title: String! @external
    isbn: String @external
    orders: [Order]
  }

  # Stub of the reader entity from Stargate:
  # Add an extension for Order to find a checkout for a reader
  extend type Reader @key(fields: "name user_id") {
    name: String! @external
    user_id: Uuid! @external
    orders: [Order]
  }

  extend type Query {
    order(checkout_id: Int!): Order
    orders: [Order]
  }
`;
