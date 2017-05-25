#!/bin/bash

#Change this
usage() { 
	echo "Usage: $0 [-c Critical Threshold] [-w Warning Threshold] [-e Email Address] where -c greater than -w" 
	exit 1; }

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

if [ -z "${CRITTHRESH}" ] || [ -z "${WARNTHRESH}" ] || [ -z "${EADD}" ]; then
    usage
fi

#checking if CRITTHRESH greater than WARNTHRESH
if [ "${CRITTHRESH}" -lt "${WARNTHRESH}" ]
	then
	usage
fi

USED_MEMORY=$( free | grep Mem: | awk '{ print int($3/$2*100) }' )

if [[ "${USED_MEMORY}" -ge "${CRITTHRESH}" ]]
then
#get the current date and time to use as subject
DATE=$(date +'%Y%m%d')
TIME=$(date +'%k:%M')
#get the top 10 processes
MESSAGE='ps -eo pid,comm,%cpu | sort -rk 3 | head'
#send as email
echo "${MESSAGE}" | mail -s "${DATE} ${TIME} memory check - critical" "${EADD}"
exit 2;
elif [[ "${USED_MEMORY}" -ge "${WARNTHRESH}" ]] && [[ "${USED_MEMORY}" -lt "${CRITTHRESH}" ]]; then
exit 1;
else
exit 0;
fi


