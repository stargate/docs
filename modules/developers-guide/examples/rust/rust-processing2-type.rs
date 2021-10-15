for row in result_set.rows {
    let login: String = row.get(0)?;
    let emails: Vec<String> = row.get(1)?;
    // ...
}
