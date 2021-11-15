// For Stargate OSS: SELECT the data to read from the table
const query = new Query();
const queryString = 'SELECT firstname, lastname FROM test.users;'
// Set the CQL statement using the string defined in the last line
query.setCql(queryString);

// For Stargate OSS: execute the query statement
const response = await promisifiedClient.executeQuery(
  query,
  authenticationMetadata
);

console.log("select executed")
