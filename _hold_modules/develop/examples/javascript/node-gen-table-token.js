// Stargate OSS configuration for locally hosted docker image
const auth_endpoint = "http://localhost:8081/v1/auth";
const username = "cassandra";
const password = "cassandra";
const stargate_uri = "localhost:8090";

// Set up the authentication
// For Stargate OSS: Create a table based auth token Stargate/Cassandra
// authentication using the default C* username and password
const credentials = new StargateTableBasedToken(
  {authEndpoint: auth_endpoint,
    username: username,
    password: password
  }
);

// Uncomment if you need to check the credentials
// console.log(credentials);
