Build and deploy Load-Simulators
--------------------------------

Charmander already comes with a few load-simulators. They can be found in `./loadsimulator`.
_Cpufixed_ and _cpurandom_ are some simple samples implemented in go, _lookbusy_ and _stress_ are based on existing tools.


Build corresponding Docker images on all the _lab nodes_.

```
./bin/build_simulator
```

#### Next build and deploy Analytics Stack

[Analytics-Stack](https://github.com/att-innovate/charmander/blob/master/docs/SETUPANALYTICS.md)

