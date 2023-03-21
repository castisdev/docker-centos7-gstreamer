#!/bin/bash -e
set -x #echo on
yum -y install flex bison libmount-devel libjpeg-turbo-devel autoconf automake libtool yasm; yum -y clean all

cd ~
wget -nv --no-check-certificate https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.bz2
tar xf nasm-2.15.05.tar.bz2
cd nasm-2.15.05
./autogen.sh
./configure
make install -j$(nproc)
cd ~
rm -rf nasm-2.15.05*

ccache -C
