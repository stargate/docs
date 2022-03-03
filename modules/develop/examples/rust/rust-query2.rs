use std::convert::TryInto;

// Send the query and wait for gRPC response
let response = client.execute_query(query).await?;

// Convert the response into a ResultSet
let result_set: ResultSet = response.try_into()?;
