#!/bin/bash
set -e

export PATH=$HOME/codeql-home/codeql:$PATH

# http://f4bb1t.com/post/2020/12/14/codeql-for-golang-practise1/

cd $HOME
#wget -nc https://golang.org/dl/go1.15.15.linux-amd64.tar.gz
wget -nc https://golang.org/dl/go1.17.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

cd $HOME/codeql-home
rm -rf gojenkins
git clone https://github.com/bndr/gojenkins
cd gojenkins

codeql database create codeql_database --language=go
mkdir -p codeql-analysis
for ql in $(find $HOME/codeql-home/codeql-go/ql -type f -name '*.ql');
do
    codeql database analyze codeql_database $ql --format=csv --output=codeql-analysis/go-results.csv
done

for qls in $(find $HOME/codeql-home/codeql-go/ql -type f -name '*.qls');
do
    codeql database analyze codeql_database $qls --format=csv --output=codeql-analysis/go-results.csv
done
