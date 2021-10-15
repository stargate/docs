go
batch := &pb.Batch{
  Type:       pb.Batch_LOGGED,
  Queries:    []*pb.BatchQuery{
    {
      Cql: "INSERT INTO ks1.tbl2 (key, value) VALUES ('a', 'alpha');",
    },
    {
      Cql: "INSERT INTO ks1.tbl2 (key, value) VALUES ('b', 'bravo');",
    },
  },
}

response, err := stargateClient.ExecuteBatch(batch)
