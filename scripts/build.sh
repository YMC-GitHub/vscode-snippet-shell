#!/bin/sh

function replaceTxt() {
  local txt=""
  txt=$(cat ${1} | sed "s/^{ *$//" | sed "s/^} *$//")
  echo "$txt"
}

des=".vscode/shellscript.code-snippets"
list=$(
  cat <<EOF
./src/syntax/arg.json
./src/syntax/arr.json
./src/syntax/bool.json
./src/syntax/char.json
./src/syntax/comment.json
./src/syntax/echo.json
./src/syntax/file.json
./src/syntax/file_head.json
./src/syntax/file_include.json
./src/syntax/for.json
./src/syntax/fun.json
./src/syntax/if.json
./src/syntax/io_redirect.json
./src/syntax/logic.json
./src/syntax/math.json
./src/syntax/read_input.json
./src/syntax/relation.json
./src/syntax/run_code.json
./src/syntax/until.json
./src/syntax/var.json
./src/syntax/while.json
EOF
)

arr=(${list// / })
length=${#arr[@]}
txt=""
tmp=""
index_end=$(($length - 1))
for ((i = 0; i < length; i++)); do
  if [ $length -ge "2" ]; then
    if [ $i -eq $index_end ]; then
      tmp=$(cat ${arr[i]} | sed "s/^{ *$//" | sed "s/^} *$//")
    else
      tmp=$(cat ${arr[i]} | sed "s/^{ *$//" | sed "s/^} *$//")
      tmp="${tmp},"
    fi
  else
    tmp=$(cat ${arr[i]} | sed "s/^{ *$//" | sed "s/^} *$//")
  fi
  txt=$(
    cat <<EOF
$txt
$tmp
EOF
  )
done

txt=$(
  cat <<EOF
{
$txt
}
EOF
)
# delete white space line
echo "$txt" | sed "/^$/d" >"$des"
# ./scripts/build.sh
