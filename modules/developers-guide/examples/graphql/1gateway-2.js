const gateway = new ApolloGateway({

  serviceList: [

    // Stargate:
    { name: "library", url: "http://127.0.0.1:8080/graphql/library"},

    // External service (mock):
    { name: "orders", url: "http://localhost:4001/graphql" }
  ],

  introspectionHeaders: {
    'x-cassandra-token': stargateIntrospectionToken
  },

  buildService({name, url}) {
    if (name == "library") {
      return new StargateGraphQLDataSource({url});
    } else {
      return new RemoteGraphQLDataSource({url});
    }
  },

  // Experimental: Enabling this enables the query plan view in Playground.
  __exposeQueryPlanExperimental: true,
});
