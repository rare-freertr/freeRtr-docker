#!/bin/sh
git pull
wget src.freertr.org/rtr.zip
mkdir a
unzip -d a/ rtr.zip
mv a/misc/docker/* ./
rm rtr.zip
rm -Rf a
git add .
git commit -m "updating from the origin"
git push
