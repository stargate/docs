// Assume we know this is a string
const firstValueInRow = row.getValuesList()[0];

// This should resolve to true
const isString = firstValueInRow.hasString();
// This should resolve to the string value
const stringValue = firstValueInRow.getString();

// This should resolve to false
const isInt = firstValueInRow.hasInt();
// This should resolve to 0 - zero value for this data type
const intValue = firstValueInRow.getInt();
