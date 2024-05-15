# deno_sysroot_build

Deno for Linux sysroot build.

This allows `deno` executables to link against older versions of glibc. The sysroot
itself is only there to provide appropriately-versioned `.a` files to a linker running
on the main system.

We don't actually build `deno` in a sysroot or chroot with this project. Instead, it
allows us to pass `-L` and `--sysroot` flags to the linker which redirect the link
phase from the system libraries (which would tie us to a much later version of GLIBC)
to the sysroot libraries (which are taken from a much older version of Ubuntu).

## Rebuilding

1. Run `build.sh` on a system with Docker. If building on Apple Silicon, you may
   need to disable Rosetta from the Docker settings.
2. Upload the `sysroot-*.tar.xz` files as releases.
3. Update `deno` build scripts to point at new `sysroot` release
