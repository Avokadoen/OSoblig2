#!/bin/bash

function top_print {
	printf "******** Minne info om prosess med PID %i ********" "$1"
}

function tot_vm {
	vm=$(grep VmSize /proc/"$1"/status | grep -o -E "[1-9]?[0-9]*")
	printf "\nTotal bruk av virtuelt minne (VmSize): %ikb" "$vm"
}

function priv_vm {
	vme=$(grep VmExe /proc/"$1"/status | grep -o -E "[1-9]?[0-9]*")
	vms=$(grep VmStk /proc/"$1"/status | grep -o -E "[1-9]?[0-9]*")
	vmd=$(grep VmData /proc/"$1"/status | grep -o -E "[1-9]?[0-9]*")
	vm=$((vmd+vms+vme))
	printf "\nMengde privat virtuelt minne (VmData+VmStk+VmExe): %skb" "$vm"
}

function lib_vm {
	vm=$(grep VmLib /proc/"$1"/status | grep -o -E "[1-9]?[0-9]*")
	printf "\nMengde shared virtuelt minne (VmLib): %ikb" "$vm"
}

function phy_vm {
	vm=$(grep VmRSS /proc/"$1"/status | grep -o -E "[1-9]?[0-9]*")
	printf "\nTotal bruk av fysisk minne (VmRSS): %ikb" "$vm"
}

function phypt_vm {
	vm=$(grep VmPTE /proc/"$1"/status | grep -o -E "[1-9]?[0-9]*")
	printf "\nMengde fysisk minne som benyttes til page table (VmPTE): %ikb \n" "$vm"
}


for i in $(seq 1 $#);
	do
	printf "\n"
	top_print "${!i}"
	tot_vm "${!i}"
	priv_vm "${!i}"
	lib_vm "${!i}"
	phy_vm "${!i}"
	printf "\n"
done
