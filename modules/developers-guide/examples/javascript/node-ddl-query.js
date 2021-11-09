// For Stargate OSS: Create a new keyspace
const createKeyspaceStatement = new Query();
// Set the CQL statement
createKeyspaceStatement.setCql("CREATE KEYSPACE IF NOT EXISTS test WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};");

await promisifiedClient.executeQuery(createKeyspaceStatement, authenticationMetadata);

console.log("created keyspace");

// For Stargate OSS: Create a new table
const createTableStatement = new Query();
// Set the CQL statement
createTableStatement.setCql("CREATE TABLE IF NOT EXISTS test.users (firstname text PRIMARY KEY, lastname text);");

await promisifiedClient.executeQuery(
  createTableStatement,
  authenticationMetadata
);

console.log("created table");
