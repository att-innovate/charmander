Charmander - Scheduler Lab
==========================

Charmander is a lab environment for measuring and analyzing resource-scheduling algorithms.
The project got started at the Foundry as an internship project in 2014 by Thedora Chu.

![image](https://github.com/att-innovate/charmander/blob/master/docs/assets/CharmanderSchedulerLab.png?raw=true)

Charmander at its core provides an easy to use environment to a) **schedule** and **deploy** compute-tasks in a multi-node setup
and b) **measure** the corresponding cpu, memory, and network-loads.

The collected measurements can afterwards be **analyzed** using the included Spark analytics workbench and subsequently
those results can be **fed back** in to the scheduler.


The different Charmander projects
---------------------------------

1. [github.com/att-innovate/charmander][1]

    This project contains all the scripts, glue ..


2. [github.com/att-innovate/charmander-scheduler][2]

    Charmander Scheduler is a Framework for Mesos.


3. [github.com/att-innovate/charmander-heapster][3]

    A slimmed-down version of Google's Heapster project.


4. [github.com/att-innovate/charmander-spark][4]

    This project contains Charmander-specific helper functions for Spark.


Setup and Run Charmander
------------------------

All that is required to run a simple lab setup is _Vagrant_ and _VirtualBox_.
If you want to modify the Scheduler a local install of _golang_ is needed and for more advanced Spark analytics we suggest
that you have a local install of Spark including sbt and Java. Additional information can be found via the following links.

1. [Setup Nodes][5]

    Steps to configure and build the different nodes with Vagrant and VirtualBox

2. [Build and deploy Scheduler][6]

    Clones the Charmander Scheduler projects, builts i
3. Build and deploy Analytics Stack
4. Build and deploy Load-Simulators
5. Spark Analytics
6. Modify Scheduler


[1]: https://github.com/att-innovate/charmander
[2]: https://github.com/att-innovate/charmander-scheduler
[3]: https://github.com/att-innovate/charmander-heapster
[4]: https://github.com/att-innovate/charmander-spark
[5]: https://github.com/att-innovate/charmander/blob/master/docs/SETUPNODES.md
