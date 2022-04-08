// For Stargate OSS: INSERT two rows/records
 // Create two queries that will be run in a batch statement
 const insertOne = new BatchQuery();
 const insertTwo = new BatchQuery();

 // Set the CQL statement
 insertOne.setCql(`INSERT INTO test.users (firstname, lastname) VALUES('Jane', 'Doe')`);
 insertTwo.setCql(`INSERT INTO test.users (firstname, lastname) VALUES('Serge', 'Provencio')`);

 // Define the new batch to include the 2 insertions
 const batch = new Batch();
 batch.setQueriesList([insertOne, insertTwo]);

 // For Stargate OSS: execute the batch statement
 const batchResult = await promisifiedClient.executeBatch(
   batch,
   authenticationMetadata
 );
 console.log("inserted data");
