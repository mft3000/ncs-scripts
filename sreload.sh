#!/bin/bash

# version 0.1
#
# 0.1: start script

SERVICE=$1
RELOAD=$2

if [ ! -z $SERVICE ] && [ ! -z $RELOAD ]; then
	make clean -C ~/ncs-run/packages/$SERVICE/src
	make -C ~/ncs-run/packages/$SERVICE/src
	. ~/ncs-scripts/reload.sh
elif [ ! -z $SERVICE ]; then
	make clean -C ~/ncs-run/packages/$SERVICE/src
	make -C ~/ncs-run/packages/$SERVICE/src
else
	echo "1. nothing to do... EXITING"
	exit
fi