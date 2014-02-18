#!/bin/sh

echo "Clean"
rm -Rvf bower_components/
rm -Rvf theme/foundation/
rm -Rvf theme/normalize-css/
rm -Rvf theme/jquery/

echo "Deploy"
bower install --allow-root
mkdir -p theme/foundation/
cp bower_components/components-foundation/js/foundation.min.js theme/foundation/
cp bower_components/components-foundation/css/foundation.min.css theme/foundation/
mkdir -p theme/modernizr/
cp bower_components/components-foundation/js/vendor/custom.modernizr.js theme/modernizr/
mkdir -p theme/normalize-css/
cp bower_components/normalize-css/normalize.css theme/normalize-css/
mkdir -p theme/jquery/
cp bower_components/jquery/dist/jquery.min.js theme/jquery/