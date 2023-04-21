#!/usr/bin/env bash
set -e

# [version] 20230422 (build.20230422-dev2)

# [title] this is a generic file updater script
# [title] 这是一个通用性的文件更新脚本
# [reference] 变量用 {} 的解释：https://stackoverflow.com/questions/8748831/when-do-we-need-curly-braces-around-shell-variables


# 重复的获取、应该写成一个公式
# function get_latest_metadata () {
#   # latest release 的 API 获取链接
#   ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
#   ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.published_at')
#   ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")
# }


## 1 ROUTING FILE DOWNLOAD LINK

# 1.1 [geoip.dat]
# for xray, from loyalsoldier | soffchen
# soffchen的 cn ipv4 源换成了 [chnroutes2](https://github.com/misakaio/chnroutes2)
if [ "${1}" = "geoip" ]; then
  FILE_LOCAL_PATH='/usr/local/share/xray'
  FILE_LOCAL_NAME='geoip.dat'
  FILE_PERMISSION='644'

  # NEW_FILE_LINK='https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat'
  # NEW_FILE_LINK='https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/release/geoip.dat'
  # NEW_FILE_LINK='https://github.com/soffchen/geoip/releases/latest/download/geoip.dat'
  GITHUB_USER='soffchen'
  GITHUB_REPO='geoip'
  GITHUB_FILE='geoip.dat'
  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.assets[0].updated_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


# 1.2 [geosite.dat]
# for xray, from loyalsoldier | MetaCubeX
# MetaCubeX 的 geosite:cn 源换成了 [ChinaMax_Domain](https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash/ChinaMax)
elif [ "${1}" = "geosite" ]; then
  FILE_LOCAL_PATH='/usr/local/share/xray'
  FILE_LOCAL_NAME='geosite.dat'
  FILE_PERMISSION='644'

  # NEW_FILE_LINK='https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat'
  # NEW_FILE_LINK='https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/release/geosite.dat'
  # NEW_FILE_LINK='https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.dat'
  GITHUB_USER='MetaCubeX'
  GITHUB_REPO='meta-rules-dat'
  GITHUB_FILE='geosite.dat'
  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.assets[0].updated_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


# 1.3 [geoip.db]
# for sing-box, from soffchen
# soffchen的 cn ipv4 源换成了 [chnroutes2](https://github.com/misakaio/chnroutes2)
elif [ "${1}" = "geoip-db" ]; then
  FILE_LOCAL_PATH='/usr/local/share/sing-box'
  FILE_LOCAL_NAME='geoip.db'
  FILE_PERMISSION='644'

  # NEW_FILE_LINK='https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/release/geoip.db'
  # NEW_FILE_LINK='https://github.com/soffchen/sing-geoip/releases/latest/download/geoip.db'
  GITHUB_USER='soffchen'
  GITHUB_REPO='sing-geoip'
  GITHUB_FILE='geoip.db'
  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.assets[0].updated_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


# 1.4 [geosite.db]
# for sing-box, from soffchen | MetaCubeX
# MetaCubeX 的 geosite:cn 源换成了 [ChinaMax_Domain](https://github.com/blackmatrix7/ios_rule_script/tree/master/rule/Clash/ChinaMax)
elif [ "${1}" = "geosite-db" ]; then
  FILE_LOCAL_PATH='/usr/local/share/sing-box'
  FILE_LOCAL_NAME='geosite.db'
  FILE_PERMISSION='644'

  # NEW_FILE_LINK='https://github.com/soffchen/sing-geosite/releases/latest/download/geosite.db'
  # NEW_FILE_LINK='https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/release/geosite.db'
  # NEW_FILE_LINK='https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.db'
  GITHUB_USER='MetaCubeX'
  GITHUB_REPO='meta-rules-dat'
  GITHUB_FILE='geosite.db'
  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.assets[0].updated_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


# 1.5 [mmdb]
# for hysteria, from loyalsoldier
elif [ "${1}" = "mmdb" ]; then
  FILE_LOCAL_PATH='/usr/local/share/hysteria'
  FILE_LOCAL_NAME='loyalsoldier.mmdb'
  FILE_PERMISSION='644'

  # NEW_FILE_LINK='https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb'
  GITHUB_USER='Loyalsoldier'
  GITHUB_REPO='geoip'
  GITHUB_FILE='Country.mmdb'
  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.assets[0].updated_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


## 2 BINARY DOWNLOAD LINK

# 2.1 [xray]
# xray-core binary, latest release
elif [ "${1}" = "xray" ]; then
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"

  GITHUB_USER='XTLS'
  GITHUB_REPO='Xray-core'

  # get binary link for target platform
  OS_NAME="$(uname)"
  if [ "${OS_NAME}" = "Linux" ]; then
    GITHUB_FILE='Xray-linux-64.zip'
  elif [ "${OS_NAME}" = "Darwin" ]; then
    GITHUB_FILE='Xray-macos-arm64-v8a.zip'
  else
    GITHUB_FILE='Unknown-OS'
    exit
  fi

  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.published_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")



