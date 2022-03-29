// Create the gRPC client
// For Stargate OSS: passing it the address of the gRPC endpoint
const stargateClient = new StargateClient(stargate_uri, grpc.credentials.createInsecure());

console.log("made client");

// Create a promisified version of the client, so we don't need to use callbacks
const promisifiedClient = promisifyStargateClient(stargateClient);

console.log("promisified client")

// For Stargate OSS: generate authentication metadata that is passed in the executeQuery and executeBatch statements
const authenticationMetadata = await credentials.generateMetadata({service_url: auth_endpoint});
