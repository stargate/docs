import io.stargate.proto.QueryOuterClass.Response;
import io.stargate.proto.QueryOuterClass;

Response response =
        blockingStub.executeQuery(
                        QueryOuterClass.Query
                                    .newBuilder().setCql("INSERT INTO ks.test (k, v) VALUES ('a', 1)").build());
