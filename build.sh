#!/bin/sh

echo "Clean"
rm -Rvf bower_components/
rm -Rvf theme/foundation/

echo "Deploy"
bower install --allow-root
mkdir -p theme/foundation/js/vendor
cp bower_components/components-foundation/js/vendor/modernizr.js theme/foundation/js/vendor/
mkdir -p theme/foundation/css
cp bower_components/components-foundation/css/foundation.min.css theme/foundation/css/
cp bower_components/components-foundation/css/normalize.css      theme/foundation/css/
cp bower_components/components-foundation/js/foundation.min.js   theme/foundation/js/
cp bower_components/components-foundation/js/vendor/jquery.js    theme/foundation/js/vendor/