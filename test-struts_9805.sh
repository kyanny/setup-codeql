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

codeql analyze struts_db \
  ../codeql-repo/ql/java/ql/src/Security/CWE/CWE-502/UnsafeDeserialization.ql \
  --format=csv --output=java-analysis/result.csv