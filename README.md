# deno_sysroot_build

Deno for Linux sysroot build.

## Rebuilding

1. Run `build.sh` on a system with Docker. If building on Apple Silicon, you may
   need to disable Rosetta from the Docker settings.
2. Upload the `sysroot-*.tar.xz` files as releases.
3. Update `deno` build scripts to point at new `sysroot` release
