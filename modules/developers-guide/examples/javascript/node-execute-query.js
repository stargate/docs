stargateClient.executeQuery(
  query,
  authenticationMetadata,
  (error: grpc.ServiceError | null, value?: Response) => {
    if (error) {
      // something went wrong
    }
    if (value) {
      // the call succeeded
    }
  }
);
