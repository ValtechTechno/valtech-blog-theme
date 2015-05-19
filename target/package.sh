#!/bin/sh
VERSION=`awk '$1=="Version:"{print $2}' ../theme/style.css`

echo "Package"
rm -f *.zip
cd ../theme
zip -r ../target/valtech-one-$VERSION.zip *
cd ../
