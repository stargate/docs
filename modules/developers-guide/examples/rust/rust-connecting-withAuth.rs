// main.rs

use stargate_grpc::*;

// set url to a Stargate URL
let url = "http://localhost:8090";

// substitute with a generated authentication token
let token = "00000000-0000-0000-0000-000000000000";
let token = AuthToken::from_str(token).unwrap();

// connect to the server
let channel = Endpoint::new(url)?.connect().await?;

// create the authenticating client
let mut client = StargateClient::with_auth(channel, token);


// LLP - NEED TO CHECK OUT THIS code
// https://github.com/stargate/stargate-grpc-rust-client/blob/master/stargate-grpc/examples/connect.rs
//! Demonstrates how to connect to Stargate
//
// use config::Config;
// use stargate_grpc::StargateClient;
//
// #[path = "config.rs"]
// pub mod config;
//
// /// Connects to Stargate and returns a client that can run queries.
// pub async fn connect(config: &Config) -> anyhow::Result<StargateClient> {
//     Ok(StargateClient::builder()
//         .uri(config.url.as_str())?
//         .auth_token(config.token.clone())
//         .tls(config.tls_config()?)
//         .connect()
//         .await?)
// }
//
// #[allow(unused)]
// #[tokio::main]
// async fn main() -> anyhow::Result<()> {
//     let config = Config::from_args();
//     let mut client = connect(&config).await?;
//     println!("Connected to {}", config.url);
//     Ok(())
// }
