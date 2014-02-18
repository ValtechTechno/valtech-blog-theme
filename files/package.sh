#!/bin/sh

echo "Package"
rm *.zip
cd ../theme
zip -r ../target/valtech-one-<%= version %>.zip *
cd ../
