#!/bin/sh

function hasFile() {
  local result="false"
  if [[ "${1}" && -e "${1}" ]]; then
    result="true"
  fi
  echo "$result"
}
function hasDir() {
  local result="false"
  if [[ "${1}" ]]; then
    if [ -d "${1}" ]; then
      result="true"
    fi
  fi
  echo "$result"
}
function getFiles() {
  local dir_or_file=""
  for files in $(ls $1); do
    dir_or_file=$1"/"$files
    if [ -d $dir_or_file ]; then #是目录的话递归遍历
      getFiles $dir_or_file
    else
      echo "$dir_or_file"
    fi
  done
}
# getFiles "./src"

# file -usage
# ./scripts/common-function.sh
