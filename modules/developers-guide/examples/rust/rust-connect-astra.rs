use std::error::Error;
use std::str::FromStr;
use std::convert::TryInto;
use stargate_grpc::*;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    let mut client = StargateClient::builder()
    .uri("https://28fafa19-84f0-4f36-a42f-b360d3237a94-us-east-1.apps.astra.datastax.com/stargate")?
    .auth_token(AuthToken::from_str("AstraCS:mwlftanNZvRZTiPAhfeMwzZF:b499d86052cf42cd691fa7590f2adf4ce757d84d5f84174e836e53b0b5b8f3eb")?)
    .tls(Some(client::default_tls_config()?))   // optional
    .connect()
    .await?;

    println!("{:?}", client);

    let query = Query::builder()
    .keyspace("yeet")                           // set the keyspace the query applies to
    .consistency(Consistency::LocalQuorum)      // set consistency level
    .query("SELECT firstname, lastname FROM again.users")
    // .bind_name("id", 1000)                      // bind :id to 1000
    .build();

    let response = client.execute_query(query).await?;  // send the query and wait for gRPC response
    let result_set: ResultSet = response.try_into()?;   // convert the response into ResultSet

    for row in result_set.rows {
        let (firstname, lastname): (String, String) = row.try_into()?;
        println!("{} {}", firstname, lastname);
    }

    Ok(())
}
