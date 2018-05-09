#!/bin/bash

REG=$1


if [ ! -z $FILE ]; then
	tail -f $NCS_WORKDIR/logs/*$REG*
else
	tail -f $NCS_WORKDIR/logs/*
fi

cd
