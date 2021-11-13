// For Stargate OSS only: create a keyspace
let create_keyspace = Query::builder()
    .query("CREATE KEYSPACE IF NOT EXISTS test WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor':1};")
    .build();
client.execute_query(create_keyspace).await?;

println!("created keyspace");

// For Stargate OSS: create a table
let create_table = Query::builder()
    .query(
        "CREATE TABLE IF NOT EXISTS test.users \
            (firstname text, lastname text, PRIMARY KEY (firstname, lastname));",
    )
    .build();
 client.execute_query(create_table).await?;

 println!("created table");
