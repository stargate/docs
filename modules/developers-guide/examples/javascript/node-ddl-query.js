// Create a new keyspace
const createKeyspaceStatement = new Query();
createKeyspaceStatement.setCql("CREATE KEYSPACE IF NOT EXISTS ks1 WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};");

await promisifiedClient.executeQuery(query, authenticationMetadata);

// Create a new table
const createTableStatement = new Query();
createTableStatement.setCql("CREATE TABLE IF NOT EXISTS ks1.tbl2 (key text PRIMARY KEY,value text);");

await promisifiedClient.executeQuery(query, authenticationMetadata);
