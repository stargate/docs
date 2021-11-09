package main

import (
	"fmt"
	"os"

	"github.com/stargate/stargate-grpc-go-client/stargate/pkg/auth"
	"github.com/stargate/stargate-grpc-go-client/stargate/pkg/client"
	pb "github.com/stargate/stargate-grpc-go-client/stargate/pkg/proto"

	"google.golang.org/grpc"
)

var stargateClient *client.StargateClient

func main() {

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

	// config := &tls.Config{
	// 	InsecureSkipVerify: false,
	// }
	//conn, err := grpc.Dial(grpcEndpoint, grpc.WithTransportCredentials(credentials.NewTLS(config)),
	//   grpc.WithBlock(),
	//   grpc.WithPerRPCCredentials(
	//     auth.NewTableBasedTokenProvider(
	//       fmt.Sprintf("http://%s/v1/auth", authEndpoint), username, passwd,
	//     ),
	//   ),
	// )

	stargateClient, err = client.NewStargateClientWithConn(conn)

	if err != nil {
		fmt.Printf("error creating client %v", err)
		os.Exit(1)
	}
	fmt.Printf("made client\n")

	// Create a new keyspace
	createKeyspaceStatement := &pb.Query{
		Cql: "CREATE KEYSPACE IF NOT EXISTS test WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};",
	}

	_, err = stargateClient.ExecuteQuery(createKeyspaceStatement)
	if err != nil {
		fmt.Printf("error creating keyspace %v", err)
		return
	}
	fmt.Printf("made keyspace\n")

	// Create a new table
	createTableQuery := &pb.Query{
		Cql: "CREATE TABLE IF NOT EXISTS test.users (firstname text PRIMARY KEY, lastname text);",
	}

	_, err = stargateClient.ExecuteQuery(createTableQuery)
	if err != nil {
		fmt.Printf("error creating table %v", err)
		return
	}
	fmt.Printf("made table \n")

	batch := &pb.Batch{
		Type: pb.Batch_LOGGED,
		Queries: []*pb.BatchQuery{
			{
				Cql: "INSERT INTO test.users (firstname, lastname) VALUES ('Jane', 'Doe');",
			},
			{
				Cql: "INSERT INTO test.users (firstname, lastname) VALUES ('Serge', 'Provencio');",
			},
		},
	}

	_, err = stargateClient.ExecuteBatch(batch)
	if err != nil {
		fmt.Printf("error creating batch %v", err)
		return
	}
	fmt.Printf("insert data\n")

	selectQuery := &pb.Query{
		Cql: "SELECT firstname, lastname FROM test.users;",
	}

	response, err := stargateClient.ExecuteQuery(selectQuery)
	if err != nil {
		fmt.Printf("error executing query %v", err)
		return
	}
	fmt.Printf("select executed\n")

	result := response.GetResultSet()

	var i, j int
	for i = 0; i < 2; i++ {
		valueToPrint := ""
		for j = 0; j < 2; j++ {
			value, err := client.ToString(result.Rows[i].Values[j])
			if err != nil {
				fmt.Printf("error getting value %v", err)
				os.Exit(1)
			}
			valueToPrint += " "
			valueToPrint += value
		}
		fmt.Printf("%v \n", valueToPrint)
	}
}
