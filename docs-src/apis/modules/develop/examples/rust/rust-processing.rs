// This for loop to get the results
   for row in result_set.rows {
       let (firstname, lastname): (String, String) = row.try_into()?;
       println!("{} {}", firstname, lastname);
   }
