StargateGrpc.StargateStub = fStargateGrpc.newStub(channel)
  .withCallCredentials(new StargateBearerToken("token-value"))
  .withDeadlineAfter(5, TimeUnit.SECONDS);
