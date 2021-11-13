StreamObserver<QueryOuterClass.Response> streamObserver = new StreamObserver<QueryOuterClass.Response>() {
           @Override
           public void onNext(QueryOuterClass.Response response) {
               try {
                   System.out.println("response:" + response.getResultSet());
               } catch (InvalidProtocolBufferException e) {
                   throw new RuntimeException(e);
               }
           }
           @Override
           public void onError(Throwable throwable) {
               System.out.println("Error: " + throwable);
           }
           @Override
           public void onCompleted() {
               // close resources, finish processing
               System.out.println("completed");
           }
       };
