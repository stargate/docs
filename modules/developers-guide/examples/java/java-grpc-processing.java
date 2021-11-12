QueryOuterClass.ResultSet rs = queryString.getResultSet();

for (Row row : rs.getRowsList()) {
    System.out.println(""
            + "FirstName=" + row.getValues(0).getString() + ", "
            + "lastname=" + row.getValues(1).getString());
}
