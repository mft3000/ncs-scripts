# NSO Scripts
 
these scripts are written to make your life easy and could be used for daily jobs around Cisco NSO.

+ addHost.py

python script that using MAAGIC APIs in order to create (or delete) devices under NSO from yaml file

+ cvenv.sh

helps you to quick stop NSO, renew symlinks for ncs and ncs-run with cli arguments and restart NSO... usefull when you need to share your environment with other users or simply you want test different workspaces with different NSO versions

```
cisco ~ $ . cvenv.sh ncs4301 /home/cisco/workspaces/fmarangi/4301/ncs-run/
**** Stopping NSO...
**** remove links...
**** rebuild links NSO status...
**** Starting NSO...
**** Query NSO status...
status: started
```

+ log.sh

this command performs a tail -f ncs-run/logs/* or, if you provide a string tail -f ncs-run/logs/*string*

+ reload.sh

from bash, this scripts enters NSO_CLI and run a packet reload

+ runBackup.sh

simply shortcut to backup for eg the repository

+ sreload.sh

S stands for Service... developing services (YANG, xml, pyhton, ecc) require a lot of effort in terms to debug and check syntax errors. This script, from any directory you belong, will run a service make and, if you provide a reload keyword after the service name, will trigger reload.sh

```
sreload.sh l2vpn
```
or
```
sreload.sh l2vpn reload
```

+ unpack.sh

enter inside neds directory and run this command with the full <ned>.bin name... this will unpack the ned, copying into ncs/packages/ned/, create symlink into ncs-run/package and reload NCS

```
./unpack.sh ncs-4.3.0.1-cisco-ios-5.0.signed.bin

ncs-4.3-cisco-iosxr-5.0.1
cisco-iosxr

Continue?:
Unpacking...
Verifying signature...
Downloading CA certificate from http://www.cisco.com/security/pki/certs/crcam2.cer ...
Successfully downloaded and verified crcam2.cer.
Downloading SubCA certificate from http://www.cisco.com/security/pki/certs/innerspace.cer ...
Successfully downloaded and verified innerspace.cer.
Successfully verified root, subca and end-entity certificate chain.
Successfully fetched a public key from tailf.cer.
Successfully verified the signature of ncs-4.3-cisco-iosxr-5.0.1.tar.gz using tailf.cer
...
```

+ version.sh

from bash, this scripts enters NSO_CLI and run a 'show packages package package-version' to show packages versions

+ .bashrc

link this file to create aliases for these scripts