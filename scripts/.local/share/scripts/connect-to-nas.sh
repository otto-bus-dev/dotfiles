#!/bin/bash

sleep 10

mkdir ~/mount
mkdir ~/mount/nas
mkdir ~/mount/nas/retropie
mkdir ~/mount/nas/video
mkdir ~/mount/nas/photo
mkdir ~/mount/nas/SSII

sudo mount -t nfs nas:/volume1/retropie ~/mount/nas/retropie
sudo mount -t nfs nas:/volume1/video ~/mount/nas/video
sudo mount -t nfs nas:/volume1/photo ~/mount/nas/photo
sudo mount -t nfs nas:/volume1/SSII ~/mount/nas/SSII

