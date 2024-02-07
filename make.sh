#!/bin/bash
if [[ `uname -m` == "aarch64" ]]; then
  debootstrap                                          \
    --include=ca-certificates,curl,file,libc6-dev,make \
    --no-merged-usr --variant=minbase xenial /sysroot  \
    http://ports.ubuntu.com/
else                                                   
  debootstrap                                          \
    --include=ca-certificates,curl,file,libc6-dev,make \
    --no-merged-usr --variant=minbase xenial /sysroot  \
    http://azure.archive.ubuntu.com/ubuntu
fi
