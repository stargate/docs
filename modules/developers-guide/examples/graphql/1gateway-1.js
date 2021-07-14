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
