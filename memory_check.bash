#!/bin/bash

#Change this
usage() { echo "Usage: $0 [-c Critical Threshold] [-w Warning Threshold] [-e Email Address]" exit 1; }

#Reading input using getopts
while getopts c:w:e: option
do
 case "${option}"
 in
 c) CRITTHRESH=${OPTARG}
	;;
 w) WARNTHRESH=${OPTARG}
	;;
 e) EADD=${OPTARG}
	;;
 *) usage
	;;
 esac
done

if [ -z "${CRITTHRESH}" ] || [ -z "${WARNTHRESH}" ] || [-z "${EADD}"]; then
    usage
fi

#checking if CRITTHRESH greater than WARNTHRESH
if ["${CRITTHRESH}" -gt "${WARNTHRESH}"]
then
usage
fi





