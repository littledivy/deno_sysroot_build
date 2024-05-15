#!/bin/bash
set -euxo pipefail

# Make all the symlinks in the sysroot relative
find /sysroot -lname '/*' | while read l; do
    target="$(readlink "$l")"
    ls -ld $l
    ln -svnrif "/sysroot/$target" "$l"
    ls -ld $l
done
