#!/bin/bash

#source part of awk: https://superuser.com/questions/722451/cpu-time-used-last-second

meny="
1 - Hvem er jeg og hva er navnet på dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og tråder finnes?
4 - Hvor mange context switcher fant sted siste sekund?
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
6 - Hvor mange interrupts fant sted siste sekund?
9 - Avslutt dette scriptet
velg alternativ: "

input="0"

#filnavn="$($0 | grep -o -E "[a-z].*"

function choice1 {
	printf "\nJeg er %s og scriptet heter %s\n" $(whoami) $(printf $0 | grep -o -E "[a-zA-Z0-9].*")
}

function choice2 {
	printf "\nsiste boot var %s"
	echo $(command uptime -p)
}

function choice3 {
	printf "\ndet er %d prosesser som er aktiv" $(grep processes /proc/stat | grep -E -o "[0-9].*")
	printf "\ndet er %d tråder som er aktiv\n" $(ps -e -T | wc -l)
}

function choice4 {
	printf "\nvennligst vent"
	cSwitch1=$(grep ctxt /proc/stat | grep -o -E [1-9]?[0-9]*)
	sleep 1
	cSwitch2=$(grep ctxt /proc/stat | grep -o -E [1-9]?[0-9]*)
	cSwitch3=$(($cSwitch2-$cSwitch1))
	printf "\nsiste sekund var det %i context switcher" $cSwitch3
}

function choice5 {
	printf "\nsystemkalltid siste sekund er %i \nbrukerkalltid siste sekund er %i" $(vmstat 1 2 | awk 'NR==4{print $14} NR==4{print $13}')
}

function choice6 {
	printf "\ninterrupts siste sekund er %i" $(vmstat 1 2 | awk 'NR==4{print $11}')
}

while [ $input -ne "9" ]
do
	printf %s "$meny"
	read -e input

	case "$input" in
		"1")
		choice1
		;;

		"2")
		choice2
		;;

		"3")
		choice3
		;;

		"4")
		choice4
		;;

		"5")
		choice5
		;;

		"6")
		choice6
		;;

		"9")
		;;

		*)
		printf "\ninvalid input\n"
		;;
	esac

	read -e

done
exit 0
#case ""
