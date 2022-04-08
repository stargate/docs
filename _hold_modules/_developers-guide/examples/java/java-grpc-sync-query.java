QueryOuterClass.Response queryString = blockingStub.executeQuery(QueryOuterClass
        .Query.newBuilder()
        .setCql("SELECT firstname, lastname FROM test.users")
        .build());
