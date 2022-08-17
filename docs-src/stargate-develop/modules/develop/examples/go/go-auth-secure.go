grpcEndpoint := "localhost:8090"
authEndpoint := "localhost:8081"
username := "cassandra"
passwd := "cassandra"

config := &tls.Config{
 	InsecureSkipVerify: false,
}
conn, err := grpc.Dial(grpcEndpoint, grpc.WithTransportCredentials(credentials.NewTLS(config)),
  grpc.WithBlock(),
  grpc.WithPerRPCCredentials(
    auth.NewTableBasedTokenProvider(
      fmt.Sprintf("http://%s/v1/auth", authEndpoint), username, passwd,
    ),
  ),
)
