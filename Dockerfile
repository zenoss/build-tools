FROM zenoss/zenoss-centos-base:1.1.4
MAINTAINER Zenoss <ian@zenoss.com>

# add chrome for headless browser testing
RUN printf '[google-chrome]\n\
name=google-chrome - \$basearch\n\
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub\n'\
>> /etc/yum.repos.d/google-chrome.repo

RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -

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
    xorg-x11-server-Xvfb \
    nodejs \
    google-chrome-stable \
    && yum erase epel-release -y \
    && /sbin/scrub.sh

RUN sed -i 's/requiretty/!requiretty/' /etc/sudoers

RUN wget -qO- https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -C / -xz
ENV GOROOT /go
ENV GOPATH /gosrc
ENV PATH $PATH:/go/bin

RUN npm install -g gulp

# allow container to perform actions as
# a specific user
ADD userdo.sh /root/userdo.sh

# workaround "D-Bus library appears to be incorrectly set up" error
# when running xvfb/chrome
RUN dbus-uuidgen > /var/lib/dbus/machine-id
