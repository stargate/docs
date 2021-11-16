import io.stargate.grpc.StargateBearerToken;

StargateGrpc.StargateBlockingStub blockingStub = StargateGrpc.newBlockingStub(channel)
                                                    .withCallCredentials(new StargateBearerToken("token-value"))
                                                    .withDeadlineAfter(5, TimeUnit.SECONDS);
