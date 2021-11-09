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
