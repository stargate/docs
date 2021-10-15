go
any, err := anypb.New(
  &pb.Values{
    Values: []*pb.Value{
      {
        Inner: &pb.Value_String_{
          String_: "system",
        },
      },
    },
  },
)
if err != nil {
	return err
}

query := &pb.Query{
  Cql: "SELECT * FROM system_schema.keyspaces WHERE keyspace_name = ?",
  Values: &pb.Payload{
    Type: pb.Payload_CQL,
    Data: any,
  },
  Parameters: &pb.QueryParameters{
    Tracing:      false,
    SkipMetadata: false,
  },
}
response, err := stargateClient.ExecuteQuery(query)
