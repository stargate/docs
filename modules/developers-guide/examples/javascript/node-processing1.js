// Get the results from the execute query statement
// and separate into an array to print out the results

if (resultSet) {
  const resultSet = response.getResultSet();
  const rows = resultSet.getRowsList();

  // This for loop gets 2 results
  for ( let i = 0; i < 2; i++) {
    var valueToPrint = "";
    for ( let j = 0; j < 2; j++) {
      var value = rows[i].getValuesList()[j].getString();
      valueToPrint += value;
      valueToPrint += " ";
    }
    console.log(valueToPrint);
  }
}
