go
query := &pb.Query{
  Cql: "SELECT cluster_name FRoM system.local",
}

response, err := stargateClient.ExecuteQuery(query)
