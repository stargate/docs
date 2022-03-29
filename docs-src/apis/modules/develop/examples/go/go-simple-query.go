selectQuery := &pb.Query{
  Cql: "SELECT firstname, lastname FROM test.users;",
}

response, err := stargateClient.ExecuteQuery(selectQuery)
if err != nil {
  fmt.Printf("error executing query %v", err)
  return
}
fmt.Printf("select executed\n")
