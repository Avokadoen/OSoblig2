#!/bin/bash

pchrome=$(pgrep chrome)
pfcount=$(ps --no-headers -o maj_flt $pchrome)
pchlcount=$(printf "%s $pchrome" | wc -l)

for i in `seq 1 $pchlcount`;
	do
		currentch=$(printf "%s $(printf "%s $pchrome" | awk 'NR=='$i'{print $1}')")
		currentpfc=$(printf "%s $(printf "%s $pfcount" | awk 'NR=='$i'{print $1}')")
		printf "Chrome %s har forårsaket %s major page faults\n" $currentch $currentpfc
	done
