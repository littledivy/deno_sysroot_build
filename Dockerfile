FROM ubuntu
# Various tools we need to build and test the sysroot
RUN apt update && apt install -y debootstrap xz-utils symlinks curl build-essential
COPY scripts/ /scripts/

# Run the appropriate debootstrap steps
RUN /scripts/_debootstrap.sh
# Fix relative symlinks
RUN /scripts/_fix_symlinks.sh

# Ensure that libdl is in the right spot
# RUN cp /sysroot/usr/lib/`uname -m`-linux-gnu/libdl.a /sysroot/lib/`uname -m`-linux-gnu/libdl.a
# RUN cp /sysroot/lib/`uname -m`-linux-gnu/libdl.so.2 /sysroot/lib/`uname -m`-linux-gnu/libdl.so

# Provide a /sysroot/.env that sets up the appropriate Rust and C flags
RUN echo "# Compiler flags" > /sysroot/.env
RUN echo export RUSTFLAGS=\"-C link-arg=-L/sysroot/lib/`uname -m`-linux-gnu -C link-arg=-L/sysroot/usr/lib/`uname -m`-linux-gnu -C link-arg=--sysroot=/sysroot $RUSTFLAGS\" >> /sysroot/.env
RUN echo export CFLAGS=\"-L/sysroot/lib/x86_64-linux-gnu -L/sysroot/usr/lib/`uname -m`-linux-gnu --sysroot=/sysroot $CFLAGS\" >> /sysroot/.env

# Test the sysroot by building a Rust program that uses various bits of libc/libm/libdl and trying
# to run it in a chroot /sysroot.
RUN curl https://sh.rustup.rs -sSf > /tmp/rustup-init.sh && sh /tmp/rustup-init.sh -y
COPY smoketest/ /tmp/smoketest/
WORKDIR /tmp/smoketest
RUN . /sysroot/.env && PATH=/root/.cargo/bin:$PATH cargo -vv build
RUN cp /tmp/smoketest/target/debug/smoketest /sysroot
RUN chroot "/sysroot" /smoketest
RUN rm /sysroot/smoketest
WORKDIR /

# Build and compress the sysroot
RUN tar -cv sysroot/ > /tmp/sysroot.tar
# RUN xz -0 -z /tmp/sysroot.tar
RUN xz -9 -e -z /tmp/sysroot.tar
RUN mv /tmp/sysroot.tar.xz /tmp/sysroot-`uname -m`.tar.xz
RUN ls -l /tmp/sysroot-`uname -m`.tar.xz
