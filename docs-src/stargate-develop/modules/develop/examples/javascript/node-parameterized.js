const query = new Query();
query.setCql("select * from system_schema.keyspaces where keyspace_name = ?");

const keyspaceNameValue = new Value();
keyspaceNameValue.setString("system");

const queryValues = new Values();
queryValues.setValuesList([keyspaceNameValue]);

query.setValues(queryValues);

const queryParameters = new QueryParameters();
queryParameters.setTracing(false);
queryParameters.setSkipMetadata(false);

query.setParameters(queryParameters);

const response = await promisifiedClient.executeQuery(query, metadata);
