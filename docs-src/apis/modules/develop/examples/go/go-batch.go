batch := &pb.Batch{
  Type: pb.Batch_LOGGED,
  Queries: []*pb.BatchQuery{
    {
      Cql: "INSERT INTO test.users (firstname, lastname) VALUES ('Lorina', 'Poland');",
    },
    {
      Cql: "INSERT INTO test.users (firstname, lastname) VALUES ('Ronnie', 'Miller');",
    },
  },
}

_, err = stargateClient.ExecuteBatch(batch)
if err != nil {
  fmt.Printf("error creating batch %v", err)
  return
}
fmt.Printf("insert data\n")
