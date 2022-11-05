#!/usr/bin/env bash

PACKAGE_NAME="Dict"
STEAMDECK_IP="192.168.1.11"

pnpm build

rm -rf build
mkdir -p build/"$PACKAGE_NAME"/dist
cd build || exit

cp ../dist/index.js "$PACKAGE_NAME"/dist/index.js
cp ../*.py "$PACKAGE_NAME"
cp ../package.json "$PACKAGE_NAME"
cp ../plugin.json "$PACKAGE_NAME"
cp ../LICENSE "$PACKAGE_NAME"
cp ../README.md "$PACKAGE_NAME"

ZIP_NAME="$PACKAGE_NAME-$1.zip"

zip $ZIP_NAME "$PACKAGE_NAME"/dist/index.js
zip $ZIP_NAME "$PACKAGE_NAME/"*.py
zip $ZIP_NAME "$PACKAGE_NAME/"*.json
zip $ZIP_NAME "$PACKAGE_NAME"/LICENSE
zip $ZIP_NAME "$PACKAGE_NAME"/README.md

# gh release create $1 $ZIP_NAME
# https://github.com/zdcthomas/decky_dict/archive/refs/tags/0.0.1.zip
# https://github.com/zdcthomas/decky_dict/releases/download/v0.0.1/Dict-v0.0.1.zip

scp -r $PACKAGE_NAME deck@"$STEAMDECK_IP":homebrew
ssh -t deck@"$STEAMDECK_IP" "sudo rm -rf ~/homebrew/plugins/$PACKAGE_NAME; sudo mv ~/homebrew/$PACKAGE_NAME ~/homebrew/plugins/"
