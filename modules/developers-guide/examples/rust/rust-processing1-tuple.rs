for row in result_set.rows {
    let (login, emails): (String, Vec<String>) = row.try_into()?;
    // ...
}
