#!/bin/bash
#
# run as sudo
#

cd cpu
docker build -t docker.registry.foundry:80/sim-cpu-rand .
cd ..

cd memory
docker build -t docker.registry.foundry:80/sim-memory .
cd ..
