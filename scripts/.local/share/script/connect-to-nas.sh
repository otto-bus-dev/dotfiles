#!/bin/bash

sleep 10

sudo mount -t nfs 192.168.86.24:/volume1/retropie ~/nas/retrogaming
sudo mount -t nfs 192.168.86.24:/volume1/video ~/nas/video
sudo mount -t nfs 192.168.86.24:/volume1/photo ~/nas/photo
sudo mount -t nfs 192.168.86.24:/volume1/SSII ~/nas/ssii
sudo mount -t nfs 192.168.86.24:/volume1/homes ~/nas/homes
