#!/bin/bash

# Exit on any error
set -e

# Default version - can be overridden with VERSION env variable
VERSION=${VERSION:-"latest"}

echo "Building sentry-native with Breakpad backend..."

# Remove existing directory if it exists
if [ -d "sentry-native" ]; then
    echo "Removing existing sentry-native directory..."
    rm -rf sentry-native
fi

# Clone sentry-native
echo "Cloning fresh copy of sentry-native..."
git clone https://github.com/getsentry/sentry-native.git
cd sentry-native

# Checkout specific version if requested
if [ "$VERSION" != "latest" ]; then
    echo "Checking out version: $VERSION"
    git checkout $VERSION
fi

git submodule update --init --recursive

# Build with CMake - using Breakpad as the backend
# IMPORTANT: https://github.com/getsentry/sentry-native/issues/1033
# need to use breakpad backend for macOS App Sandbox
# breakpad runs in same process while crashpas runs in a separate process (uses IPC to communicate, which app sandbox blocks)
cmake -B build \
    -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DSENTRY_BACKEND=breakpad

# Build the project
echo "Building sentry-native..."
cmake --build build --config RelWithDebInfo --parallel

# Install to local directory first
echo "Installing to local directory..."
cmake --install build --prefix install --config RelWithDebInfo

# Show installation contents
echo "Installation contents:"
ls -R install/

# Install to system location (requires sudo)
echo "Installing to system location..."
sudo mkdir -p /usr/local/sentry
sudo cp -R install/* /usr/local/sentry/

echo "Installation complete in /usr/local/sentry"
echo "sentry-native with Breakpad backend has been built and installed successfully"