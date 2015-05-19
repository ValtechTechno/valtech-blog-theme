#!/bin/sh
VERSION=0.8

echo "Package"
rm -f *.zip
cd ../theme
zip -r ../target/valtech-one-$VERSION.zip *
cd ../
