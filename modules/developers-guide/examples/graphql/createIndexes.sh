mutation createIndexes {
  book: createIndex(
    keyspaceName:"library",
    tableName:"book",
    columnName:"author",
    indexName:"author_idx",
    indexType: "org.apache.cassandra.index.sasi.SASIIndex"
  )
  reader: createIndex(
      keyspaceName:"library",
      tableName:"reader",
      columnName:"birthdate",
      indexName:"reader_bdate_idx",
      indexType: "org.apache.cassandra.index.sasi.SASIIndex"
  )
  reader2: createIndex(
      keyspaceName:"library",
      tableName:"reader",
      columnName:"email",
      indexName:"reader_email_idx"
  )
}
