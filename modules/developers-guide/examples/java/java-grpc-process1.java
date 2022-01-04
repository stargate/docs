Response response = stub.executeQuery(
  QueryOuterClass.Query
    .newBuilder()
    .setCql("SELECT k, v FROM ks.test")
    .build());