# 2.2 [xray-version]
# xray-core binary, user specified release
elif [ "${1}" = "xray-version" ]; then
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"

  GITHUB_VERSION="${2}"

  GITHUB_USER='XTLS'
  GITHUB_REPO='Xray-core'

  # get binary link for target platform
  OS_NAME="$(uname)"
  if [ "${OS_NAME}" = "Linux" ]; then
    GITHUB_FILE='Xray-linux-64.zip'
  elif [ "${OS_NAME}" = "Darwin" ]; then
    GITHUB_FILE='Xray-macos-arm64-v8a.zip'
  else
    GITHUB_FILE='Unknown-OS'
    exit
  fi

  # 因为Xray的release中不包含版本号，所以不需要用API，直接用latest的固定下载链接就可以
  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/download/v${GITHUB_VERSION}/${GITHUB_FILE}"

  # 指定tag的API获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/tags/v${GITHUB_VERSION}"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.published_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")



# 2.3 [sing-box]
# sing-box binary, latest stable release
elif [ "${1}" = "sing-box" ]; then
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"

  GITHUB_USER='SagerNet'
  GITHUB_REPO='sing-box'

  # 因为sing-box的release中包含版本号，所以需要用API来生成动态的下载链接
  GITHUB_VERSION_API=$(curl -s https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest | jq -r '.tag_name')
  GITHUB_VERSION=$(echo $GITHUB_VERSION_API | sed 's/v//g')

  OS_NAME="$(uname)"
  if [ "${OS_NAME}" = "Linux" ]; then
    GITHUB_FILE="sing-box-${GITHUB_VERSION}-linux-amd64.tar.gz"
  elif [ "${OS_NAME}" = "Darwin" ]; then
    GITHUB_FILE="sing-box-${GITHUB_VERSION}-darwin-arm64.tar.gz"
  else
    GITHUB_FILE='Unknown-OS'
    exit
  fi

  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/download/v${GITHUB_VERSION}/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.published_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


# 2.4 [sing-box]
# sing-box binary, user specified release
elif [ "${1}" = "sing-box-version" ]; then
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"

  GITHUB_USER='SagerNet'
  GITHUB_REPO='sing-box'

  GITHUB_VERSION="${2}"

  OS_NAME="$(uname)"
  if [ "${OS_NAME}" = "Linux" ]; then
    GITHUB_FILE="sing-box-${GITHUB_VERSION}-linux-amd64.tar.gz"
  elif [ "${OS_NAME}" = "Darwin" ]; then
    GITHUB_FILE="sing-box-${GITHUB_VERSION}-darwin-arm64.tar.gz"
  else
    GITHUB_FILE='Unknown-OS'
    exit
  fi

  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/download/v${GITHUB_VERSION}/${GITHUB_FILE}"

  # 指定tag的API获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/tags/v${GITHUB_VERSION}"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.published_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


# 2.5 [warp-go]
# warp-go binary, latest release, linux, amd64
elif [ "${1}" = "warp-go" ]; then
  FILE_LOCAL_NAME='warp-go.tar.gz'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"

  GITLAB_USER='ProjectWARP'
  GITLAB_REPO='warp-go'
  GITLAB_REPO_ID='38543271'

  ORIGINAL_METADATA="https://gitlab.com/api/v4/projects/${GITLAB_REPO_ID}/releases"

  ORIGINAL_METADATA_VERSION=$(curl -s ${ORIGINAL_METADATA} | jq '.[]' | jq -r '.name' | head -1)
  GITLAB_VERSION=${ORIGINAL_METADATA_VERSION:1}

  NEW_FILE_LINK="https://gitlab.com/${GITLAB_USER}/${GITLAB_REPO}/-/releases/${GITLAB_VERSION}/downloads/warp-go_${GITLAB_VERSION}_linux_amd64.tar.gz"

  ORIGINAL_METADATA_RELEASE_DATE=$(curl -s ${ORIGINAL_METADATA} | jq '.[]' | jq -r '.released_at' | head -1)
  ORIGINAL_METADATA_RELEASE_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${ORIGINAL_METADATA_RELEASE_DATE}" +"%Y%m%d%H%M.%S")


# 2.6 [hysteria]
# hysteria binary, latest release
elif [ "${1}" = "hysteria" ]; then
  FILE_LOCAL_NAME='hysteria'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"

  GITHUB_USER='apernet'
  GITHUB_REPO='hysteria'

  OS_NAME="$(uname)"
  if [ "${OS_NAME}" = "Linux" ]; then
    GITHUB_FILE='hysteria-linux-amd64'
  elif [ "${OS_NAME}" = "Darwin" ]; then
    GITHUB_FILE='hysteria-darwin-arm64'
  else
    GITHUB_FILE='Unknown-OS'
    exit
  fi

  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.published_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


