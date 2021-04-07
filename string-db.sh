#!/bin/bash

input='/path'
string_db_output='/stringdb/output'


function string_db {
  cd $input
  for f in *.txt; do
      r1=${f};
      r2=${f/.txt/}.tmp;
      r3=${f/.txt/}.tsv;
      cat $r1 | perl -pi -e 'chomp if eof' | tr -s "\n" "%" | sed -e 's/%/%0d/g' > $string_db_output/$r2 && \
      var=$(cat $string_db_output/$r2) && \
      wget -cO - https://string-db.org/api/tsv/enrichment?identifiers=$var > $string_db_output/$r3 && \
      rm $string_db_output/$r2
  done
  echo "string_db done!"
}

string_db
