#!/bin/sh

app_folder="chatterino.app"

if [ -d bin/chatterino.app ]; then
    app_folder="bin/chatterino.app"
fi

>&2 echo "Using '$app_folder' as the app folder"

echo "Running MACDEPLOYQT"
/usr/local/opt/qt/bin/macdeployqt "$app_folder"
echo "Creating python3 virtual environment"
python3 -m venv venv
echo "Entering python3 virtual environment"
. venv/bin/activate
echo "Installing dmgbuild"
python3 -m pip install dmgbuild
echo "Running dmgbuild.."
dmgbuild --settings ./../.CI/dmg-settings.py -D app=./chatterino.app Chatterino2 chatterino-osx.dmg
echo "Done!"
