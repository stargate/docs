import * as grpc from "@grpc/grpc-js";
import { StargateClient, TableBasedCallCredentials, Query, toResultSet, Response, promisifyStargateClient } from "@stargate/stargate-grpc-node-client";

// Create a client for Stargate/Cassandra authentication using the default C* username and password
const creds = new TableBasedCallCredentials({username: 'cassandra', password: 'cassandra'});

// Create the gRPC client, passing it the address of the gRPC endpoint
const stargateClient = new StargateClient('localhost:8090', grpc.credentials.createInsecure());

// Create a promisified version of the client, so we don't need to use callbacks
const promisifiedClient = promisifyStargateClient(stargateClient);

try {

    const authenticationMetadata = await creds.generateMetadata({service_url: 'http://localhost:8081/v1/auth'});

    const query = new Query();
    query.setCql('SELECT cluster_name FROM system.local');

    const result: Response = await promisifiedClient.executeQuery(query, authenticationMetadata);

    const resultSet = toResultSet(result);

    if (resultSet) {
        const firstRowReturned = resultSet.getRowsList()[0];
        const clusterName = firstRowReturned.getValuesList()[0].getString();
        console.log(`cluster name returned from gRPC call: ${clusterName}`);
    }

} catch (e) {
    console.error(`Error making gRPC call: ${e}`)
}
