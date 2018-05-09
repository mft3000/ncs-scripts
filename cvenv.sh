#!/bin/bash 

# version 0.1
#
# 0.1: start script

# README
# renew ncs and ncs-run links

# MANUAL
#
# export NCS=ncs4301
# export NCS_RUN=/home/cisco/workspaces/fmarangi/4301/ncs-run/
# . cvenv.sh $NCS $NCS_RUN
# cd ~/ncs-run
# ncs --stop
# cd
# rm ncs
# rm ncs-run
# ln -s $NCS ncs
# ln -s $NCS_RUN ncs-run
# cd ~/ncs-run
# ncs
# cd
# ls -l

# RUN SCRIPT 
#
# cisco ~ $ . cvenv.sh ncs440 /home/cisco/workspaces/userb/440/ncs-run/
# **** Stopping NSO...
# **** remove links...
# **** rebuild links NSO status...
# **** Starting NSO...
# **** Query NSO status...
# status: started

# cisco ~ $ . cvenv.sh ncs4301 /home/cisco/workspaces/fmarangi/4301/ncs-run/
# **** Stopping NSO...
# **** remove links...
# **** rebuild links NSO status...
# **** Starting NSO...
# **** Query NSO status...
# status: started

RUN=$1
WORK=$2

############ start NCS
function nso_start {
	echo "**** Starting NSO..."
	cd ~/ncs-run
	ncs
	cd
}

############ stop NCS
function nso_stop {
	echo "**** Stopping NSO..."
	cd ~/ncs-run
	ncs --stop
	cd
}

############ get NCS status
function nso_status {
	echo "**** Query NSO status..."
	ncs --status | grep status
}

############ get NCS links
function show_links {
	echo "**** show NSO links..."
	cd
	ls -l | grep -e -\>
}

############ remove NCS links
function rm_links {
	echo "**** remove links..."
	cd
	rm ncs
	rm ncs-run
}

############ remove NCS links
function build_links {
	echo "**** rebuild links NSO status..."
	cd
	ln -s $RUN ncs
	ln -s $WORK ncs-run
	cd
}

if [ ! -z $RUN ] && [ ! -z $WORK ]; then
	nso_stop
	rm_links
	build_links
	nso_start
	nso_status
	show_links
else
	echo "nothing to do... EXITING"
	echo "head -44 $NCS_SCRIPTS/cvenv.sh"
	exit
fi
