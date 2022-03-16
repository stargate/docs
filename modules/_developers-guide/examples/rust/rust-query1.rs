// For Stargate OSS: SELECT the data to read from the table
// Select/query some data from the keyspace.table
let query = Query::builder()
  // Set the keyspace for the the query
  .keyspace("test")
  // Set consistency level
  .consistency(Consistency::One)
  .query("SELECT firstname, lastname FROM test.users;")
  // Build the query
  .build();

println!("select executed");
