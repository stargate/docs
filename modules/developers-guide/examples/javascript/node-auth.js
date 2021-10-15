typescript
const stargateCallCredentials = new TableBasedCallCredentials({
  username: "cassandra",
  password: "cassandra",
});

try {
  const stargateAuthMetadata = await stargateCallCredentials.generateMetadata({
    service_url: "http://localhost:8081/v1/auth",
  });
} catch (e) {
  // Something went wrong calling the auth endpoint
  throw e;
}
