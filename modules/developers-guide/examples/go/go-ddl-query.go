// Create a new keyspace
createKeyspaceQuery := &pb.Query{
	Cql: "CREATE KEYSPACE IF NOT EXISTS test WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};",
}

_, err = stargateClient.ExecuteQuery(createKeyspaceQuery)
if err != nil {
	fmt.Printf("error creating keyspace %v", err)
	return
}
fmt.Printf("made keyspace\n")

// Create a new table
createTableQuery := &pb.Query{
	Cql: "CREATE TABLE IF NOT EXISTS test.users (firstname text PRIMARY KEY, lastname text);",
}

_, err = stargateClient.ExecuteQuery(createTableQuery)
if err != nil {
	fmt.Printf("error creating table %v", err)
	return
}
fmt.Printf("made table \n")
