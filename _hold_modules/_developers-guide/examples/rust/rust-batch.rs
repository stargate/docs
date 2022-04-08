// For Stargate OSS: INSERT two rows/records
//  Two queries will be run in a batch statement
let batch = Batch::builder()
    .keyspace("test")                   // set the keyspace the query applies to
    .consistency(Consistency::One)      // set consistency level
    .query("INSERT INTO test.users (firstname, lastname) VALUES ('Jane', 'Doe');")
    .query("INSERT INTO test.users (firstname, lastname) VALUES ('Serge', 'Provencio');")
    .build();
client.execute_batch(batch).await?;

println!("insert data");
