#!/usr/bin/env bash
set -e

# [version] 20220223.3

# [title] this is a generic file updater script
# [title] 这是一个通用性的文件更新脚本
# [reference] 变量用 {} 的解释：https://stackoverflow.com/questions/8748831/when-do-we-need-curly-braces-around-shell-variables


# [variable] 定义一些要用到的变量
if [ "${1}" = "file-1" ]; then
  FILE_LOCAL_NAME='file-1'
  FILE_LOCAL_PATH="$HOME/dest_dir_1"
  FILE_PERMISSION='644'
  NEW_FILE_LINK='github_link_1'
elif [ "${1}" = "file-2" ]; then
  FILE_LOCAL_NAME='file-2'
  FILE_LOCAL_PATH="$HOME/dest_dir_2"
  FILE_PERMISSION='644'
  NEW_FILE_LINK='github_link_2'
else
  FILE_LOCAL_NAME='error'
  FILE_LOCAL_PATH="error"
  FILE_PERMISSION='error'
  NEW_FILE_LINK='error'
fi

echo "FILE_LOCAL_NAME is ${FILE_LOCAL_NAME}"
echo "FILE_PERMISSION is ${FILE_PERMISSION}"

# 创建一个临时文件夹，如果创建失败则退出
TMP_DIR=$(mktemp -d) || exit 1
echo ''
echo ">> temp dir created here: ${TMP_DIR}"
echo ''

# $1 是新版本的远程下载地址， $2 是本地文件名
function download_newfile_to_tmp() {
  if curl -L "${1}" -o "${TMP_DIR}/${2}"; then
    echo ''
    echo ">> ${1} is downloaded to ${TMP_DIR}/${2}"
  else
    echo ''
    echo '>> ERROR: Download failed! Please check your network or try again.'
    [[ -d "${TMP_DIR}" ]] && rm -r -f "${TMP_DIR}"
    exit 1
  fi
}

# fucntion download_checksum_to_tmp() {
#   some code here
# }

# fucntion checksum() {
#   some code here
# }


function check_install_path() {
  if [ -d "${FILE_LOCAL_PATH}" ]; then
    echo ''
    echo "Direcctory already exists: ${FILE_LOCAL_PATH}"
  else
    mkdir -p "${FILE_LOCAL_PATH}"
    echo ''
    echo "Direcctory created: ${FILE_LOCAL_PATH}"
  fi
}


# $1是权限，$2是下载到临时文件的新文件，$3是目标path
function install_tmpfile() {
  if install -b -m "$1" "${TMP_DIR}/${2}" "${3}"; then
    echo ''
    echo ">> ${TMP_DIR}/${2} is installed to ${3} with permission ${1}"
  else
    echo ''
    echo '>> ERROR: Install Failed! Please check your file or try again.'
    [[ -d "${TMP_DIR}" ]] && rm -r -f "${TMP_DIR}"
    exit 1
  fi
}


# 清理临时文件，$1是脚本创建的临时文件夹地址
function remove_tmpfile() {
  if rm -r -f "${TMP_DIR}"; then
    echo ''
    echo ">> ${TMP_DIR} and its contents are removed."
  else
    echo ''
    echo '>> ERROR: Tmp File Removal Failed! Please check your file or try again.'
    exit 1
  fi
}


# 定义主流程
function main() {
  # 先下载文件
  download_newfile_to_tmp "${NEW_FILE_LINK}" "${FILE_LOCAL_NAME}"

  # checksum

  # check install path
  check_install_path

  # 安装文件到固定位置（权限：755包含执行、644不包含执行）
  install_tmpfile "${FILE_PERMISSION}" "${FILE_LOCAL_NAME}" "$FILE_LOCAL_PATH"

  # 删除临时文件夹
  remove_tmpfile
}


# 执行主流程
main "$@"
