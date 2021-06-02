#!/bin/bash

if  [ "$app" == "app111"  ]
then
    cp -rvf /common/app1/*  /var/www/html/
    httpd -DFOREGROUND 
elif  [  "$app" == "app222"  ]
then
    cp -rvf /common/app2/*  /var/www/html/
    httpd -DFOREGROUND 

else 
    echo  "Plz contact your DOcker engineer to fix "  >/var/www/html/index.html
    httpd -DFOREGROUND

fi 