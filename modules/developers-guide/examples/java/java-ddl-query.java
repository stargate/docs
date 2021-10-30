private void prepareSchema() {

   blockingStub.executeQuery(
       QueryOuterClass.Query.newBuilder()
           .setCql(
               "CREATE KEYSPACE IF NOT EXISTS ks WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor':'1'};")
           .build());

   blockingStub.executeQuery(
       QueryOuterClass.Query.newBuilder()
           .setCql("CREATE TABLE IF NOT EXISTS ks.test (k text, v int, PRIMARY KEY(k, v))")
           .build());
 }
