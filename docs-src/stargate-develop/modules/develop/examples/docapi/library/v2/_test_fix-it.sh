#!/bin/bash

for FILE in *;
 do
    if [[ "$FILE" != "test"* ]]
    then
      gsed --in-place "s#{base_doc_url_v2}#{base_doc_url_v2}#" $FILE 

    fi
done