# 2.7 [tuic]
# tuic binary, latest release
elif [ "${1}" = "tuic" ]; then
  FILE_LOCAL_NAME='tuic'
  FILE_PERMISSION='755'
  FILE_LOCAL_PATH="/usr/local/bin"

  GITHUB_USER='EAimTY'
  GITHUB_REPO='tuic'

  GITHUB_VERSION_API=$(curl -s https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest | jq -r '.tag_name')
  GITHUB_VERSION=$(echo $GITHUB_VERSION_API | sed 's/v//g')

  OS_NAME="$(uname)"
  if [ "${OS_NAME}" = "Linux" ]; then
    GITHUB_FILE="tuic-server-${GITHUB_VERSION}-x86_64-linux-gnu"
  elif [ "${OS_NAME}" = "Darwin" ]; then
    GITHUB_FILE="tuic-client-${GITHUB_VERSION}-aarch64-macos"
  else
    GITHUB_FILE='Unknown-OS'
    exit
  fi

  NEW_FILE_LINK="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/latest/download/${GITHUB_FILE}"

  # latest release 的 API 获取链接
  ORIGINAL_METADATA="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/latest"
  ORIGINAL_METADATA_PUBLISH_DATE=$(curl -s ${ORIGINAL_METADATA} | jq -r '.published_at')
  ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ORIGINAL_METADATA_PUBLISH_DATE}" +"%Y%m%d%H%M.%S")


else
  FILE_LOCAL_NAME='ERROR'
  FILE_PERMISSION='ERROR'
  FILE_LOCAL_PATH="ERROR"
  NEW_FILE_LINK='ERROR'

fi


## 3. FUNCTIONS

# 3.1
function echo_job() {
  echo ''
  echo ">> \$OS_NAME is: $(uname)"
  echo ">> \$FILE_LOCAL_NAME is: ${FILE_LOCAL_NAME}"
  echo ">> \$FILE_LOCAL_PATH is: ${FILE_LOCAL_PATH}"
  echo ">> \$FILE_PERMISSION is: ${FILE_PERMISSION}"
  echo ">> \$NEW_FILE_LINK is: ${NEW_FILE_LINK}"
  echo ">> \$ORIGINAL_METADATA is: ${ORIGINAL_METADATA}"
  echo ">> \$ORIGINAL_METADATA_PUBLISH_DATE is: ${ORIGINAL_METADATA_PUBLISH_DATE}"
}


# 3.2 创建一个临时文件夹，如果创建失败则退出
function make_tmpdir() {
  TMP_DIR=$(mktemp -d) || exit 1
  echo ''
  echo ">> temp dir created here: ${TMP_DIR}"
  echo ''
}

# 3.3 下载操作
# $1 是新版本的远程下载地址， $2 是本地文件名
function download_target_to_tmpdir() {
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


# 3.4 下载checksum，一直不会写
# function fun download_checksum_to_tmp() {
#   some code here
# }


# 3.5 验证checksum，一直不会写
# function fun checksum() {
#   some code here
# }


# 3.6 处理压缩文件
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
    tar -xzf "${TMP_DIR}/warp-go.tar.gz" -C "${TMP_DIR}"
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


# 3.7 检查路径，没有的话就创建文件夹
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


# 3.8 安装下载、解压好的文件
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


# 3.9 修改文件日期，从下载到mac上的日期，修改成GitHub release的日期
# $1是从API获取的release日期，$2是要修改日期的本地文件
function real_publish_date() {
  touch -t "${1}" "${2}"
  echo ''
  echo ">> ${FILE_LOCAL_NAME}'s date has been changed to ${ORIGINAL_METADATA_PUBLISH_DATE}"
}


# 3.10 清理临时文件夹
# $1是脚本创建的临时文件夹地址
function cleanup_tmpfile() {
  if rm -r -f "${TMP_DIR}"; then
    echo ''
    echo ">> ${TMP_DIR} and its contents has been cleaned up."
    echo ''
  else
    echo ''
    echo '>> ERROR: Tmp File Removal Failed! Please check your file or try again.'
    echo ''
    exit 1
  fi
}



## 4. 主流程

# 4.1 定义主流程
function main() {
  echo_job
  make_tmpdir
  download_target_to_tmpdir "${NEW_FILE_LINK}" "${FILE_LOCAL_NAME}"
  # checksum
  uncompress_tmpfile
  check_install_path
  install_tmpfile "${FILE_PERMISSION}" "${FILE_LOCAL_NAME}" "${FILE_LOCAL_PATH}"
  real_publish_date "${ORIGINAL_METADATA_PUBLISH_DATE_FORMATTED}" "${FILE_LOCAL_PATH}/${FILE_LOCAL_NAME}"  
  cleanup_tmpfile
}


# 4.2 执行主流程
main "$@"
