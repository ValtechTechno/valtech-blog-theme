#!/bin/sh

echo "Package"
rm -f *.zip
cd ../theme
zip -r ../target/valtech-one-<%= version %>.zip *
cd ../
