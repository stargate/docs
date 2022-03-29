CREATE CUSTOM INDEX books_idx 
  ON users_keyspace.users (VALUES(favorite_books)) 
  USING 'StorageAttachedIndex'
  WITH OPTIONS = ('case_sensitive': 'false');
