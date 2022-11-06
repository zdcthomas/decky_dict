#!/usr/bin/env bash

FILE=STEAM_DECK_IP
if [ ! -f "$FILE" ]; then
    echo "STEAM_DECK_IP file in root of repository does not exist."
    echo "Please create this file with the Steam Deck IP address."
    exit 1
fi

PACKAGE_NAME="Dict"
STEAMDECK_IP=$(< STEAM_DECK_IP)


echo "-------------------------"
echo "|    Building Plugin    |"
echo "-------------------------"


pnpm build


echo "--------------------------"
echo "|    Packaging Plugin    |"
echo "--------------------------"


rm -rf build
mkdir -p build/"$PACKAGE_NAME"/dist
cd build || exit

cp ../dist/index.js "$PACKAGE_NAME"/dist/index.js
cp ../package.json "$PACKAGE_NAME"
cp ../plugin.json "$PACKAGE_NAME"
cp -r ../bin/ "$PACKAGE_NAME"/bin
cp ../LICENSE "$PACKAGE_NAME"
cp ../README.md "$PACKAGE_NAME"


echo "--------------------------"
echo "|    Zipping up build    |"
echo "--------------------------"

ZIP_NAME="$PACKAGE_NAME-$1.zip"

zip $ZIP_NAME "$PACKAGE_NAME"/dist/index.js
zip $ZIP_NAME "$PACKAGE_NAME"/bin/backend
zip $ZIP_NAME "$PACKAGE_NAME/"*.json
zip $ZIP_NAME "$PACKAGE_NAME"/LICENSE
zip $ZIP_NAME "$PACKAGE_NAME"/README.md

echo "---------------------------------------"
echo "|    Deploying to local steam deck    |"
echo "---------------------------------------"


# gh release create $1 $ZIP_NAME
# https://github.com/zdcthomas/decky_dict/archive/refs/tags/0.0.1.zip
# https://github.com/zdcthomas/decky_dict/releases/download/v0.0.1/Dict-v0.0.1.zip

scp -r $PACKAGE_NAME deck@"$STEAMDECK_IP":homebrew
ssh -t deck@"$STEAMDECK_IP" "sudo rm -rf ~/homebrew/plugins/$PACKAGE_NAME; sudo mv ~/homebrew/$PACKAGE_NAME ~/homebrew/plugins/"

echo "-------------------------------------------------"
echo "|    Reload Deck Dict to use updated plugin!    |"
echo "-------------------------------------------------"

