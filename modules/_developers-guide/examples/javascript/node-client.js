const bearerToken = new StargateBearerToken('my-token');
const credentials = grpc.credentials.combineChannelCredentials(
  grpc.credentials.createSsl(), StargateBearerToken
);

const stargateClient = new StargateClient(grpcEndpoint, credentials);
const promisifiedClient = promisifyStargateClient(stargateClient);

// No need to pass metadata;
// the credentials passed to the client constructor will do that for us
await promisifiedClient.executeQuery(query);
