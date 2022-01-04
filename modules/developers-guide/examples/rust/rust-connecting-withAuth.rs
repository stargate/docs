use stargate_grpc::*;
use std::str::FromStr;

// Set the Stargate OSS configuration for a locally running docker container:
let sg_uri = "http://localhost:8090/";
let auth_token = "06251024-5aeb-4200-a132-5336e73e5b6e";

// For Stargate OSS: create a client
let mut client = StargateClient::builder()
.uri(sg_uri)?
.auth_token(AuthToken::from_str(auth_token)?)
.connect()
.await?;

println!("created client {:?}", client);
