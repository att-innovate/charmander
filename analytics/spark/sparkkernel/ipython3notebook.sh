#!/bin/sh
cd /notebooks
exec ipython3 notebook --no-browser --port 8888 --ip=*
