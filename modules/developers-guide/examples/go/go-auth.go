grpc.WithPerRPCCredentials(
        auth.NewTableBasedTokenProvider(
          fmt.Sprintf("http://%s/v1/auth", authEndpoint), "cassandra", "cassandra",
        ),
      )
