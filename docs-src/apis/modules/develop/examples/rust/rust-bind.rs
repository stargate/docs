.query("SELECT login, emails FROM users WHERE id = :id")
.bind_value("id", 1000)
