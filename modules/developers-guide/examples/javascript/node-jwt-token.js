// Astra DB configuration
const astra_uri = "{astra-base-url}-{astra-region}.apps.astra.datastax.com:443";
const bearer_token = "AstraCS:xxxxxxx";

// Set up the authenication
// For Astra DB: Enter a bearer token for Astra, downloaded from the Astra DB dashboard
const bearerToken = new StargateBearerToken(bearer_token);
const credentials = grpc.credentials.combineChannelCredentials(grpc.credentials.createSsl(), bearerToken);

console.log(credentials);
