#!/bin/bash
set -e

export PATH=$HOME/codeql-home/codeql:$PATH

# https://hanatsuu.medium.com/codeql%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-9648f32ab5c1

sudo apt install maven -y

cd $HOME/codeql-home
git clone https://github.com/m-y-mo/struts_9805
cd struts_9805

codeql database create ./struts_db \
  -j 0 -l java --command "mvn -B -DskipTests \
  -DskipAssembly"

for ql in $(find $HOME/codeql-home/codeql-repo/java/ql -type f -name '*.ql');
do
    codeql database analyze struts_db \
      $ql \
      --format=csv --output=java-analysis/result.csv
done

for qls in $(find $HOME/codeql-home/codeql-repo/java/ql -type f -name '*.qls');
do
    codeql database analyze struts_db \
      $qls \
      --format=csv --output=java-analysis/result.csv
done
