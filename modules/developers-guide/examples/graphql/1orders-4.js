const server = new ApolloServer({
  schema: buildFederatedSchema([
    {
      typeDefs,
      resolvers
    }
  ])
});

server.listen({ port }).then(({ url }) => {
  console.log(`🚀 Orders service ready at ${url}`);
});

const orders = [
  { checkout_id: 1, reader: {name: "Herman Melville", user_id: "e0ec47e1-2b46-41ad-961c-70e6de629810"} , books: [ {title: "Moby Dick", isbn: "978-0140861723"}, {title: "Pride and Prejudice", isbn: "" } ] },
  { checkout_id: 2, reader: {name: "Jane Doe", user_id: "f02e2894-db48-4347-8360-34f28f958590"}, books: [ {title: "Native Son", isbn: "978-0061148507"}] }
];
