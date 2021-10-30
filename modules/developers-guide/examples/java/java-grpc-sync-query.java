QueryOuterClass.Response response = blockingStub.executeQuery(
        QueryOuterClass.Query
            .newBuilder()
            .setCql("SELECT data_center from system.local")
            .build());
