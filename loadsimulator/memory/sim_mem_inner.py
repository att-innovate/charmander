#!/usr/bin/python

import sys
import time

def useMem(loop):
	a = ['abc'] * loop
	b = a * 100
	c = b * 100
	time.sleep(0.1)
	return a

useMem(int(sys.argv[1]))
