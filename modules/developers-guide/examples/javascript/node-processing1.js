// Insert a record into the table
const insert = new Query();
insert.setCql("INSERT INTO ks1.tbl2 (key, value) VALUES ('a', 'alpha');");
await promisifiedClient.executeQuery(insert, authenticationMetadata);

// Read the data back out
const read = new Query();
read.setCql("SELECT key, value FROM ks1.tbl2");
const result = await promisifiedClient.executeQuery(read, authenticationMetadata);

const resultSet = result.getResultSet();

if (resultSet) {
  const firstRow = resultSet.getRowsList()[0];
  // We call getString() here because we know the type being returned.
  // See below for details on working with types.
  const key = firstRow.getValuesList()[0].getString();
  console.log(`key: ${key}`);
}
