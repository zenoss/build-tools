FROM zenoss-centos-base:1.1.4_dev
MAINTAINER Zenoss <ian@zenoss.com>

RUN yum install epel-release -y \
    && yum -y install \
    mock \
    sudo \
    'Development Tools' \
    rpmdevtools \
    gcc-c++ \
    subversion \
    cyrus-sasl-devel \
    pango-devel \
    readline-devel \
    sqlite-devel \
    bzip2-devel \
    gdbm-devel \
    python-devel \
    autoconf \
    make \
    swig \
    which \
    bc \
    java-1.7.0-openjdk-devel \
    unzip \
    patch \
    gcc \
    wget \
    net-snmp \
    net-snmp-utils \
    binutils \
    libgcj \
    libgomp \
    libaio \
    readline \
    dmidecode \
    gnupg \
    rsync \
    sysstat \
    libxslt \
    protobuf-compiler \
    libsmi \
    nmap \
    redis \
    net-snmp-libs \
    libcap supervisor \
    pcre-devel \
    openssl-devel \
    hiredis \
    tar \
    perl-XML-XPath \
    mercurial \
    python-virtualenv \
    bzr \
    git \
    maven \
    && yum erase epel-release -y \
    && /sbin/scrub.sh

RUN sed -i 's/requiretty/!requiretty/' /etc/sudoers

RUN wget -qO- https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -C / -xz
ENV GOROOT /go
ENV GOPATH /gosrc
ENV PATH $PATH:/go/bin

