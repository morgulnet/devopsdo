#!/usr/bin/env bash

set -e

eval "$(jq -r '@sh "dnszone_name=\(.dnszone_name)"')"

command=$(yc dns zone get ${dnszone_name} --format json | jq -r '.id')

ecoded_doc=$(echo $command)
# ecoded_doc=$(echo $command | base64 )

jq -n --arg ecoded_doc "$ecoded_doc" '{"ecoded_doc":$ecoded_doc}'
