#!/bin/sh 

{
ncs_cli -u admin -C << EOF;
show packages package package-version
exit
EOF
}
