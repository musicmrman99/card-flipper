#!/bin/bash

function checkfiles {
	if [ -e ./files/highscores ]; then
		echo -n ""
	else
		echo "ERROR: the file 'highscores' does not exist"
		echo "Correcting Error: creating file 'highscores'"
		touch ./files/highscores
		sleep 1
	fi
}

function filesmessage {
	if [ -e ./files/highscores ]; then
		echo -n ""
	else
		echo "The error could not be corrected, try fixing it yourself."
	fi
}

checkfiles
checkfiles
filesmessage

