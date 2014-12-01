#!/usr/bin/python

# Input: ./sim_mem.py -r -i -l=light/medium/heavy/# -s=hour/min/sec -w=time_wait_to_start

import time
import subprocess
import random
import sys

LIGHT_LOAD = '100'	# height ~28 MB
MEDIUM_LOAD = '1000'	# height ~105 MB
HEAVY_LOAD = '10000'	# height ~800 MB

NO_ARG_SUPPLIED = '0'
INF = 'inf'
RAND = 'rand'

SECS_IN_HR = 3600
SECS_IN_MIN = 60
SEC = 1

LENGTH_OF_OUTER_LOOP = 1000
TIME_BETWEEN_ITER = 0.1

def loopSize(load):
	if(load == 'light'):
		return LIGHT_LOAD
	elif(load == 'medium'):
		return MEDIUM_LOAD
	elif(load == 'heavy'):
		return HEAVY_LOAD
	elif(load.isdigit()):
		return load	# assumes user won't put in negative number
	else:
		raise NameError(load + ' is not defined')

def startOn(hms):
	if(hms == 'hour'):
		time.sleep(SECS_IN_HR - (time.time() % SECS_IN_HR))
	elif(hms == 'min'):
		time.sleep(SECS_IN_MIN - (time.time() % SECS_IN_MIN))
	elif(hms == 'sec'):
		time.sleep(SEC - (time.time() % SEC))
	else:
		raise NameError(hms + ' is not defined')

def parseArgs():
	loop = NO_ARG_SUPPLIED
	if(len(sys.argv) == 1):	# no program arguments provided
		return loop
	for x in range(len(sys.argv)):
		if(x == 0):
			continue
		if sys.argv[x].startswith('-l='):
			load = sys.argv[x].split('=').pop()
			if(loop == NO_ARG_SUPPLIED):
				loop = loopSize(load)
			else:
				loop = loop + loopSize(load)	# keeps number at end after INF or RAND
		elif sys.argv[x].startswith('-i'):
			if (loop == NO_ARG_SUPPLIED):
				loop = INF
			else:
				loop = INF + loop	# keeps INF at beginning
		elif sys.argv[x].startswith('-r'):
			if (loop.startswith(INF)):
				loop = loop[:3] + RAND	# keeps RAND after INFD
			else:
				loop = RAND
		elif sys.argv[x].startswith('-w='):	# amount of time to wait before starting program
			time.sleep(sys.argv[x].split('=').pop())
			break
		elif sys.argv[x].startswith('-s='):	# start program on hour/min/sec
			hms = sys.argv[x].split('=').pop()
			startOn(hms)
			break
		else:
			raise NameError(sys.argv[x] + ' is not defined')
	return loop

def runRandom():
	loop = random.randrange(10000)
	for x in range(loop):
		inner = random.randrange(10000)
		subprocess.call(['/prog/sim_mem_inner.py', str(inner)])
		pause = random.randrange(10)/100.0
		time.sleep(pause)

def finite(loop):
	if(loop == RAND):
		runRandom()
	else:
		x = LENGTH_OF_OUTER_LOOP
		if(loop == NO_ARG_SUPPLIED):
			loop = MEDIUM_LOAD
		while(True):
			if(x == 0):
				break	
			subprocess.call(['/prog/sim_mem_inner.py', loop])
			time.sleep(TIME_BETWEEN_ITER)
			x = x-1

def infinite(loop):
	if(loop == RAND):
		while(True):
			runRandom()
	else:
		while(True):
			subprocess.call(['/prog/sim_mem_inner.py', loop])
			time.sleep(TIME_BETWEEN_ITER)

def main():
	loop = parseArgs()
	if(loop.startswith(INF)):
		infinite(loop[3:])
	else:
		finite(loop)
	
if __name__ == '__main__':
	main()
