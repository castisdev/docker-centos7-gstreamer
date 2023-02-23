# Pull base image
FROM centos:7

LABEL org.opencontainers.image.source https://github.com/castisdev/docker-centos7-gstreamer

# set timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Install EPEL repo
RUN yum install -y epel-release; yum -y clean all

RUN yum install -y http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm; yum -y clean all

# Install
RUN yum install -y \
  sudo \
  wget \
  gcc \
  gcc-c++ \
  make \
  unzip \
  openssl \
  openssl-devel \
  openssl-static \
  openssl11 \
  openssl11-devel \
  openssl11-static \
  git \
  tar \
  boost-devel \
  glibc-devel \
  libuuid-devel \
  gdb \
  valgrind \
  curl-devel \
  xz \
  file \
  vim-enhanced \
  sysstat \
  psmisc \
  sysvinit-tools \
  yum-utils \
  tbb-devel \
  gperftools-devel \
  iproute \
  net-tools \
  ccache \
  libunwind-devel \
  libasan \
  libasan-static \
  patch \
  && yum -y clean all

ADD install_devtoolset11.sh /script/
RUN /script/install_devtoolset11.sh
SHELL [ "scl", "enable", "devtoolset-11" ]

ADD install_cmake3251.sh /script/
RUN /script/install_cmake3251.sh

ADD install_libbacktrace.sh /script/
RUN /script/install_libbacktrace.sh

ADD install_boost181.sh /script/
RUN /script/install_boost181.sh
ENV Boost_DIR /usr/local/boost_1_81_0

ADD install_googletest1121.sh /script/
RUN /script/install_googletest1121.sh

ADD install_python3110.sh /script/
RUN /script/install_python3110.sh

ADD install_cpptools.sh /script/
RUN /script/install_cpptools.sh

ADD install_cppcheck29.sh /script/
RUN /script/install_cppcheck29.sh

ADD install_zsh59.sh /script/
RUN /script/install_zsh59.sh

ADD install_ninja1111.sh /script/
RUN /script/install_ninja1111.sh

ADD install_golang1193.sh /script/
RUN /script/install_golang1193.sh

# Set environment variables
ENV HOME /root
ENV PATH="${PATH}:${HOME}/go/bin:/usr/local/go/bin"

ADD install_gstreamer1161.sh /script/
RUN /script/install_gstreamer1161.sh

ADD install_gstreamer1203.sh /script/
RUN /script/install_gstreamer1203.sh

ADD install_gstreamer1220.sh /script/
RUN /script/install_gstreamer1220.sh

# ctail
RUN wget -O - https://raw.githubusercontent.com/castisdev/ctail/master/install.sh --no-check-certificate | bash

# Add root files
ADD ./.bashrc /root/.bashrc

# Define default command
CMD ["scl", "enable", "devtoolset-11", "zsh"]
