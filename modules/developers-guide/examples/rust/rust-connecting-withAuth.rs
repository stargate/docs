use std::str::FromStr;

let mut client = StargateClient::builder()
    .uri("http://localhost:8090/")?                           // replace with a proper address
    .auth_token(AuthToken::from_str("XXXX-YYYY-ZZZZ...")?)    // replace with a proper token
    .tls(Some(client::default_tls_config()?))                 // optionally enable TLS
    .connect()
    .await?;
