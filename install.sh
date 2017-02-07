#!/bin/bash

yum install gcc-c++ pcre-devel zlib-devel make unzip -y

cd ~
rpm --import https://linux.web.cern.ch/linux/scientific6/docs/repository/cern/slc6X/i386/RPM-GPG-KEY-cern
wget -O /etc/yum.repos.d/slc6-devtoolset.repo https://linux.web.cern.ch/linux/scientific6/docs/repository/cern/devtoolset/slc6-devtoolset.r$
yum install devtoolset-2-gcc-c++ devtoolset-2-binutils -y

PS_NGX_EXTRA_FLAGS="--with-cc=/opt/rh/devtoolset-2/root/usr/bin/gcc"

cd ~
NPS_VERSION=$1
wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}-beta.zip
unzip v${NPS_VERSION}-beta.zip
cd ngx_pagespeed-${NPS_VERSION}-beta/
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})

yum install openssl-devel libxslt-devel libxml2-devel gd-devel perl-ExtUtils-Embed geoip-devel google-perftools-devel -y

cd ~
NGINX_VERSION=$2
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xvzf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/
./configure --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.l$
make
make install

wget https://raw.githubusercontent.com/aligokayduman/ngx_pagespeed_bashscript/master/nginx -P /etc/init.d/
chmod 755 /etc/init.d/nginx

service nginx start
chkconfig nginx on
