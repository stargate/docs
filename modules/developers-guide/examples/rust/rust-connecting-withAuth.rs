// set url to a Stargate URL
let url = "http://localhost:8090";

// substitute with a generated authentication token
let token = "00000000-0000-0000-0000-000000000000";
let token = AuthToken::from_str(token).unwrap();

// connect to the server
let channel = Endpoint::new(url)?.connect().await?;

// create the authenticating client
let mut client = StargateClient::with_auth(channel, token);
