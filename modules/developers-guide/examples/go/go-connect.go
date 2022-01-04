stargateClient, err = client.NewStargateClientWithConn(conn)

if err != nil {
  fmt.Printf("error creating client %v", err)
  os.Exit(1)
}
fmt.Printf("made client\n")
