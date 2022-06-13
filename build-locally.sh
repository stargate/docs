#!/bin/bash

# get the product docset that is going to be run
# First - do you need to rebuild the APIs (REST, Document, DevOps) as part of your build?

read -p 'Do you need to rebuild the APIs? (Y or N)' api

if [ $api = "Y" ] || [ $api = "y" ];
  then
    case $1 in
      ('dev-sg' | 'dev-sg+adoc' ) echo "product: $1";;
      (*) echo "pick dev-sg or dev-sg+adoc" && exit;;
    esac
  else
    case $1 in
      ('sg' | 'sg+adoc' ) echo "product: $1";;
      (*) echo "pick sg or sg+adoc" && exit;;
    esac
fi

# Function to check software versions for prereq updates

version_greater_equal()
{
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

# check if nvm is running and up-to-date

echo "Checking prerequisites are up-to-date"

# Look for profile information in these three files

. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc

nvmversion=$(nvm --version)
echo "nvm version: ${nvmversion}"

# If the version is not up-to-date, do the install/update
version_greater_equal "${nvmversion}" 0.39.1 || echo "Updating/installing nvm - please be patient, this takes time"; brew update; brew install nvm;

# check if node is running and the version

nodeversion=$(node -v)
echo "node version: ${nodeversion}"
version_greater_equal "${nodeversion}" 'v16.13.1' || echo "Updating/installing node"; nvm install 16; nvm use 16;

# check if npm is running and the version

npmversion=$(npm -v)
echo "npm version: ${npmversion}"
version_greater_equal "${npmversion}" 8.5.5 || echo "Updating/installing npm"; npm install;

# check the antora version

antoraversion=$(npm info antora version)
echo "antora version: ${antoraversion}"
version_greater_equal "${antoraversion}" 3.0.1 || echo "Updating antora"; npm update antora;

# Next, do the actions required for individual docset builds
# - remove the antora symlinks that exist
# - set the antora symlinks to the correct product docset
# - finally, run the corresponding product docset playbook

case $1 in

  sg)
    echo "You are building the sg docset."
    echo "Remove and remake the antora.yml symlinks."
    cd docs-src/stargate-core
    rm antora.yml; ln -s antora-stargate.yml antora.yml
    cd ../stargate-develop
    rm antora.yml; ln -s antora-stargate.yml antora.yml
    cd ../..

    echo "Run the stargate build."
    npm run build:local:stargate
    ;;

  dev-sg)
    echo "You are building the dev-sg docset."
    echo "Remove and remake the antora.yml symlinks."
    cd docs-src/stargate-core
    rm antora.yml; ln -s antora-stargate.yml antora.yml
    cd ../stargate-develop
    rm antora.yml; ln -s antora-stargate.yml antora.yml
    cd ../..

    echo "Run the dev-sg build."
    npm run build:local-devsg
    ;;

  sg+adoc)
    echo "You are building the sg+adoc docset."
    echo "Remove and make antora.yml symlinks."
    cd ./../../adoc-howto
    rm antora.yml; ln -s antora-sg+adoc.yml antora.yml
    cd ../stargate/docs/docs-src/stargate-core
    rm antora.yml; ln -s antora-sg+adoc.yml antora.yml
    cd ../stargate-develop
    rm antora.yml; ln -s antora-sg+adoc.yml antora.yml
    cd ../..
    echo "Run the sg+adoc build."
    npm run build:localsg+adoc
    ;;

  dev-sg+adoc)
    echo "You are building the dev-sg+adoc docset."
    echo "Remove and make antora.yml symlinks."
    cd ./../../adoc-howto
    rm antora.yml; ln -s antora-sg+adoc.yml antora.yml
    cd ../stargate/docs/docs-src/stargate-core
    rm antora.yml; ln -s antora-sg+adoc.yml antora.yml
    cd ../stargate-develop
    rm antora.yml; ln -s antora-sg+adoc.yml antora.yml
    cd ../..
    echo "Run the dev-sg+adoc build."
    npm run build:local-devsg+adoc
    ;;
esac

