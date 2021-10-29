const insertOne = new BatchQuery();
const insertTwo = new BatchQuery();

insertOne.setCql(`INSERT INTO ${KEYSPACE}.test (key, value) VALUES('a', 1)`);
insertTwo.setCql(`INSERT INTO ${KEYSPACE}.test (key, value) VALUES('b', 2)`);

const batch = new Batch();
batch.setQueriesList([insertOne, insertTwo]);

await promisifiedClient.executeBatch(batch, authenticationMetadata);
