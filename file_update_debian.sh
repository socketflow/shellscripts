#!/usr/bin/env bash
set -e

# [version] 20220224.2

# [title] this is a generic file updater script
# [title] 这是一个通用性的文件更新脚本
# [reference] 变量用 {} 的解释：https://stackoverflow.com/questions/8748831/when-do-we-need-curly-braces-around-shell-variables


# [variable] 定义一些要用到的变量

if [ "${1}" = "geoip" ]; then
  FILE_LOCAL_NAME='geoip.dat'
  FILE_LOCAL_PATH="/usr/local/share/xray"
  FILE_PERMISSION='644'
  NEW_FILE_LINK='https://raw.githubusercontent.com/Loyalsoldier/geoip/release/geoip-only-cn-private.dat'
elif [ "${1}" = "geosite" ]; then
  FILE_LOCAL_NAME='geosite.dat'
  FILE_LOCAL_PATH="/usr/local/share/xray"
  FILE_PERMISSION='644'
  NEW_FILE_LINK='https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geosite.dat'
elif [ "${1}" = "mmdb" ]; then
  FILE_LOCAL_NAME='loyalsoldier.mmdb'
  FILE_LOCAL_PATH="/usr/local/etc/hysteria"
  FILE_PERMISSION='644'
  NEW_FILE_LINK='https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country-only-cn-private.mmdb'
elif [ "${1}" = "hysteria" ]; then
  FILE_LOCAL_NAME='hysteria'
  FILE_LOCAL_PATH="/usr/local/bin"
  FILE_PERMISSION='755'
  NEW_FILE_LINK='https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64'
elif [ "${1}" = "xray" ]; then
  FILE_LOCAL_NAME='xray.zip'
  FILE_LOCAL_PATH="/usr/local/bin"
  FILE_PERMISSION='755'
  NEW_FILE_LINK='https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip'
elif [ "${1}" = "xray-version" ]; then
  VERSION=v"${2}"
  FILE_LOCAL_NAME='xray.zip'
  FILE_LOCAL_PATH="/usr/local/bin"
  FILE_PERMISSION='755'
  NEW_FILE_LINK="https://github.com/XTLS/Xray-core/releases/download/${VERSION}/Xray-linux-64.zip"
else
  FILE_LOCAL_NAME='error'
  FILE_LOCAL_PATH="error"
  FILE_PERMISSION='error'
  NEW_FILE_LINK='error'
fi

echo ''
echo ">> \$FILE_LOCAL_NAME is ${FILE_LOCAL_NAME}"
echo ">> \$FILE_LOCAL_PATH is ${FILE_LOCAL_PATH}"
echo ">> \$FILE_PERMISSION is ${FILE_PERMISSION}"
echo ">> \$NEW_FILE_LINK is ${NEW_FILE_LINK}"


# 创建一个临时文件夹，如果创建失败则退出
function tmpdir() {
  TMP_DIR=$(mktemp -d) || exit 1
  echo ''
  echo ">> temp dir created here: ${TMP_DIR}"
  echo ''
}

# $1 是新版本的远程下载地址， $2 是本地文件名
function download_newfile_as_tmpfile() {
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

# 如果下载的xray的zip文件，就需要先解压出binary文件（其他文件没用）
function unzip_xray_zip_in_tmpfile() {
  if [ -f ${TMP_DIR}/xray.zip ]; then
    echo ''
    echo ">> Zip file is found in ${TMP_DIR}"
    # https://unix.stackexchange.com/questions/14120/extract-only-a-specific-file-from-a-zipped-archive-to-a-given-directory
    unzip -j "${TMP_DIR}/xray.zip" "xray" -d "${TMP_DIR}"
    echo ''
    echo ">> zip file extracted"
    FILE_LOCAL_NAME='xray'
    echo []
    echo ">> FILE_LOCAL_NAME changed to ${FILE_LOCAL_NAME}"
  else
    echo ''
    echo ">> No zip file found. Continue to installation."
  fi
}

function check_install_path() {
  if [ -d "${FILE_LOCAL_PATH}" ]; then
    echo ''
    echo ">> File direcctory already exists: ${FILE_LOCAL_PATH}. Continue to installation."
  else
    mkdir -p "${FILE_LOCAL_PATH}"
    echo ''
    echo ">> File directory not found... Created: ${FILE_LOCAL_PATH}"
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
function cleanup_tmpfile() {
  if rm -r -f "${TMP_DIR}"; then
    echo ''
    echo ">> ${TMP_DIR} and its contents has been cleaned up."
  else
    echo ''
    echo '>> ERROR: Tmp File Removal Failed! Please check your file or try again.'
    exit 1
  fi
}


# 定义主流程
function main() {
  # 创建临时文件夹
  tmpdir
  
  # 先下载文件
  download_newfile_as_tmpfile "${NEW_FILE_LINK}" "${FILE_LOCAL_NAME}"

  # checksum

  # unzip xray, 如果下载的是其他文件则跳过
  unzip_xray_zip_in_tmpfile

  # check install path
  check_install_path

  # 安装文件到固定位置（权限：755包含执行、644不包含执行）
  install_tmpfile "${FILE_PERMISSION}" "${FILE_LOCAL_NAME}" "$FILE_LOCAL_PATH"

  # 删除临时文件夹
  cleanup_tmpfile
}


# 执行主流程
main "$@"
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
