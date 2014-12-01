To build/deploy the crand load generator:

1) Log in to Devenv
$ ./bin/devenv ssh

2) Become super user and cd to loadsimulator
$ sudo -s
$ cd /vagrant/loadsimulator/

3) Compile crand.go
$ cd cpu
$ go build crand.go
$ cd ..

4) Build and push docker images
$ ./build-images.sh
$ ./push-images.sh

5) Log out of devenv
$ exit
$ exit

6) Example: Run random-cpu and memory-light from host system
$ ./bin/start_sim_cpu_rand
$ ./bin/start_memory_light

7) Verify deployment in Marathon and cAdvisor
