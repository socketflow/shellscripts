#!/usr/bin/env bash
set -e

# [version] 20230404

# [title] this is a generic file updater script
# [title] 这是一个通用性的文件更新脚本
# [reference] 变量用 {} 的解释：https://stackoverflow.com/questions/8748831/when-do-we-need-curly-braces-around-shell-variables


# 1 [variable] 定义一些要用到的变量

# geoip.dat, for xray, for linux, from loyalsoldier | soffchen
# soffchen的 cn ipv4 源换成了 [chnroutes2](https://github.com/misakaio/chnroutes2)
if [ "${1}" = "geoip" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='geoip.dat'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/share/xray"
  # NEW_FILE_LINK='https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat'
  NEW_FILE_LINK='https://github.com/soffchen/geoip/releases/latest/download/geoip.dat'

# geoip.dat, for xray, for macos, from loyalsoldier | soffchen
# soffchen的 cn ipv4 源换成了 [chnroutes2](https://github.com/misakaio/chnroutes2)
elif [ "${1}" = "geoip" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='geoip.dat'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/etc/xray/share"
  # NEW_FILE_LINK='https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat'
  NEW_FILE_LINK='https://github.com/soffchen/geoip/releases/latest/download/geoip.dat'

# geosite.dat, for xray, for linux, from loyalsoldier | MetaCubeX
# MetaCubeX 的 geosite:cn 源换成了 [ChinaMax_Domain](https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash/ChinaMax)
elif [ "${1}" = "geosite" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='geosite.dat'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/share/xray"
  # NEW_FILE_LINK='https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat'
  NEW_FILE_LINK='https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.dat'

# geosite.dat, for xray, for macos, from loyalsoldier | MetaCubeX
# MetaCubeX 的 geosite:cn 源换成了 [ChinaMax_Domain](https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash/ChinaMax)
elif [ "${1}" = "geosite" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='geosite.dat'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/etc/xray/share"
  # NEW_FILE_LINK='https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat'
  NEW_FILE_LINK='https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.dat'

# geoip.db, for sing-box, for linux, from soffchen
# soffchen的 cn ipv4 源换成了 [chnroutes2](https://github.com/misakaio/chnroutes2)
elif [ "${1}" = "geoipdb" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='geoip.db'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/share/sing-box"
  NEW_FILE_LINK='https://github.com/soffchen/sing-geoip/releases/latest/download/geoip-cn.db'

# geoip.db, for sing-box, for macos, from soffchen
# soffchen的 cn ipv4 源换成了 [chnroutes2](https://github.com/misakaio/chnroutes2)
elif [ "${1}" = "geoipdb" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='geoip.db'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/etc/sing-box/share"
  NEW_FILE_LINK='https://github.com/soffchen/sing-geoip/releases/latest/download/geoip-cn.db'

# geosite.db, for sing-box, for linux, from soffchen | MetaCubeX
# MetaCubeX 的 geosite:cn 源换成了 [ChinaMax_Domain](https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash/ChinaMax)
elif [ "${1}" = "geositedb" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='geosite.db'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/share/sing-box"
  # NEW_FILE_LINK='https://github.com/soffchen/sing-geosite/releases/latest/download/geosite.db'
  NEW_FILE_LINK='https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.db'

# geosite.db, for sing-box, for macos, from soffchen | MetaCubeX
# MetaCubeX 的 geosite:cn 源换成了 [ChinaMax_Domain](https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash/ChinaMax)
elif [ "${1}" = "geositedb" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='geosite.db'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/etc/sing-box/share"
  # NEW_FILE_LINK='https://github.com/soffchen/sing-geosite/releases/latest/download/geosite.db'
  NEW_FILE_LINK='https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.db'

# geoip in mmdb format, for hysteria, for linux, from loyalsoldier
elif [ "${1}" = "mmdb" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='loyalsoldier.mmdb'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/share/hysteria"
  NEW_FILE_LINK='https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb'

# geoip in mmdb format, for hysteria, for macos, from loyalsoldier
elif [ "${1}" = "mmdb" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='loyalsoldier.mmdb'
  FILE_PERMISSION='644'
  FILE_LOCAL_PATH="/usr/local/etc/hysteria/share"
  NEW_FILE_LINK='https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb'

# hysteria binary, linux, amd64
elif [ "${1}" = "hysteria" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='hysteria'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK='https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64'

# hysteria binary, macos, arm64 (apple silicon) 
elif [ "${1}" = "hysteria" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='hysteria'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK='https://github.com/apernet/hysteria/releases/latest/download/hysteria-darwin-arm64'

# xray-core binary, latest release, linux, amd64
elif [ "${1}" = "xray" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK='https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip'

# xray-core binary, latest release, macos, arm64 (apple silicon) 
elif [ "${1}" = "xray" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK='https://github.com/XTLS/Xray-core/releases/latest/download/Xray-macos-arm64-v8a.zip'

# xray-core binary, user specified release, linux, amd64
elif [ "${1}" = "xray-version" ] && [ "$(uname)" = "Linux" ]; then
  VERSION=v"${2}"
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK="https://github.com/XTLS/Xray-core/releases/download/${VERSION}/Xray-linux-64.zip"

# xray-core binary, user specified release, macos, arm64 (apple silicon) 
elif [ "${1}" = "xray-version" ] && [ "$(uname)" = "Darwin" ]; then
  VERSION=v"${2}"
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK="https://github.com/XTLS/Xray-core/releases/download/${VERSION}/Xray-macos-arm64-v8a.zip"

# tuic binary, latest release, for linux *SERVER*, x86_64
elif [ "${1}" = "tuic" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='tuic'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  VERSION_API=$(curl -s https://api.github.com/repos/EAimTY/tuic/releases/latest | jq -r '.tag_name')
  VERSION=$(echo $VERSION_API | sed 's/v//g')
  NEW_FILE_LINK="https://github.com/EAimTY/tuic/releases/latest/download/tuic-server-${VERSION}-x86_64-linux-gnu"

# tuic binary, latest release, for macos *CLIENT*, arm64 (apple silicon) 
elif [ "${1}" = "tuic" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='tuic'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  VERSION_API=$(curl -s https://api.github.com/repos/EAimTY/tuic/releases/latest | jq -r '.tag_name')
  VERSION=$(echo $VERSION_API | sed 's/v//g')
  NEW_FILE_LINK="https://github.com/EAimTY/tuic/releases/latest/download/tuic-client-${VERSION}-aarch64-macos"

# sing-box binary, latest release, linux, amd64
elif [ "${1}" = "sing-box" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  VERSION_API=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases/latest | jq -r '.tag_name')
  VERSION=$(echo $VERSION_API | sed 's/v//g')
  NEW_FILE_LINK="https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-${VERSION}-linux-amd64.tar.gz"

# sing-box binary, latest release, macos, arm64 (apple silicon) 
elif [ "${1}" = "sing-box" ] && [ "$(uname)" = "Darwin" ]; then
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  VERSION_API=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases/latest | jq -r '.tag_name')
  VERSION=$(echo $VERSION_API | sed 's/v//g')
  NEW_FILE_LINK="https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-${VERSION}-darwin-arm64.tar.gz"

# sing-box binary, user specified release, linux, amd64
elif [ "${1}" = "sing-box-version" ] && [ "$(uname)" = "Linux" ]; then
  VERSION="${2}"
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK="https://github.com/SagerNet/sing-box/releases/download/v${VERSION}/sing-box-${VERSION}-linux-amd64.tar.gz"

# sing-box binary, user specified release, macos, arm64 (apple silicon) 
elif [ "${1}" = "sing-box-version" ] && [ "$(uname)" = "Darwin" ]; then
  VERSION="${2}"
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  NEW_FILE_LINK="https://github.com/SagerNet/sing-box/releases/download/v${VERSION}/sing-box-${VERSION}-darwin-arm64.tar.gz"

# warp-go binary, latest release, linux, amd64
elif [ "${1}" = "warp-go" ] && [ "$(uname)" = "Linux" ]; then
  FILE_LOCAL_NAME='warp-go.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"
  VERSION=$(curl -s https://gitlab.com/api/v4/projects/38543271/releases/ | jq '.[]' | jq -r '.name' | head -1)
  BIN_VERSION=${VERSION:1}
  NEW_FILE_LINK="https://gitlab.com/ProjectWARP/warp-go/-/releases/${VERSION}/downloads/warp-go_${BIN_VERSION}_linux_amd64.tar.gz"

else
  FILE_LOCAL_NAME='ERROR'
  FILE_PERMISSION='ERROR'
  FILE_LOCAL_PATH="ERROR"
  NEW_FILE_LINK='ERROR'

fi

function echo_job() {
  echo ''
  echo ">> \$OS_TYPE is $(uname)"
  echo ">> \$FILE_LOCAL_NAME is ${FILE_LOCAL_NAME}"
  echo ">> \$FILE_LOCAL_PATH is ${FILE_LOCAL_PATH}"
  echo ">> \$FILE_PERMISSION is ${FILE_PERMISSION}"
  echo ">> \$NEW_FILE_LINK is ${NEW_FILE_LINK}"
}

# 创建一个临时文件夹，如果创建失败则退出
function make_tmpdir() {
  TMP_DIR=$(mktemp -d) || exit 1
  echo ''
  echo ">> temp dir created here: ${TMP_DIR}"
  echo ''
}

# $1 是新版本的远程下载地址， $2 是本地文件名
function download_target_to_tmpdir() {
  if curl ${CURL_PROXY} -L "${1}" -o "${TMP_DIR}/${2}"; then
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
function uncompress_tmpfile() {
  if [ -f ${TMP_DIR}/xray.zip ]; then
    echo ''
    echo ">> Zip file is found in ${TMP_DIR}"
    # https://unix.stackexchange.com/questions/14120/extract-only-a-specific-file-from-a-zipped-archive-to-a-given-directory
    unzip -j "${TMP_DIR}/xray.zip" "xray" -d "${TMP_DIR}"
    echo ''
    echo ">> zip file extracted"
    FILE_LOCAL_NAME='xray'
    echo ''
    echo ">> FILE_LOCAL_NAME changed to ${FILE_LOCAL_NAME}"
  elif [ -f ${TMP_DIR}/sing-box.tar.gz ]; then
    echo ''
    echo ">> tar.gz file is found in ${TMP_DIR}"
    tar -xzf "${TMP_DIR}/sing-box.tar.gz" --strip-components=1 -C "${TMP_DIR}"
    echo ''
    echo ">> tar.gz file extracted"
    FILE_LOCAL_NAME='sing-box'
    echo ''
    echo ">> FILE_LOCAL_NAME changed to ${FILE_LOCAL_NAME}"
  elif [ -f ${TMP_DIR}/warp-go.tar.gz ]; then
    echo ''
    echo ">> tar.gz file is found in ${TMP_DIR}"
    tar -xzf "${TMP_DIR}/warp-go.tar.gz" --strip-components=1 -C "${TMP_DIR}"
    echo ''
    echo ">> tar.gz file extracted"
    FILE_LOCAL_NAME='warp-go'
    echo ''
    echo ">> FILE_LOCAL_NAME changed to ${FILE_LOCAL_NAME}"
  else
    echo ''
    echo ">> No compressed file found. Continue to installation."
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
  echo_job
  make_tmpdir
  download_target_to_tmpdir "${NEW_FILE_LINK}" "${FILE_LOCAL_NAME}"
  # checksum
  uncompress_tmpfile
  check_install_path
  install_tmpfile "${FILE_PERMISSION}" "${FILE_LOCAL_NAME}" "$FILE_LOCAL_PATH"
  cleanup_tmpfile
}


# 执行主流程
main "$@"
