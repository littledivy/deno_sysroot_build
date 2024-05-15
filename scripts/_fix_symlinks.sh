#!/bin/bash
set -euxo pipefail

# Make all the symlinks in the sysroot relative, with the exception of /dev/ and /proc.
find /sysroot -not \( -path "/sysroot/dev/*" -prune \) -not \( -path "/sysroot/proc/*" -prune \) -lname '/*' | while read l; do
    target="$(readlink "$l")"
    ls -ld $l
    ln -svnrif "/sysroot/$target" "$l"
    ls -ld $l
done
