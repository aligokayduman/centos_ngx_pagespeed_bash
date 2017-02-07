# ngx_pagespeed_bashscript

This script prepare for CentOS 6 or higher. It downloads and installs nginx server with google page speed and some other modules automaticly.

Modules;

--add-module=ngx_pagespeed

--with-file-aio 

--with-ipv6 

--with-http_ssl_module 

--with-http_spdy_module 

--with-http_realip_module 

--with-http_addition_module 

--with-http_auth_request_module 

--with-http_xslt_module 

--with-http_image_filter_module 

--with-http_geoip_module 

--with-http_sub_module 

--with-http_dav_module 

--with-http_flv_module 

--with-http_mp4_module 

--with-http_gunzip_module 

--with-http_gzip_static_module 

--with-http_random_index_module 

--with-http_secure_link_module 

--with-http_degradation_module 

--with-http_stub_status_module 

--with-http_perl_module 

--with-mail 

--with-mail_ssl_module 

--with-pcre

If you want to install automatically, you can run this code on commad line

`bash <(curl -f -L -sS https://goo.gl/Wy3qNY) page_speed_version nginx_version $HOME`

google page speed module versions https://modpagespeed.com/doc/release_notes

nginx versions http://nginx.org/en/download.html

example: `bash <(curl -f -L -sS https://goo.gl/Wy3qNY) 1.12.34.2 1.8.1 $HOME`

If you want to install manually, you can read this tutorial 

https://www.aligokayduman.com/427-nginx-pagespeed-modul-kurulumu/ (turkish)