#!/bin/sh

# Ensure script fails on errors
set -e

# Step 1: Initialize the Git repository
git init

echo "Respository initialized"

# Step 2: Create the master branch
git checkout -b master

echo "Checked out master branch"

# Step 5: Add the existing submodule at external/godot-console
# Assuming the godot-console repo is already cloned, just use the relative path
git submodule add https://github.com/winkensjw/godot-console.git external/godot-console
git submodule update --init --recursive

# Step 6: Create a symlink from addons/console to external/godot-console/addons/console
ln -s ../external/godot-console/addons/console addons/console

echo "Submodule added and symlinks created"

# Step 3: Add all files to the repository
git add .

# Step 4: Commit all files with the message "Initial commit"
git commit -m "Initial commit"

echo "Added initial commit"

echo "Setup finished!"

