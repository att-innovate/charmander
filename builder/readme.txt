To build/deploy the docker images for OpenTSDB, HBase, Redis:

1) Log in to Devenv
$ ./bin/devenv ssh

2) Become super user and cd to builder
$ sudo -s
$ cd /vagrant/builder

3) Build and push docker images
$ ./build-images.sh
$ ./push-images.sh

5) Log out of devenv
$ exit
$ exit
