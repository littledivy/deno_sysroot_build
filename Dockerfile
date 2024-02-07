FROM ubuntu
RUN apt update
RUN apt install -y debootstrap xz-utils
COPY make.sh /
RUN /make.sh
RUN tar -cv sysroot/ > /tmp/sysroot.tar
RUN xz -9 -e -z /tmp/sysroot.tar
RUN mv /tmp/sysroot.tar.xz /tmp/sysroot-`uname -m`.tar.xz
RUN ls -l /tmp/sysroot-`uname -m`.tar.xz
