#!/bin/sh
echo "Cloud Academy Labs Are Great!" > index.html
nohup busybox httpd -f -p 8080 &