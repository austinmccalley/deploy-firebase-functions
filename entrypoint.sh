#!/bin/bash

local_path=${FUNCTIONS_PATH}
package_manager=${PACKAGE_MANAGER}

if [ -z "${FUNCTIONS_PATH}" ]; then
    local_path = "./"
    cd $local_path
  else
    cd $local_path
fi

if [ -z "${FIREBASE_TOKEN}" ]; then
  echo "FIREBASE_TOKEN is missing"
  exit 1
fi

if [ -z "${FIREBASE_PROJECT}" ]; then
    echo "FIREBASE_PROJECT is missing"
    exit 1
fi

if [[ $package_manager = "yarn" ]]; then
    package_manager="yarn"
  else
    package_manager="npm"
fi

echo "Using $package_manager as package manager."
echo "Installing packages using $package_manager."
$package_manager install

firebase deploy \
    -m "${GITHUB_REF} (${GITHUB_SHA})" \
    --project ${FIREBASE_PROJECT} \
    --only functions
