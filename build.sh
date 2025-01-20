#!/bin/bash

# Exit on any error
set -e

# Clone and build sentry-native
git clone https://github.com/getsentry/sentry-native.git
cd sentry-native
git submodule update --init --recursive

# Build with CMake
cmake -B build -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build --config RelWithDebInfo --parallel
cmake --install build --prefix install --config RelWithDebInfo

# Show installation contents
ls -R install/

# Install to system location (requires sudo)
sudo mkdir -p /usr/local/sentry
sudo cp -R install/* /usr/local/sentry/

echo "Installation complete in /usr/local/sentry"