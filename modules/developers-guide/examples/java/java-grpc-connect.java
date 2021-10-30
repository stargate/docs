package com.datastax.stargate.sdk.sandbox;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.Test;

import com.google.protobuf.InvalidProtocolBufferException;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.stargate.grpc.StargateBearerToken;
import io.stargate.proto.QueryOuterClass;
import io.stargate.proto.StargateGrpc;

public class GrpcTest {

    @Test
    public void test_gRPC_Stargate()
    throws IOException {

        // To get a token:
        // curl -L -X POST 'http://localhost:8081/v1/auth' -H 'Content-Type: application/json' --data-raw '{ "username": "cassandra", "password": "cassandra" }'
        String stargateToken = "<your_token>";
        String stargateHost  = "localhost";
        int    stargateport  = 8090;

        ManagedChannel mc = ManagedChannelBuilder
                            .forAddress(stargateHost, stargateport)
                            .usePlaintext() // <-- Stargate
                            .build();

        StargateGrpc.StargateBlockingStub blockingStub = StargateGrpc.newBlockingStub(mc)
                .withDeadlineAfter(10, TimeUnit.SECONDS)
                .withCallCredentials(new StargateBearerToken(stargateToken));
    }

}
