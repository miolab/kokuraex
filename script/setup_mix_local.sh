#!/bin/zsh

set -e

cd app

echo "Fetching Mix dependencies..."
mix deps.get

echo "Compiling Mix dependencies..."
mix deps.compile

echo "Installing git_hooks..."
mix git_hooks.install

echo "Running Mix tests..."
mix test

echo "Running Mix dialyzer..."
mix dialyzer

cd ..

echo "Setup Mix completed successfully!"
