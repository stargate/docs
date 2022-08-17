CREATE CUSTOM INDEX eval_idx
  ON users_keyspace.users (KEYS(evaluations))
  USING 'StorageAttachedIndex'
  WITH OPTIONS = ('case_sensitive': 'false');
