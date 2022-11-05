#!/usr/bin/env bash

pnpm build

rm -rf build
mkdir -p build/"$1"/dist
cd build || exit

cp ../dist/index.js "$1"/dist/index.js
cp ../*.py "$1"
cp ../package.json "$1"
cp ../plugin.json "$1"
cp ../LICENSE "$1"
cp ../README.md "$1"

ZIP_NAME="$1-$2.zip"

zip $ZIP_NAME "$1"/dist/index.js
zip $ZIP_NAME "$1/"*.py
zip $ZIP_NAME "$1/"*.json
zip $ZIP_NAME "$1"/LICENSE
zip $ZIP_NAME "$1"/README.md

gh release create $2 $ZIP_NAME
# https://github.com/zdcthomas/decky_dict/archive/refs/tags/0.0.1.zip
