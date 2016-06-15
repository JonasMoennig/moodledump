#!/bin/bash

shopt -s extglob

URL="$1"
domain="$(echo $URL | cut -d/ -f1-3)"

shift
regex="!(*.$1"
shift

until [ -z "$1" ]
do
  regex="$regex"'|*.'"$1"
  shift
done

regex="$regex"\)

for file in $(curl -L -s -b cookies.txt "$URL" | grep -o '/mod/resource/view.php?id=[[:digit:]]*')
do
  curl -L -J -s -b cookies.txt -O "$domain""$file"
done

eval rm "$regex"
