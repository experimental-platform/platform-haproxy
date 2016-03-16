#!/usr/bin/env bash

set -e

# If the certificate does not exist or expires within 86400*30 == 1 month from now,
# generate a fresh one, otherwise keep the existing
if [ openssl x509 -checkend 2592000 -noout -in /data/ssl/cert ]
then
  echo "======================================================="
  echo "Self-signed local SSL certificate is valid"
  echo "======================================================="
else
  echo "======================================================="
  echo "Generating new self-signed SSL certificate"
  echo "======================================================="
  openssl req -nodes -newkey rsa:2048 -keyout /data/ssl/key -out /data/ssl/csr -subj "/C=US/ST=NJ/L=Monroe/O=MyCompany/OU=IT/CN=protonet.local"
  openssl x509 -req -days 365 -in /data/ssl/csr -signkey /data/ssl/key -out /data/ssl/cert
fi

# Create the pem file for self-signed local https connections
# See https://serversforhackers.com/using-ssl-certificates-with-haproxy
cat /data/ssl/cert /data/ssl/key > /data/ssl/pem

dockerhost=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
echo "$dockerhost    dockerhost" >> /etc/hosts
echo "======================================================="
echo "Added host 'dockerhost' at $dockerhost to /etc/hosts"
echo "======================================================="

haproxy -f /etc/haproxy/haproxy.cfg -d