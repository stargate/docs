import {
  StargateClient,
  promisifyStargateClient,
} from "@stargate-oss/stargate-grpc-node-client";

const stargateClient = new StargateClient(
  "localhost:8090",
  grpc.credentials.createInsecure()
);

const promisifiedClient = promisifyStargateClient(stargateClient);
try {
  const queryResult = await promisifiedClient.executeQuery(
    query,
    metadata,
    callOptions
  );
  const batchResult = await promisifiedClient.executeBatch(
    query,
    metadata,
    callOptions
  );
} catch (e) {
  // something went wrong
}
