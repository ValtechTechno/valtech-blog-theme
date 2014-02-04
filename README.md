valtech-blog-theme
==================

This is the repository of the [Valtech Wordpress](blog.valtech.fr) theme.

How to test ?
-------------

 1. install vagrant
 1. if you do not have the "base" box : `vagrant box add base http://files.vagrantup.com/precise32.box`
 1. run `vagrant up`
 1. go to [http://10.10.10.2](http://10.10.10.2)

You should see the default wordpress page with the theme activated.

Any changes in `/theme` will be visible in this url.

To restart provisionning, use `vagrant provision`


The theme
---------

It includes foundation to be responsive out-of-the-box.


How it works ?
--------------

Vagrant will start an ubuntu virtual machine. Then, puppet will read its configuration and start installing required stuff (wordpress, mysql, etc.).

For final manual steps on Wordpress installation, casperjs is used to automate web clicking.
