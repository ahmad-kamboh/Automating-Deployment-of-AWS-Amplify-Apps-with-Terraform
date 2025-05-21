#!/bin/bash

set -e

# Install Homebrew if not installed
if ! command -v brew &> /dev/null
then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing tfenv..."
brew install tfenv

echo "Installing Terraform..."
tfenv install latest
tfenv use latest

echo "Installing Checkov..."
brew install checkov

echo "Setup finished successfully!"
