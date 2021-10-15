let query = Query::builder()
  // Set the keyspace for the the query
  .keyspace("test")
  // Set consistency level
  .consistency(Consistency::LocalQuorum)
  // Bind the :id to 1000
  .query("SELECT login, emails FROM users WHERE id = :id")
  .bind_value("id", 1000)
  // Build the query
  .build();
