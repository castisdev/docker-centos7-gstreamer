#!/bin/bash -e
set -x #echo on
cd ~
pip3 install meson
yum -y install flex bison libmount-devel; yum -y clean all
wget -nv --no-check-certificate --content-disposition https://github.com/GStreamer/gst-build/archive/refs/tags/1.16.1.tar.gz
tar xf gst-build-1.16.1.tar.gz
cd gst-build-1.16.1
export CFLAGS=$(pkg-config --cflags openssl11)
export LDFLAGS=$(pkg-config --libs openssl11)
meson -Dlibsoup:c_std=gnu99 build --prefix=/usr/local/gstreamer-1.16.1
meson install -C build
echo "/usr/local/gstreamer-1.16.1/lib64" >> /etc/ld.so.conf.d/gstreamer-1.16.1.conf
ldconfig
cd ~
rm -rf gst-build-1.16.1*
ccache -C
