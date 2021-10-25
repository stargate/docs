
use config::*;
use connect::*;
use stargate_grpc::{Query, StargateClient};

#[path = "connect.rs"]
mod connect;

/// Creates a test keyspace with default settings.
pub async fn create_keyspace(client: &mut StargateClient, keyspace: &str) -> anyhow::Result<()> {
    let cql = format!(
        "CREATE KEYSPACE IF NOT EXISTS {} \
            WITH replication = {{'class': 'SimpleStrategy', 'replication_factor': 1}}",
        keyspace
    );
    let create_keyspace = Query::builder().query(cql.as_str()).build();
    client.execute_query(create_keyspace).await?;
    Ok(())
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let config = Config::from_args();
    let mut client = connect(&config).await?;
    println!("Connected to {}", config.url);
    create_keyspace(&mut client, config.keyspace.as_str()).await?;
    println!("Created keyspace {}", config.keyspace);
    Ok(())
}
