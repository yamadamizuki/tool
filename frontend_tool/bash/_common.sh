#!/bin/bash

DEBUG=true

# 引数最後で -d の場合はデバッグ表示モードに
if [ "${!#}" = "-d" ]; then
  DEBUG=true
fi

# debug 表示
d () {
  if [ "$DEBUG" = true ]; then
    echo -e "\033[1;35m[DEBUG]\033[0;39m ${1}"
  fi
}

# error 表示
e () {
  echo -e "\033[1;31m[Error]\033[0;39m ${1}"
}

# info 表示
i () {
  echo -e "\033[1;34m[Info]\033[0;39m ${1}"
}

# y/n チェック
confirmYn () {
  while true; do
      read -p "${1}（y/n）" answer
      case $answer in
          [Yy]* ) break;;
          [Nn]* )
            d 'Cancel'
            exit 0;;
          * )
            echo "y か n を入力してください";;
      esac
  done
}
