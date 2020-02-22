#!/bin/sh

function isAbsolute() {
  local result=
  local ABSOLUTE_PATH_REG_PATTERN=
  local inputValue=
  result="false"
  ABSOLUTE_PATH_REG_PATTERN="^/"
  inputValue="${1}"
  if [[ $inputValue =~ $ABSOLUTE_PATH_REG_PATTERN ]]; then
    result="true"
  fi
  echo "$result"
}
## function usage
# isAbsolute "/" #it will return ture
# isAbsolute "./" #it will return false

function path_resolve_for_relative() {
  local str1=
  local str2=
  local slpit_char1=
  local slpit_char2=

  str1="${1}"
  str2="${2}"
  #delete start char `"` or end char `"`
  str1=$(echo "$str1" | sed "s#^\"##" | sed "s#\"\$##")
  str2=$(echo "$str2" | sed "s#^\"##" | sed "s#\"\$##")

  slpit_char1=/
  slpit_char2=/
  if [[ -n ${3} ]]; then
    slpit_char1=${3}
  fi
  if [[ -n ${4} ]]; then
    slpit_char2=${4}
  fi

  # 路径-转为数组
  local arr1=
  local arr2=
  arr1=(${str1//$slpit_char1/ })
  arr2=(${str2//$slpit_char2/ })

  # 路径-解析拼接
  #2 遍历某一数组
  #2 删除元素取值
  #2 获取数组长度
  #2 获取数组下标
  #2 数组元素赋值
  local length=
  local index=

  for val2 in ${arr2[@]}; do
    length=${#arr1[@]}
    if [ $val2 = ".." ]; then
      index=$(($length - 1))
      if [ $index -le 0 ]; then index=0; fi
      unset arr1[$index]
      #echo ${arr1[*]}
      #echo  $index
    elif [ $val2 = "." ]; then
      echo "it is current file" >/dev/null 2>&1
    else
      index=$length
      arr1[$index]=$val2
      #echo ${arr1[*]}
    fi
  done
  # 路径-转为字符
  local str3=''
  for i in ${arr1[@]}; do
    str3=$str3/$i
  done
  if [ -z $str3 ]; then str3="/"; fi
  echo $str3
}
## function usage
# path_resolve_for_relative "/app/src" "./" #it will return "/app/src"
# path_resolve_for_relative "/app/src" "." #it will return "/app/src"
# path_resolve_for_relative "/app" "test" #it will return "/app/test"
# path_resolve_for_relative "/app/src" "../" #it will return "/app"
# path_resolve_for_relative "/app/src" ".." #it will return "/app"
# path_resolve_for_relative "/app/src" "../test" #it will return "/app/test"

function path_resolve() {
  local str1=
  local str2=
  local slpit_char1=
  local slpit_char2=

  str1="${1}"
  str2="${2}"
  #delete start char `"` or end char `"`
  str1=$(echo "$str1" | sed "s#^\"##" | sed "s#\"\$##")
  str2=$(echo "$str2" | sed "s#^\"##" | sed "s#\"\$##")

  slpit_char1=/
  slpit_char2=/
  if [[ -n ${3} ]]; then
    slpit_char1=${3}
  fi
  if [[ -n ${4} ]]; then
    slpit_char2=${4}
  fi

  #FIX:when passed asboult path,does not return the asboult path itself
  #str2="/d/"
  local str3=
  str3=""
  #fix:path_resolve "/app/src" "/" #it will return "/" does not return the asboult path itself
  if [ $str2 != "/" ]; then
    # delete end char /
    str2=$(echo $str2 | sed "s#/\$##")
  fi

  if [ $(isAbsolute $str2) = "true" ]; then
    str3=$str2
  else
    str3=$(path_resolve_for_relative $str1 $str2 $slpit_char1 $slpit_char2)
  fi
  echo $str3
}
## function usage
# path_resolve "/" "src" #it will return "/src"
# path_resolve "/app" "src"#it will return "/app/src"
# path_resolve "/app/src" "./" #it will return "/app/src"
# path_resolve "/app/src" "../" #it will return "/app"
# path_resolve "/app/src" "/" #it will return "/"
# path_resolve "/app/src" "/d" #it will return "/d"
