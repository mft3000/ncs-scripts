#!/bin/sh

# version 0.2
#
# 0.1: start script
# 0.2: add enhanced

# ncs-4.3.0.1-cisco-ios-5.0.signed.bin
# ncs-4.3-cisco-asa-5.0.signed.bin
# ncs-4.3-cisco-iosxr-5.0.1.signed.bin
# ncs-4.3-cisco-nx-4.2.3.signed.bin
# ncs-4.3-fortinet-fortios-4.0.signed.bin
# ncs-4.3-huawei-vrp-3.2.4.signed.bin
# ncs-4.3-juniper-junos-3.0.31.signed.bin
# ncs-4.3-linux-iptables-0.2.signed.bin
# ncs-4.3-vmware-vsphere-3.0.27.signed.bin


# work for only .bin files!!!!
# ./unpack.sh ncs-4.3.0.1-cisco-ios-5.0.signed.bin

# ncs-4.3-cisco-iosxr-5.0.1
# cisco-iosxr

# Continue?:
# Unpacking...
# Verifying signature...
# Downloading CA certificate from http://www.cisco.com/security/pki/certs/crcam2.cer ...
# Successfully downloaded and verified crcam2.cer.
# Downloading SubCA certificate from http://www.cisco.com/security/pki/certs/innerspace.cer ...
# Successfully downloaded and verified innerspace.cer.
# Successfully verified root, subca and end-entity certificate chain.
# Successfully fetched a public key from tailf.cer.
# Successfully verified the signature of ncs-4.3-cisco-iosxr-5.0.1.tar.gz using tailf.cer
# ...


#FULL_FILE=$1
FULL_FILE=$(ls $1 | sed  's|.signed.bin||' | sed  's|.tar.gz||')
#TARGET_DIR=$2
TARGET_DIR=$(ls | grep  $FULL_FILE.signed.bin |  awk '{split($0,a,"-"); print a[3] "-" a[4]}')

echo
echo $FULL_FILE
echo $TARGET_DIR
echo
read -p "Continue?:" CHOOSE

cd ~/neds
if [ -f $FULL_FILE.signed.bin ]; then
	chmod 777 $FULL_FILE.signed.bin
	./$FULL_FILE.signed.bin
	rm cisco_x509_verify_release.py *.cer *.signature
	echo
else
	echo "File '$FULL_FILE.signed.bin' not Found... Skip"
fi

if [ -f $FULL_FILE.tar.gz ]; then
	tar zxvf $FULL_FILE.tar.gz
	mv $TARGET_DIR $FULL_FILE
	mv $FULL_FILE ~/ncs/packages/neds/
	rm ~/ncs-run/packages/$TARGET_DIR
	ln -s ~/ncs/packages/neds/$FULL_FILE/ ~/ncs-run/packages/$TARGET_DIR
	make clean -C ~/ncs-run/packages/$TARGET_DIR/src
	make -C ~/ncs-run/packages/$TARGET_DIR/src
	. ~/ncs-scripts/reload.sh
	. ~/ncs-scripts/version.sh
	# rm $FULL_FILE.tar.gz
	cd
else
	echo "File '$FULL_FILE.tar.gz' not Found... Skip"
fi

echo "=========== howto remove ==========="

for i in $(ls -l ~/ncs-run/packages/ | grep "\->" | awk ' {print $9} '); do
        echo rm ~/ncs-run/packages/$i
done

echo ""

for i in $(ls -l ~/ncs-run/packages/ | grep "\->" | awk ' {print $11} '); do
	echo rm -rf $i
done
