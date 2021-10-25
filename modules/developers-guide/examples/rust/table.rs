//! Demonstrates writing and reading chrono dates and timestamps

use std::convert::TryInto;

use chrono::{Date, DateTime, Local};

use connect::config::*;
use connect::*;
use stargate_grpc::*;

#[path = "connect.rs"]
mod connect;

/// Creates the test keyspace and an empty `users` table.
async fn create_schema(client: &mut StargateClient, keyspace: &str) -> anyhow::Result<()> {
    let create_table = Query::builder()
        .keyspace(keyspace)
        .query(
            r"CREATE TABLE IF NOT EXISTS events (
                sensor bigint,
                day date,
                ts timestamp,
                value varchar,
                PRIMARY KEY ((sensor, day), ts)
            )",
        )
        .build();
    client.execute_query(create_table).await?;
    Ok(())
}
