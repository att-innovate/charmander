Charmander - Scheduler Lab
==========================

Charmander is a lab environment for measuring and analyzing resource-scheduling algorithms.
The project got started at the Foundry as an internship project in 2014 by Thedora Chu.

![image](https://github.com/att-innovate/charmander/blob/master/docs/assets/CharmanderSchedulerLab.png?raw=true)

Charmander at its core provides an easy to use environment to a) **schedule** and **deploy** compute-tasks in a multi-node setup
and b) **measure** the corresponding cpu, memory, and network-loads.

The collected measurements can afterwards be **analyzed** using the included Spark analytics workbench and subsequently
those results can be **fed back** in to the scheduler.


###The different Charmander projects###


1. [github.com/att-innovate/charmander][1]

    This project contains all the scripts, glue ..


2. [github.com/att-innovate/charmander-scheduler][2]

    Charmander Scheduler is a Framework for Mesos.


3. [github.com/att-innovate/charmander-heapster][3]

    A slimmed-down version of Google's Heapster project.


4. [github.com/att-innovate/charmander-spark][4]

    This project contains Charmander-specific helper functions for Spark.


###Setup and Run Charmander###

All that is required to run a simple lab setup and experiment is _Vagrant_, _VirtualBox_, _curl_ and a bit of spare time.

1. [Setup Nodes][5]

    - Configure and build the different nodes with Vagrant and VirtualBox
    - Reload and reset environment

2. [Build and deploy Scheduler][5]

    - Clone the Charmander Scheduler projects
    - Compile it inside the master node
    - Deploy and run it

3. [Build and deploy Load-Simulators][5]

4. [Build and deploy Analytics Stack][5]

5. [Build and run a simple Experiment, _maxusage_][5]

For more advanced topics like modification to the scheduler or changes to the analytics piece documents can be found at:

6. [Spark Analytics][5]
7. [Scheduler API][5]
8. [Modify Scheduler][5]


[1]: https://github.com/att-innovate/charmander
[2]: https://github.com/att-innovate/charmander-scheduler
[3]: https://github.com/att-innovate/charmander-heapster
[4]: https://github.com/att-innovate/charmander-spark
[5]: https://github.com/att-innovate/charmander/blob/master/docs/SETUPNODES.md
