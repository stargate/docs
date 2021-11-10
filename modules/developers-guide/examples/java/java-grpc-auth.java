// Stargate OSS configuration for locally hosted docker image
private static final String STARGATE_USERNAME      = "cassandra";
private static final String STARGATE_PASSWORD      = "cassandra";
private static final String STARGATE_HOST          = "localhost";
private static final int    STARGATE_GRPC_PORT     = 8090;
private static final String STARGATE_AUTH_ENDPOINT = "http://" + STARGATE_HOST+ ":8081/v1/auth";

// Authenticate to get a token (http client jdk11)
String token = getTokenFromAuthEndpoint(STARGATE_USERNAME, STARGATE_PASSWORD);

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
