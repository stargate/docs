go
// Create a new keyspace
createKeyspaceStatement := &pb.Query{
  Cql: "CREATE KEYSPACE IF NOT EXISTS ks1 WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};",
}
_, err = stargateClient.ExecuteQuery(createKeyspaceStatement)
if err != nil {
  return err
}

// Create a new table
createTableStatement := `
  CREATE TABLE IF NOT EXISTS ks1.tbl2 (
    key TEXT PRIMARY KEY,
    value TEXT
  );`
createTableQuery := &pb.Query{
	Cql: createTableStatement,
}

_, err = stargateClient.ExecuteQuery(createTableQuery)
if err != nil {
  return err
}
