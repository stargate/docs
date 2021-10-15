go
// Insert a record into the table
_, err = stargateClient.ExecuteQuery(&pb.Query{
  Cql: "INSERT INTO ks1.tbl2 (key, value) VALUES ('a', 'alpha');",
})
if err != nil {
  return err
}

// Read the data back out
response, err := stargateClient.ExecuteQuery(&pb.Query{
  Cql: "SELECT key, value FROM ks1.tbl2",
})
if err != nil {
	return err
}

result, err := ToResultSet(response)

// We're calling ToString() here because we know the type being returned.
// If this was something like a UUID we would use ToUUID().
key, err := ToString(result.Rows[0].Values[0])
if err != nil {
  return err
}

fmt.Printf("key = %s\n", key)
