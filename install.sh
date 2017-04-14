#!/bin/bash

sudo yum install gcc-c++ pcre-devel zlib-devel make unzip -y

cd ~
sudo rpm --import https://linux.web.cern.ch/linux/scientific6/docs/repository/cern/slc6X/i386/RPM-GPG-KEY-cern
sudo wget -O /etc/yum.repos.d/slc6-devtoolset.repo https://linux.web.cern.ch/linux/scientific6/docs/repository/cern/devtoolset/slc6-devtoolset.repo
sudo yum install devtoolset-2-gcc-c++ devtoolset-2-binutils -y

PS_NGX_EXTRA_FLAGS="--with-cc=/opt/rh/devtoolset-2/root/usr/bin/gcc"

cd ~
NPS_VERSION=$1
sudo rm -rf v${NPS_VERSION}-beta.zip
sudo wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}-beta.zip
sudo unzip v${NPS_VERSION}-beta.zip
cd ngx_pagespeed-${NPS_VERSION}-beta/
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
sudo rm -rf $(basename ${psol_url})
sudo wget ${psol_url}
sudo tar -xzvf $(basename ${psol_url})

sudo yum install openssl-devel libxslt-devel libxml2-devel gd-devel perl-ExtUtils-Embed geoip-devel google-perftools-devel -y

cd ~
NGINX_VERSION=$2
sudo rm -rf nginx-${NGINX_VERSION}.tar.gz
sudo wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
sudo tar -xvzf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/
sudo ./configure --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/lib/nginx/tmp/client_body --http-proxy-temp-path=/var/lib/nginx/tmp/proxy --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --pid-path=/var/run/nginx.pid --lock-path=/var/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-ipv6 --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_auth_request_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module --with-http_perl_module --with-mail --with-mail_ssl_module --with-pcre --with-google_perftools_module --with-debug --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic' --with-ld-opt=' -Wl,-E' --add-module=$3/ngx_pagespeed-${NPS_VERSION}-beta ${PS_NGX_EXTRA_FLAGS}
sudo make
sudo make install

sudo rm -rf /etc/init.d/nginx
sudo wget https://raw.githubusercontent.com/aligokayduman/ngx_pagespeed_bashscript/master/nginx -P /etc/init.d/
sudo chmod 755 /etc/init.d/nginx

sudo service nginx start
sudo chkconfig nginx on
