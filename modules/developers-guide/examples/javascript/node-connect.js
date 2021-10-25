const stargateClient = new StargateClient(
  "localhost:8090",
  grpc.credentials.createInsecure()
);
