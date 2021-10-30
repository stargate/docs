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

        String dbId     = "27db15ce-d2cc-47ce-a7f9-bbff218a68b7";
        String dbRegion = "europe-west1";
        String token    = "AstraCS:yNZhDDoXfjIwYADeGRLYKYKp:ff15894eb27859aa66ae91b46388f3018f251764f12f1131221409b5ddbf0425";

        ManagedChannel mc = ManagedChannelBuilder
                            .forAddress(dbId + "-" + dbRegion + ".apps.astra.datastax.com", 443)
                            .useTransportSecurity() // <-- Astra
                            //.usePlaintext() // <-- Stargate
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

        QueryOuterClass.ResultSet rs =
                response.getResultSet().getData().unpack(QueryOuterClass.ResultSet.class);

        System.out.println(rs.getRowsList().get(0).getValues(0));
    }
