#!/bin/bash

for FILE in *;
 do
    if [[ "$FILE" != "test"*".sh" ]]
    then
      #gsed -i 's#localhost:8082#{my_base_url}#; s#{base_api_schema_path}#{my_base_api_schema_path}#; s#/v2#{my_base_api_path}#' $FILE ;
      gsed -i 's#/v2#{my_base_api_path}#' $FILE ;
    fi
done
