#!/bin/sh

echo "Clean"
rm -Rf bower_components/
rm -Rf theme/foundation-3.2.5/

echo "Package"
bower install --allow-root
mkdir theme/foundation-3.2.5/
cp -r bower_components/components-foundation/* theme/foundation-3.2.5/

