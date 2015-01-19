Setup Load-Simulators
---------------------

Charmander comes with a few example of load-simulators. They can be found in the directory `./loadsimulator`
_cpufixed_ and _cpurandom_ are some simple samples implemented in go, _lookbusy_ and _stress_ are based on existing tools.


### Build and Deploy Load-Simulators

Build corresponding Docker images on all the _lab nodes_.

```
./bin/build_simulator
```

### Next build and deploy Analytics Stack

[Analytics-Stack](https://github.com/att-innovate/charmander/blob/master/docs/SETUPANALYTICS.md)

