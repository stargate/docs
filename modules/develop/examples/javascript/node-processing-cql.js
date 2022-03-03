const insert = new Query();
insert.setCql("INSERT INTO ks1.tbl2 (id) VALUES (f066f76d-5e96-4b52-8d8a-0f51387df76b);");
await promisifiedClient.executeQuery(insert, authenticationMetadata);

// Read the data back out
const read = new Query();
read.setCql("SELECT id FROM ks1.tbl2");
const result = await promisifiedClient.executeQuery(read, authenticationMetadata);

const resultSet = result.getResultSet();

if (resultSet) {
  const firstRow = resultSet.getRowsList()[0];
  const idValue = firstRow.getValuesList()[0];
  try {
  const uuidAsString = toUUIDString(idValue);
  console.log(`UUID: ${uuidAsString}`);
  } catch (e) {
    console.error(`Conversion of Value to UUID string failed: ${e}`);
  }
}
