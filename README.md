valtech-blog-theme
==================

This is the repository of the [Valtech Wordpress](blog.valtech.fr) theme.

How to run it ?
---------------

 1. install docker
 1. run `./start.sh`
 1. run `docker logs --follow wordpress-for-theme`
 1. Look for IP into line `apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.7 for ServerName`
 1. Navigate to this IP on your browser
 1. Follow final installation steps of wordpress
 1. Login with the admin account you created
 1. Activate the valtech theme

You should see the default wordpress page with the theme activated.

Any changes in `/theme` will be visible in this url.


The theme
---------

It uses [foundation](http://foundation.zurb.com) in order to be responsive out-of-the-box.


How it works ?
--------------

`start.sh` is starting a mysql container and a wordpress container. Previously, the wordpress container is built with a volume to link the theme.

`stop.sh` is stopping and removing the previously built wordpress and mysql containers.


How to package the theme ?
--------------------------

Don't forget to increment version in `target/package.sh` and `theme/style.css`

Run a docker container to use bower :
```
cd target
docker run -it --rm -v $(pwd):/data dockerfile/nodejs-bower-grunt
```

Run this command from the bower container :
```
./build.sh
```

Then, exit from the container :
```
exit
```

And create the package :
```
cd target
./package.sh
```

You can now upload the new version of the theme and activate it on the blog in the admin section.