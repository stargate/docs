/// Inserts a user into both tables with a single batch of statements
async fn register_user(
    client: &mut StargateClient,
    keyspace: &str,
    id: i64,
    login: &str,
) -> anyhow::Result<i64> {
    let batch = Batch::builder()
        .keyspace(keyspace)
        .query("INSERT INTO users (id, login, emails) VALUES (:id, :login, :emails)")
        .bind_name("id", id)
        .bind_name("login", login)
        .bind_name("emails", vec![format!("{}@example.net", login)])
        .query("INSERT INTO users_by_login (id, login) VALUES (:id, :login)")
        .bind_name("id", id)
        .bind_name("login", login)
        .build();

    client.execute_batch(batch).await?;
    Ok(id)
}
