(async () => {
  const server = new ApolloServer({
    gateway,

    // Apollo Graph Manager (previously known as Apollo Engine)
    // When enabled and an `ENGINE_API_KEY` is set in the environment,
    // provides metrics, schema management and trace reporting.
    engine: false,

    // Subscriptions are unsupported but planned for a future Gateway version.
    subscriptions: false,

    context: ({ req, res }) => {
      return {
        stargateToken: req.headers['x-cassandra-token']
      };
    }
  });

  server.listen().then(({ url }) => {
    console.log(`🚀 Gateway ready at ${url}`);
  });
})();
