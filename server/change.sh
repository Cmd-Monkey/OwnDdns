#!/bin/bash
mv -f site.conf /etc/nginx/conf.d/
systemctl restart nginx
echo 'Task Complete'
