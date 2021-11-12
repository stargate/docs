package com.datastax.stargate.sdk.sandbox;
​
import java.io.IOException;
import java.util.concurrent.TimeUnit;
​
import org.junit.jupiter.api.Test;
​
import com.google.protobuf.InvalidProtocolBufferException;
​
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.stargate.grpc.StargateBearerToken;
import io.stargate.proto.QueryOuterClass;
import io.stargate.proto.StargateGrpc;
​
public class GrpcTest {

    @Test
    public void test_gRPC_Astra()
    throws InvalidProtocolBufferException {

        String dbId     = "<your_db>";
        String dbRegion = "<your_region>";
        String token    = "AstraCS:xxxxxxx";

        ManagedChannel mc = ManagedChannelBuilder
                            .forAddress(dbId + "-" + dbRegion + ".apps.astra.datastax.com", 443)
                            .useTransportSecurity() // SSL
                            //.usePlaintext()       // Plaintext
                            .build();

        StargateGrpc.StargateBlockingStub blockingStub =
                StargateGrpc.newBlockingStub(mc)
                .withDeadlineAfter(
                    10, TimeUnit.SECONDS) // deadline is > 5 because we execute DDL queries
                .withCallCredentials(new StargateBearerToken(token));

        QueryOuterClass.Response response = blockingStub.executeQuery(
                QueryOuterClass.Query
                    .newBuilder()
                    .setCql("SELECT data_center from system.local")
                    .build());

        QueryOuterClass.ResultSet rs = response.getResultSet();

        System.out.println(rs.getRowsList().get(0).getValues(0));
    }
