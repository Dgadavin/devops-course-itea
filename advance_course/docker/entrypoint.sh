#!/bin/bash
mkdir 1

if [ $? == 0 ] then
echo "Starting nginx"
nginx -g 'daemon off;'
fi
