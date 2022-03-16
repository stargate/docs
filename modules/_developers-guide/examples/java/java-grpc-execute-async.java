stub.executeQuery(QueryOuterClass.Query
  .newBuilder()
  .setCql("SELECT k, v FROM ks.test")
  .build(), streamObserver);
