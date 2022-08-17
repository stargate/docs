#!/bin/bash

# The product you wish to build is the first argument on the command line

read -p 'Do you need to rebuild the APIs? (Y or N)' api
product=$1

if [ $api == "Y" ] || [ $api == "y" ];
  then
    product="dev-stargate";
  else
    product="stargate";
fi
echo "product: $product"

# Function to check software versions for prereq updates

version_greater_equal()
{
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

echo "Checking prerequisites are up-to-date"

# Look for profile information in these three files

. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc
. ~/.zshrc

# check if nvm is running and up-to-date
# If the version is not up-to-date, do the install/update
nvmversion=$(nvm --version)
${nvmversion} || echo "Installing nvm - please be patient, this takes time"; brew update; brew install nvm;
echo "nvm version: ${nvmversion}"
version_greater_equal "${nvmversion}" 0.39.1 || echo "Updating - please wait"; brew upgrade nvm;

# check if node is running and the version

nodeversion=$(node -v)
${nodeversion} ||  echo "Installing node - please be patient, this takes time"; brew update; brew install node; nvm install 16; nvm use 16;
echo "node version: ${nodeversion}"
version_greater_equal "${nodeversion}" 'v16.13.1' || echo "Updating node"; nvm install 16; nvm use 16;

# check if npm is running and the version

npmversion=$(npm -v)
${npmversion} || echo "Installing npm"; npm install;
echo "npm version: ${npmversion}"
version_greater_equal "${npmversion}" 8.5.5 || echo "Updating npm"; npm install;

# check the antora version

antoraversion=$(npm info antora version)
${antoraversion} || echo "Installin antora"; npm install antora; npm update antora;
echo "antora version: ${antoraversion}"
version_greater_equal "${antoraversion}" 3.0.1 || echo "Updating antora"; npm update antora;

# Next, do the actions required for individual docset builds
# - remove the antora symlinks that exist
# - set the antora symlinks to the correct product docset
# - finally, run the corresponding product docset playbook

case $product in

  stargate)
    echo "You are building the stargate docset."
    echo "Remove and make antora.yml symlinks."
    FILE=antora.yml
    cd docs-src/stargate-core
    if test -f "$FILE"; then
      rm antora.yml;
      echo "antora.yml removed"
    fi
    ln -s antora-stargate.yml antora.yml
    cd ../stargate-develop
    if test -f "$FILE"; then
      rm antora.yml;
      echo "antora.yml removed"
    fi 
    ln -s antora-stargate.yml antora.yml
    cd ../..
    echo "Run the stargate build."
    npm run build:local:stargate
    ;;

  dev-stargate)
    echo "You are building the dev-sg docset with APIs."
    echo "Remove and make antora.yml symlinks."
    FILE=antora.yml
    cd docs-src/stargate-core
    if [  -f "$FILE" ]; then
      rm antora.yml;
      echo "antora.yml removed"
    fi
    ln -s antora-stargate.yml antora.yml
    cd ../stargate-develop
    if test -f "$FILE"; then
      rm antora.yml;
      echo "antora.yml removed"
    fi
    ln -s antora-stargate.yml antora.yml
    cd ../..
    echo "Run the dev-sg build"
    npm run build:dev:stargate
    ;;
esac
