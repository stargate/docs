#!/bin/bash

rm schema_deploy.gql; rm schema_file.gql;

# include header and footer for copy/paste into graphql playground
cat schema_header.gql schema_udt.gql schema_book.gql schema_reader.gql schema_libColl.gql schema_queries.gql schema_mutations.gql schema_footer.gql > schema_deploy.gql

# include header and footer for copy/paste into graphql playground
# QUERY AND MUTATIONS GROUPED WITH TYPES
cat schema_udt.gql schema_book.gql schema_reader.gql schema_libColl.gql > schema_newfile.gql

# don't include the header and footer
cat schema_udt.gql schema_book.gql schema_reader.gql schema_libColl.gql schema_queries.gql schema_mutations.gql > schema_file.gql
