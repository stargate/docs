CREATE INDEX evalk_idx ON users_keyspace.users (KEYS (evaluations));
CREATE INDEX evalv_idx ON users_keyspace.users (VALUES (evaluations));
CREATE INDEX evale_idx ON users_keyspace.users (ENTRIES (evaluations));
