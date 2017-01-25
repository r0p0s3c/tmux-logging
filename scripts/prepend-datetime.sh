#!/usr/bin/env bash

while read line; do
	date -u '+%Y%m%d-%H%M%S'|tr -d '\n';
	echo "-- ${line}"
done
