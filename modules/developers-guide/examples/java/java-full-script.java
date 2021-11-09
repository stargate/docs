package com.datastax.tutorial;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.concurrent.TimeUnit;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.stargate.grpc.StargateBearerToken;
import io.stargate.proto.QueryOuterClass;
import io.stargate.proto.QueryOuterClass.Row;
import io.stargate.proto.StargateGrpc;

public class ConnectStargate {

    // Stargate OSS configuration for locally hosted docker image
    private static final String STARGATE_USERNAME      = "cassandra";
    private static final String STARGATE_PASSWORD      = "cassandra";
    private static final String STARGATE_HOST          = "localhost";
    private static final int    STARGATE_GRPC_PORT     = 8090;
    private static final String STARGATE_AUTH_ENDPOINT = "http://" + STARGATE_HOST+ ":8081/v1/auth";

    public static void main(String[] args)
    throws Exception {

        //-------------------------------------
        // 1. Initializing Connectivity
        //-------------------------------------

        // Authenticate to get a token (http client jdk11)
        String token = getTokenFromAuthEndpoint(STARGATE_USERNAME, STARGATE_PASSWORD);

        // Create Grpc Channel
        ManagedChannel channel = ManagedChannelBuilder
                .forAddress(STARGATE_HOST, STARGATE_GRPC_PORT).usePlaintext().build();

        // blocking stub version
        StargateGrpc.StargateBlockingStub blockingStub =
            StargateGrpc.newBlockingStub(channel)
                .withDeadlineAfter(10, TimeUnit.SECONDS)
                .withCallCredentials(new StargateBearerToken(token));

        //-------------------------------------
        // 2. Create Schema
        //-------------------------------------

        blockingStub.executeQuery(
                QueryOuterClass.Query.newBuilder()
                    .setCql(""
                        + "CREATE KEYSPACE IF NOT EXISTS test "
                        + "WITH REPLICATION = {"
                        + " 'class' : 'SimpleStrategy', "
                        + " 'replication_factor' : 1"
                        + "};")
                    .build());
        System.out.println("Keyspace 'test' has been created.");

        blockingStub.executeQuery(
                QueryOuterClass.Query.newBuilder()
                    .setCql("CREATE TABLE IF NOT EXISTS test.users (firstname text PRIMARY KEY, lastname text);")
                    .build());
        System.out.println("Table 'users' has been created.");

        //-------------------------------------
        // 3. Insert 2 rows with Batch
        //-------------------------------------

        blockingStub.executeBatch(
                QueryOuterClass.Batch.newBuilder()
                    .addQueries(
                        QueryOuterClass.BatchQuery.newBuilder()
                            .setCql("INSERT INTO test.users (firstname, lastname) VALUES('Jane', 'Doe')")
                            .build())
                    .addQueries(
                        QueryOuterClass.BatchQuery.newBuilder()
                            .setCql("INSERT INTO test.users (firstname, lastname) VALUES('Serge', 'Provencio')")
                            .build())
                    .build());
        System.out.println("2 rows have been inserted in table users.");

        //-------------------------------------
        // 4. Retrieving result.
        //-------------------------------------

        QueryOuterClass.Response queryString = blockingStub.executeQuery(QueryOuterClass
                .Query.newBuilder()
                .setCql("SELECT firstname, lastname FROM test.users")
                .build());
        QueryOuterClass.ResultSet rs = queryString.getResultSet();
        for (Row row : rs.getRowsList()) {
            System.out.println(""
                    + "FirstName=" + row.getValues(0).getString() + ", "
                    + "lastname=" + row.getValues(1).getString());
        }

        System.out.println("Everything worked!");
        System.exit(0);
    }

    private static String getTokenFromAuthEndpoint(String username, String password) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .GET()
                    .uri(URI.create(STARGATE_AUTH_ENDPOINT))
                    .setHeader("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString("{"
                            + " \"username\": \"" + STARGATE_USERNAME+ "\",\n"
                            + " \"password\": \"" + STARGATE_PASSWORD + "\"\n"
                            + "}'"))
                    .build();
            HttpResponse<String> response = HttpClient.newBuilder().build()
                    .send(request, HttpResponse.BodyHandlers.ofString());
            return response.body().split(":")[1].replaceAll("\"", "").replaceAll("}", "");
        } catch(Exception e) {
            throw new IllegalArgumentException(e);
        }
    }

}
