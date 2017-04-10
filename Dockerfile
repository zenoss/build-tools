FROM zenoss/zenoss-centos-base:1.2.9.devtools
MAINTAINER Zenoss <ian@zenoss.com>

# add chrome for headless browser testing
RUN printf '[google-chrome]\n\
name=google-chrome - \$basearch\n\
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub\n'\
>> /etc/yum.repos.d/google-chrome.repo

# nodejs / npm
RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -
RUN yum install -y nodejs

RUN yum install epel-release -y \
    && yum -y install \
    xorg-x11-server-Xvfb \
    supervisor \
    google-chrome-stable \
    && yum erase epel-release -y \
    && /sbin/scrub.sh

RUN sed -i 's/requiretty/!requiretty/' /etc/sudoers

RUN npm install -g gulp

# allow container to perform actions as
# a specific user
ADD userdo.sh /root/userdo.sh

# workaround "D-Bus library appears to be incorrectly set up" error
# when running xvfb/chrome
RUN dbus-uuidgen > /var/lib/dbus/machine-id
