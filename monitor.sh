#!/bin/bash
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtred='\e[0;31m' # Red
txtrst='\e[0m'    # Text Reset
OIFS=$IFS
IFS=$'\n'
MAX_CLIENTS=1000000
nodes=$(cat /etc/openvpn/openvpn-status.log  | grep "^Virtual Address" -A$MAX_CLIENTS -P | grep "^GLOBAL STAT" -B$MAX_CLIENTS | tail -n +2 | head -n -1)
if [ -z "$nodes" ]; then
	echo -en $txtred"No one connected";
else
for node in $nodes; do
    arr=($(echo $node | tr " " "-" | tr "," "\n"))
    echo -en "$txtgrn${arr[1]}$txtylw connected from$txtgrn "
    echo -en $(echo ${arr[2]} | cut -d: -f1)
    echo -en "$txtylw since $txtgrn${arr[3]}" | tr "-" " "
    echo -e $txtylw" and its IP is $txtgrn${arr[0]}"
done
fi
echo -e $txtrst;
IFS=$OIFS                  
