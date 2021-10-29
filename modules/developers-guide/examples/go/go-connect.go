package main

import (
    "fmt"
    "os"

    "github.com/stargate/stargate-grpc-go-client/stargate/pkg/auth"
    "github.com/stargate/stargate-grpc-go-client/stargate/pkg/client"
    "google.golang.org/grpc"
)

var stargateClient *client.StargateClient

func main() {
    grpcEndpoint := "localhost:8090"
    authEndpoint := "localhost:8081"

    conn, err := grpc.Dial(grpcEndpoint, grpc.WithInsecure(), grpc.WithBlock(),
      grpc.WithPerRPCCredentials(
        auth.NewTableBasedTokenProviderUnsafe(
          fmt.Sprintf("http://%s/v1/auth", authEndpoint), "cassandra", "cassandra",
        ),
      ),
    )
    if err != nil {
        fmt.Printf("error dialing connection %v", err)
        os.Exit(1)
    }

    stargateClient, err = client.NewStargateClientWithConn(conn)
    if err != nil {
        fmt.Printf("error creating client %v", err)
        os.Exit(1)
    }
}
