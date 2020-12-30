#!/bin/sh
echo "❓ Checking for Homebrew updates";
brew update

function install_current {
  echo "🔼 Trying to update $1"
  brew upgrade $1 || brew install $1 || true
  brew link $1
}

if [ -e "Mintfile" ]; then
  install_current mint
  mint bootstrap
fi

# Install gems if a Gemfile exists
if [ -e "Gemfile" ]; then
  echo "💠 Installing ruby gems";
  gem install bundler --no-document || echo "❌ Failed to install bundle";
  bundle config set deployment 'true';
  bundle config path vendor/bundle;
  bundle install || echo "❌ Failed to install bundle";
fi