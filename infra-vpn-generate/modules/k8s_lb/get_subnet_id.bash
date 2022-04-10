#!/usr/bin/env bash

set -e

eval "$(jq -r '@sh "subnet_name=\(.subnet_name)"')"

command=$(yc vpc subnet list | grep ${subnet_name} | awk  '{print $2}')

ecoded_doc=$(echo $command)
#ecoded_doc=$(echo $command | base64 )

jq -n --arg ecoded_doc "$ecoded_doc" '{"ecoded_doc":$ecoded_doc}'