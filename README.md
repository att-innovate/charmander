Charmander - Scheduler Lab
==========================

Charmander is a lab environment for measuring and analyzing resource-scheduling algorithms.
The project got started at the Foundry as an internship project in 2014 by Thedora Chu.

![image](https://github.com/att-innovate/charmander/blob/master/docs/assets/CharmanderSchedulerLab.png?raw=true)

Charmander at its core provides an easy to use environment to a) schedule and deploy compute-tasks in a multi-node setup
and b) measure the corresponding cpu, memory, and network-loads.

The collected measurements can afterwards be analyzed using the included Spark analytics workbench and subsequently
those results can be feed back in to the scheduler.

The project consists of 4 projects:

1. [github.com/att-innovate/charmander][1]

    This project contains all the scripts, glue ..


2. [github.com/att-innovate/charmander-scheduler][2]

    Charmander Scheduler is a Framework for Mesos.


3. [github.com/att-innovate/charmander-heapster][3]

    A slimmed-down version of Google's Heapster project.


4. [github.com/att-innovate/charmander-spark][4]

    This project contains Charmander-specific helper functions for Spark.



[1]: https://github.com/att-innovate/charmander
[2]: https://github.com/att-innovate/charmander-scheduler
[3]: https://github.com/att-innovate/charmander-heapster
[4]: https://github.com/att-innovate/charmander-spark
