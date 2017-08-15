#!/bin/bash

# vpn in centos
# http://blog.sina.com.cn/s/blog_6c739e630102vk7h.html
# https://my.oschina.net/jathon/blog/392802
# http://www.newsmth.net/nForum/#!article/LinuxApp/904732
# http://www.tuicool.com/articles/Una6RjJ
# sudo yum install ppp pptp pptp-setup

sudo pptpsetup --create ytvpn --server p1.hk2.seejump.com --username codychan --password your_pswd -encrypt --start

# if error:
# sudo vim /etc/ppp/chap-secrets

sudo route add -net 0.0.0.0 dev ppp0

# NOTE: check your ip in browser

# connect vpn -- maybe unnecessary:
# pppd call ytvpn

# exit vpn:
# killall pppd
# or ?
# > service network restart
