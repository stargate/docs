blockingStub.executeQuery(
        QueryOuterClass.Query.newBuilder()
            .setCql(""
                + "CREATE KEYSPACE IF NOT EXISTS test "
                + "WITH REPLICATION = {"
                + " 'class' : 'SimpleStrategy', "
                + " 'replication_factor' : 1"
                + "};")
            .build());
System.out.println("Keyspace 'test' has been created.");

blockingStub.executeQuery(
        QueryOuterClass.Query.newBuilder()
            .setCql("CREATE TABLE IF NOT EXISTS test.users (firstname text PRIMARY KEY, lastname text);")
            .build());
System.out.println("Table 'users' has been created.");
