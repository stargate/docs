ResultSet rs = response
  .getResultSet()
  .getData()
  .unpack(QueryOuterClass.ResultSet.class);

rs.getRows(0).getValues(0).getString(); // it will return value for k = "a"
rs.getRows(0).getValues(1).getInt(); // it will return value for v = 1
