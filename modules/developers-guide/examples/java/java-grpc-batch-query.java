blockingStub.executeBatch(
        QueryOuterClass.Batch.newBuilder()
            .addQueries(
                QueryOuterClass.BatchQuery.newBuilder()
                    .setCql("INSERT INTO test.users (firstname, lastname) VALUES('Jane', 'Doe')")
                    .build())
            .addQueries(
                QueryOuterClass.BatchQuery.newBuilder()
                    .setCql("INSERT INTO test.users (firstname, lastname) VALUES('Serge', 'Provencio')")
                    .build())
            .build());
System.out.println("2 rows have been inserted in table users.");
