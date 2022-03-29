const stargateClient = new StargateClient(
  grpcEndpoint, grpc.credentials.createInsecure());

const promisifiedClient = promisifyStargateClient(stargateClient);

const authenticationMetadata = await creds.generateMetadata(
  {service_url: 'http://localhost:8081/v1/auth'});
await promisifiedClient.executeQuery(query, authenticationMetadata);
