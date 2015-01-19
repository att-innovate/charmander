Setup Scheduler
---------------

The Charmander-Scheduler is our lab specific Mesos-Framework. As a typical Mesos-Framework it handles the allocation of
the tasks to the individual nodes based on offers it receives from Mesos.

The Scheduler is written in Go and its source code can be found in: [charmander-scheduler project](https://github.com/att-innovate/charmander-scheduler)

More information about the Scheduler API can be found at: [Scheduler API](https://github.com/att-innovate/charmander/blob/master/docs/SCHEDULERAPI.md)

### Deploy Scheduler

Clone, compile and start up Scheduler. The compilation of the code happens behind the scene on the "master" node.

```
./bin/deploy_scheduler
```

Verify that is shows up under Frameworks in the Mesos Management Console: [http://172.31.1.11:5050](http://172.31.1.11:5050)


### Reset Scheduler

To simply reset the scheduler for example to start a new fresh experiment:

```
./bin/reset_scheduler
```

### Redeploy Scheduler

Pull changes from the github project, compile the code and re-run it

```
./bin/deploy_scheduler
```

