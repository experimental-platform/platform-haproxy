#!/usr/bin/env bash

dockerhost=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
echo "$dockerhost    dockerhost" >> /etc/hosts
echo "======================================================="
echo "Added host 'dockerhost' at $dockerhost to /etc/hosts"
echo "======================================================="

haproxy -f /etc/haproxy/haproxy.cfg -d