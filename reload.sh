#!/bin/sh 

{
ncs_cli -u admin -C << EOF;
package reload 
exit
EOF
}
