Build and deploy Vector
--------------------------------

- [Vector](https://github.com/att-innovate/charmander-vector) Open source on-host performance monitoring framework which exposes hand picked high resolution metrics to every engineer’s browser from Netflix.
- [PCP](http://pcp.io/) Performance Co-Pilot (PCP) provides a framework and services to support
system-level performance monitoring and management.

#### Build and start Vector
To build Vector

    ./bin/build_vector

To start Vector

    ./bin/start_vector

Note: you should start analytics first before starting vector.

After vector started, you can view it at http://172.31.2.11:31790
Enter the hostname/ip address and wait a few seconds for the metrics to load.