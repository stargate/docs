QueryOuterClass.Response response =
                blockingStub.executeBatch(
                        QueryOuterClass.Batch.newBuilder()
                                .addQueries(QueryOuterClass.BatchQuery.newBuilder().setCql("INSERT INTO ks.test (k, v) VALUES ('a', 1)").build())
                                .addQueries(
                                        QueryOuterClass.BatchQuery.newBuilder().setCql("INSERT INTO ks.test (k, v) VALUES ('b', 2)").build())
                                .build());
