# tag::gateway1[]
const { ApolloServer } = require("apollo-server");
const { ApolloGateway, RemoteGraphQLDataSource } = require("@apollo/gateway");

// The Stargate token that Apollo Gateway will use when it fetches the schema
// definitions.
// Note that this will only be used for internal queries; for user queries, the
// client must provide their own 'x-cassandra-token' HTTP header, and the
// gateway will forward it to Stargate.
const stargateIntrospectionToken = 'd5e7e1fb-399b-4f0b-964b-296ee97d59d3';

class StargateGraphQLDataSource extends RemoteGraphQLDataSource {
  willSendRequest({ request, context }) {
    const token = context.stargateToken
    if (token != null) {
      request.http.headers.set('x-cassandra-token', token);
    }
  }
}
# end::gateway1[]

# tag::gateway2[]
const gateway = new ApolloGateway({

  serviceList: [

    // Stargate:
    { name: "library", url: "https://127.0.0.1:8080/graphql/library"},

    // External service (mock):
    { name: "orders", url: "https://localhost:4001/graphql" }
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
# end::gateway2[]

# tag::gateway3[]
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
# end::gateway3[]
