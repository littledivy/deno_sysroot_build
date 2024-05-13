#!/bin/bash
set -euxo pipefail

find /sysroot -lname '/*' | while read l; do
    target="$(readlink "$l")"
    ls -ld $l
    ln -svnrif "/sysroot/$target" "$l"
    ls -ld $l
done
