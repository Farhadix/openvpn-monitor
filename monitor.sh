#!/bin/bash
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtred='\e[0;31m' # Yellow
txtrst='\e[0m'    # Text Reset
OIFS=$IFS
IFS=$'\n'
MAX_CLINETS=1000000
nodes=$(cat /etc/openvpn/openvpn-status.log  | grep "^Common Name" -A$MAX_CLINETS -P | grep "^ROUTING TABLE" -B$MAX_CLINETS | tail -n -1 | head -n -1)
if [ ! $nodes ]; then
	echo -en $txtred"No one connected";
else
for node in $nodes; do
    arr=($(echo $node | tr " " "-" | tr "," "\n"))
    echo -en "$txtgrn${arr[0]}$txtylw connected from$txtgrn ${arr[1]}$txtylw since "
    echo -e "$txtgrn${arr[4]}" | tr "-" " "
done
fi
echo -e $txtrst;
IFS=$OIFS                  
