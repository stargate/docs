typescript
// Here value is the response in the gRPC callback function
const resultSet = toResultSet(value);
if (resultSet) {
  const rowsReturned = resultSet.getRowsList();
  rowsReturned.forEach(row, (index) => {
    const valuesInThisRow = row.getValuesList();
    // Assume we know/expect this is a string value based on our query
    const firstValueInRow = row.getValuesList()[0].getString();
    console.log(`First value in row ${index}: ${firstValueInRow}`);
  });
}
