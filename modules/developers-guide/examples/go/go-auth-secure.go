config := &tls.Config{}
conn, err := grpc.Dial(grpcEndpoint, grpc.WithTransportCredentials(credentials.NewTLS(config)),
    grpc.WithBlock(),
    grpc.WithPerRPCCredentials(
        auth.NewTableBasedTokenProvider(
          fmt.Sprintf("https://%s/v1/auth", authEndpoint), "cassandra", "cassandra",
        ),
    ),
)
