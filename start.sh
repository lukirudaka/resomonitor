#!/usr/bin/bash
sudo webfsd -p 8225 -R  ./ -c 5000 -e 2592000 -l webfs.log
read -r -p"Press any key to stop the web server." variable;echo

sudo pkill webfsd
