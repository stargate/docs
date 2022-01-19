// Stargate OSS configuration for locally hosted docker image
private static final String STARGATE_USERNAME      = "cassandra";
private static final String STARGATE_PASSWORD      = "cassandra";
private static final String STARGATE_HOST          = "localhost";
private static final int    STARGATE_GRPC_PORT     = 8090;
private static final String STARGATE_AUTH_ENDPOINT = "http://" + STARGATE_HOST+ ":8081/v1/auth";

public static void main(String[] args)
throws Exception {

    // Create Grpc Channel
    ManagedChannel channel = ManagedChannelBuilder
            .forAddress(STARGATE_HOST, STARGATE_GRPC_PORT).usePlaintext().build();

    // blocking stub version
    StargateGrpc.StargateBlockingStub blockingStub =
        StargateGrpc.newBlockingStub(channel)
            .withDeadlineAfter(10, TimeUnit.SECONDS)
            .withCallCredentials(new StargateBearerToken(token));
