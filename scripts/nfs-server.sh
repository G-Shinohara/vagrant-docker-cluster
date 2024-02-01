#!/bin/bash

echo "Installing NFS-Server......."

apt-get install nfs-server -y
cp /vagrant/exports /etc/exports
