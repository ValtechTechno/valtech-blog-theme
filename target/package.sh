#!/bin/sh
VERSION=0.7

echo "Package"
rm -f *.zip
cd ../theme
zip -r ../target/valtech-one-$VERSION.zip *
cd ../
