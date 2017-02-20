#!/bin/bash
#↑#!で後に書かれたプログラムを実行するの意味・お約束

#現在位置を取得
CURRENT=$(cd $(dirname $0) && pwd)

#便利関数を読み込み
source ${CURRENT}/_common.sh

# SKIYAKI リポジトリのパスを読み込む
source ${CURRENT}/frontend_developer.ini 2> /dev/null

# 設定がない場合は入力
if [ -z "$SKIYAKI_DIR" ]; then
  read -p "SKIYAKI 構築環境のパスを設定してください > " path
  echo "SKIYAKI_DIR=${path}" >> ${CURRENT}/frontend_developer.ini
  SKIYAKI_DIR=${path}
fi

# 実行時の Dir
CURRENT_DIR=$(pwd)



if [ -z "$IGNORE_FILENAME" ]; then
	# ~/に一旦移動する
	cd ~/
	# ignoreファイルを作成する
	read -p "ignoreファイルを作成いたします。ファイル名を英字で入力してください >" IGNORE_FILENAME
	echo "IGNORE_FILENAME=${IGNORE_FILENAME}" >> ${CURRENT}/frontend_developer.ini
	touch ${IGNORE_FILENAME}
	declare -a IGNORE_FILE=(".DS_Store" ".npm" "npm**" "package.json")
	declare -a IGNORE_DIRECTRY=("node_modules/" "jspm_packages/")
	echo "# file" >> ${IGNORE_FILENAME}
	for ((i = 0; i< ${#IGNORE_FILE[@]}; i++)){
		echo -e ${IGNORE_FILE[$i]} >> ${IGNORE_FILENAME}
	}
	echo "# directory" >> ${IGNORE_FILENAME}
	for ((i = 0; i< ${#IGNORE_DIRECTRY[@]}; i++)){
		echo -e ${IGNORE_DIRECTRY[$i]} >> ${IGNORE_FILENAME}
	}
fi

# 以降はSKIYAKIリポジトリ内で実行する
cd ${SKIYAKI_DIR}

# configにexcludesfileの設定があるか確認する
EX_PRESENT=$(git config --local core.excludesfile)
if [ -z ${EX_PRESENT} ] || [echo ${EX_PRESENT} | grep "${IGNORE_FILENAME}"];then
	d ${IGNORE_FILENAME}
	git config --local core.excludesfile "~/${IGNORE_FILENAME}"
fi





# デバッグ用 変数
d ${SKIYAKI_DIR}
d ${IGNORE_FILENAME}
d ${EX_PRESENT}




