#!/bin/bash

PROJ_NAME="photochat"
APP_NAME="photochatapp"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Script absolute path is $SCRIPT_DIR"
PROJ_ROOT="$(dirname "$SCRIPT_DIR")"
echo "Project root path is $PROJ_ROOT"

if [ -z "${ANDROID_SIGN_PWD}" ]
then
  echo "ANDROID_SIGN_PWD not found, abort"
  exit 1
else
  echo "ANDROID_SIGN_PWD detected, proceeding..."
fi

if [ -z "${SECRET_REPO}" ]
then
  echo "SECRET_REPO not found, using jacksonz-secrets..."
  export SECRET_REPO=jacksonz-secrets
else
  echo "SECRET_REPO detected, proceeding..."
fi

if [ -z "${PROJ}" ]
then
  echo "PROJ not found, using /tmp/$PROJ_NAME as proj directory..."
  export PROJ=/tmp/$PROJ_NAME
else
  echo "PROJ detected, proceeding..."
fi

if [ -d "$PROJ/$SECRET_REPO" ]
then
  echo "$PROJ/$SECRET_REPO exists"
else
  echo "$PROJ/$SECRET_REPO not found"
  if [ -z "${GITHUB_TOKEN}" ]
  then
    echo "GITHUB_TOKEN not found, abort"
    exit 1
  else
    echo "GITHUB_TOKEN exist, cloning $SECRET_REPO into $PROJ/$SECRET_REPO..."
    echo "Removing existing secret repository..."
    rm -rf $PROJ/$SECRET_REPO
    echo "Existing secret repository removed"
    git clone https://${GITHUB_TOKEN}@github.com/tianhaoz95/${SECRET_REPO}.git $PROJ/$SECRET_REPO
  fi
fi

if [ -z "$REFRESH_IOS_CREDENTIAL" ]
then
  echo "REFRESH_IOS_CREDENTIAL not found, proceed..."
else
  echo "REFRESH_IOS_CREDENTIAL detected, refreshing iOS credentials..."
  cd $PROJ_ROOT/photochatapp/ios/fastlane
  bundle exec fastlane spaceauth -u emzak208@gmail.com
  rm -rf $PROJ/$SECRET_REPO/$PROJ_NAME/cookie
  cp ~/.fastlane/spaceship/emzak208\@gmail.com/cookie $PROJ/$SECRET_REPO/$PROJ_NAME/cookie
  cd $PROJ/$SECRET_REPO
  git add -A
  git commit -m "update: iOS session cookie"
  git push
fi

# Create the session cookie for iOS code signing
if [ -f "~/.fastlane/spaceship/emzak208\@gmail.com/cookie" ]
then
  echo "Session cookie file already exist, skipping..."
else
  echo "Copying session cookie from secret repository to local..."
  mkdir -p ~/.fastlane/spaceship/emzak208\@gmail.com
  cp $PROJ/$SECRET_REPO/$PROJ_NAME/cookie ~/.fastlane/spaceship/emzak208\@gmail.com/cookie
fi

# Create the keystore for signing the Android app.
rm -f $PROJ_ROOT/$APP_NAME/android/key.properties
echo "storePassword=$ANDROID_SIGN_PWD" >> $PROJ_ROOT/$APP_NAME/android/key.properties
echo "keyPassword=$ANDROID_SIGN_PWD" >> $PROJ_ROOT/$APP_NAME/android/key.properties
echo "keyAlias=key" >> $PROJ_ROOT/$APP_NAME/android/key.properties
echo "storeFile=key.jks" >> $PROJ_ROOT/$APP_NAME/android/key.properties

# Create the key file for Google Play Store service account.
# This service account is used by fastlane to auto deploy to
# Google Play Store.
rm -f $PROJ_ROOT/$APP_NAME/android/fastlane/Appfile
echo "json_key_file \"$PROJ/$SECRET_REPO/$PROJ_NAME/play_store_service_account_api_key.json\"" >> $PROJ_ROOT/$APP_NAME/android/fastlane/Appfile
echo "package_name \"com.jacksonz.photochatapp\"" >> $PROJ_ROOT/$APP_NAME/android/fastlane/Appfile

# Copy the keystore into the project area as required by Android studio
rm -f $PROJ_ROOT/$APP_NAME/android/app/key.jks
cp $PROJ/$SECRET_REPO/$PROJ_NAME/key.jks $PROJ_ROOT/$APP_NAME/android/app