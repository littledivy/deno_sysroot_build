#!/bin/bash
set -euxo pipefail

# This script runs on the host machine

# Build the sysroot on all supported linux platforms
docker build . --platform linux/amd64 -t sysroot_amd64
docker build . --platform linux/arm64 -t sysroot_arm64

# Copy the resulting sysroot .xz to the current directory
docker run --rm -it -v `pwd`:/output/ --platform linux/amd64 -t sysroot_amd64 sh -c "cp /tmp/sysroot-* /output/"
docker run --rm -it -v `pwd`:/output/ --platform linux/arm64 -t sysroot_arm64 sh -c "cp /tmp/sysroot-* /output/"
