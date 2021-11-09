grpcEndpoint := "localhost:8090"
authEndpoint := "localhost:8081"
username := "cassandra"
passwd := "cassandra"

conn, err := grpc.Dial(grpcEndpoint, grpc.WithInsecure(), grpc.WithBlock(),
  grpc.WithPerRPCCredentials(
    auth.NewTableBasedTokenProviderUnsafe(
      fmt.Sprintf("http://%s/v1/auth", authEndpoint), username, passwd,
    ),
  ),
)
