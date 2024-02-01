#!/bin/bash

echo "Initing docker swarm......."

sudo docker swarm init --advertise-addr=10.10.10.100
sudo docker swarm join-token worker | grep docker > /vagrant/scripts/swarm-worker.sh

echo "Creating Docker volume......."

sudo docker volume create app
cp /vagrant/web-app/index.html /var/lib/docker/volumes/app/_data
