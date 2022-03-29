# tag::setup[]
const { ApolloServer, gql } = require("apollo-server");
const { buildFederatedSchema } = require("@apollo/federation");

const port = 4001;
# end::setup[]

# tag::schema[]
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
    #author: [String]
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
# end::schema[]

# tag::resolvers[]
const resolvers = {

  Book: {
    orders(book) {
      return orders.filter(({ books }) => books.includes(book.title));
    }
  },
  Order: {
    book(order) {
      return order.book.map(title => ({ __typename: "Book", title }));
    }
  },
  Query: {
    order(_, args) {
      return orders.find(order => order.checkout_id == args.checkout_id);
    },
    orders() {
      return orders;
    }
  }
};
# end::resolvers[]
const server = new ApolloServer({
  schema: buildFederatedSchema([
    {
      typeDefs,
      resolvers
    }
  ])
});

# tag::server[]
server.listen({ port }).then(({ url }) => {
  console.log(`🚀 Orders service ready at ${url}`);
});

const orders = [
  { checkout_id: 1, reader: {name: "Herman Melville", user_id: "e0ec47e1-2b46-41ad-961c-70e6de629810"} , books: [ {title: "Moby Dick", isbn: "978-0140861723"}, {title: "Pride and Prejudice", isbn: "" } ] },
  { checkout_id: 2, reader: {name: "Jane Doe", user_id: "f02e2894-db48-4347-8360-34f28f958590"}, books: [ {title: "Native Son", isbn: "978-0061148507"}] }
];
# end::server[]
