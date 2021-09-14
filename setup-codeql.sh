#!/bin/bash
set -e

sudo apt install unzip -y

rm -rf $HOME/codeql-home
mkdir -p $HOME/codeql-home
cd $HOME/codeql-home

wget -nc https://github.com/github/codeql-cli-binaries/releases/latest/download/codeql.zip
unzip codeql.zip
export PATH=$HOME/codeql-home/codeql:$PATH
codeql --help
codeql --version

git clone https://github.com/github/codeql codeql-repo
git clone https://github.com/github/codeql-go
