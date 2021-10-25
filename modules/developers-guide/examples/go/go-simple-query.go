query := &pb.Query{
  Cql: "SELECT cluster_name FROM system.local",
}

response, err := stargateClient.ExecuteQuery(query)
