#!/bin/sh
git pull
wget src.freertr.org/rtr.zip
mkdir a
unzip -d a/ rtr.zip
mv a/misc/docker/* ./
mv a/misc/docker/run/* ./run/
mv a/misc/docker/scripts/* ./scripts/
rm rtr.zip
rm -Rf a
git add .
git commit -m "updating from the origin"
git push
