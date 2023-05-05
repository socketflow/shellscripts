#!/usr/bin/env bash
set -e


# ------------------------------------------------------------
# [VERSION] 20230505-dev1
# [TITLE] this is an updater script for some network utilities
# [title] 这是一个网络工具相关的升级脚本
# ------------------------------------------------------------


# ------------------------------------------------------------
## 1 GLOBAL VAR
# ------------------------------------------------------------

# operating system
OS_NAME="$(uname)"

# LOCAL DIR
LOCAL_BIN_DIR='/usr/local/bin'
LOCAL_ETC_DIR='/usr/local/etc'
LOCAL_SHARE_DIR='/usr/local/share'


# GITHUB REPO RELATED
GITHUB_USER=''
GITHUB_REPO=''
GITHUB_FILENAME=''


# ------------------------------------------------------------
# 2 定义一些 global function 和变量
# ------------------------------------------------------------


# 生成 latest release 链接
function generate_latest_release_links() {

  GITHUB_API="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases"

  GITHUB_RELEASE_VERSION=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == false)) | first | .tag_name")
  GITHUB_RELEASE_PUBLISHED_AT=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == false)) | first | .published_at")
  GITHUB_RELEASE_ASSET_DOWNLOAD_URL=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == false)) | .[0].assets | map(select(.name | test(\"$GITHUB_FILENAME\"))) | .[0].browser_download_url")
  GITHUB_RELEASE_ASSET_UPDATED_AT=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == false)) | .[0].assets | map(select(.name | test(\"$GITHUB_FILENAME\"))) | .[0].updated_at")

}

# 生成 pre-release 链接
function generate_pre_release_links() {

  GITHUB_API="https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases"

  GITHUB_RELEASE_VERSION=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == true)) | first | .tag_name")
  GITHUB_RELEASE_PUBLISHED_AT=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == true)) | first | .published_at")
  GITHUB_RELEASE_ASSET_DOWNLOAD_URL=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == true)) | .[0].assets | map(select(.name | test(\"$GITHUB_FILENAME\"))) | .[0].browser_download_url")
  GITHUB_RELEASE_ASSET_UPDATED_AT=$(curl -s "${GITHUB_API}" | jq -r "map(select(.prerelease == true)) | .[0].assets | map(select(.name | test(\"$GITHUB_FILENAME\"))) | .[0].updated_at")

}

# 生成 gitlab 链接
function generate_gitlab_release_links() {

  GITLAB_API="https://gitlab.com/api/v4/projects/${GITLAB_REPO_ID}/releases"

  GITLAB_RELEASE_VERSION=$(curl -s "${GITLAB_API}" | jq -r .[0].tag_name)
  GITLAB_RELEASE_RELEASED_AT=$(curl -s "${GITLAB_API}" | jq -r .[0].released_at)
  GITLAB_RELEASE_TAG_PATH=$(curl -s "${GITLAB_API}" | jq -r .[0].tag_path)
  GITLAB_RELEASE_ASSET_DOWNLOAD_URL=$(curl -s "${GITLAB_API}" | jq -r " .[0].assets.links | map(select(.name | test(\"$GITLAB_FILENAME\"))) | .[0].url" )
  # 简单hack一下下载地址，就不用修改main里面的变量名称了
  GITHUB_RELEASE_ASSET_DOWNLOAD_URL="${GITLAB_RELEASE_ASSET_DOWNLOAD_URL}"
}

# 用 API 获取日期
function format_github_date() {

  GITHUB_RELEASE_PUBLISHED_AT_FORMATTED=$(date ${DATE_ARGS_GITHUB} ${GITHUB_RELEASE_PUBLISHED_AT} +"%Y%m%d%H%M.%S")
  ASSET_DATE_FORMATTED=$(date ${DATE_ARGS_GITHUB} ${GITHUB_RELEASE_ASSET_UPDATED_AT} +"%Y%m%d%H%M.%S")

}

# 用 API 获取日期
function format_gitlab_date() {

  ASSET_DATE_FORMATTED=$(date ${DATE_ARGS_GITLAB} ${GITLAB_RELEASE_RELEASED_AT} +"%Y%m%d%H%M.%S")
  # 简单hack一下下载地址，就不用修改main里面的变量名称了
  GITHUB_RELEASE_ASSET_UPDATED_AT="${GITLAB_RELEASE_RELEASED_AT}"
}

# 根据操作系统选择 date 命令的参数
# for macOS:  `date -j -f %Y-%m-%dT%H:%M:%SZ`
# for debian: `date -d`
function select_os_date_args_github() {

  if [ "${OS_NAME}" = "Linux" ]; then
    DATE_ARGS_GITHUB="${1}"
  elif [ "${OS_NAME}" = "Darwin" ]; then
    DATE_ARGS_GITHUB="${2}"
  else
    DATE_ARGS_GITHUB='ERROR: UNKNOWN OPERATING SYSTEM'
  fi

}

# 根据操作系统选择 date 命令的参数
# for macOS:  `date -j -f %Y-%m-%dT%H:%M:%S`
# for debian: `date -d`
function select_os_date_args_gitlab() {

  if [ "${OS_NAME}" = "Linux" ]; then
    DATE_ARGS_GITLAB="${1}"
  elif [ "${OS_NAME}" = "Darwin" ]; then
    DATE_ARGS_GITLAB="${2}"
  else
    DATE_ARGS_GITLAB='ERROR: UNKNOWN OPERATING SYSTEM'
  fi

}

# 根据操作系统选择release里面不同的二进制
function select_os_filename() {

  if [ "${OS_NAME}" = "Linux" ]; then
    GITHUB_FILENAME="${1}"
  elif [ "${OS_NAME}" = "Darwin" ]; then
    GITHUB_FILENAME="${2}"
  else
    GITHUB_FILENAME='ERROR: UNKNOWN OPERATING SYSTEM'
  fi

}

# 用上面的function获取正确的 date 命令参数
DATE_ARGS_GITHUB=''
DATE_ARGS_GITHUB_LINUX="-d"
DATE_ARGS_GITHUB_DARWIN="-j -f "%Y-%m-%dT%H:%M:%SZ""
# 获取github相关的正确date格式
select_os_date_args_github "${DATE_ARGS_GITHUB_LINUX}" "${DATE_ARGS_GITHUB_DARWIN}"

DATE_ARGS_GITLAB=''
DATE_ARGS_GITLAB_LINUX="-d"
DATE_ARGS_GITLAB_DARWIN="-j -f "%Y-%m-%dT%H:%M:%S""
# 获取gitlab相关的正确date格式
select_os_date_args_gitlab "${DATE_ARGS_GITLAB_LINUX}" "${DATE_ARGS_GITLAB_DARWIN}"


# 根据输入选择，赋予不同的变量值

if   [ "${1}" = "geoip.dat"     ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_SHARE_DIR}/xray"
  FILE_LOCAL_NAME='geoip.dat'
  FILE_PERMISSION='644'

  # https://api.github.com/repos/soffchen/geoip/releases
  GITHUB_USER='soffchen'
  GITHUB_REPO='geoip'
  GITHUB_FILENAME='geoip.dat'

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date

elif [ "${1}" = "geosite.dat"   ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_SHARE_DIR}/xray"
  FILE_LOCAL_NAME='geosite.dat'
  FILE_PERMISSION='644'

  # https://api.github.com/repos/MetaCubeX/meta-rules-dat/releases
  GITHUB_USER='MetaCubeX'
  GITHUB_REPO='meta-rules-dat'
  GITHUB_FILENAME='geosite.dat'

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date

elif [ "${1}" = "geoip.db"      ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_SHARE_DIR}/sing-box"
  FILE_LOCAL_NAME='geoip.db'
  FILE_PERMISSION='644'

  # https://api.github.com/repos/soffchen/sing-geoip/releases
  GITHUB_USER='soffchen'
  GITHUB_REPO='sing-geoip'
  GITHUB_FILENAME='geoip.db'

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date

elif [ "${1}" = "geosite.db"    ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_SHARE_DIR}/sing-box"
  FILE_LOCAL_NAME='geosite.db'
  FILE_PERMISSION='644'

  # https://api.github.com/repos/MetaCubeX/meta-rules-dat/releases
  GITHUB_USER='MetaCubeX'
  GITHUB_REPO='meta-rules-dat'
  GITHUB_FILENAME='geosite.db'

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date

elif [ "${1}" = "geoip.mmdb"    ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_SHARE_DIR}/hysteria"
  FILE_LOCAL_NAME='geoip.mmdb'
  FILE_PERMISSION='644'

  # https://api.github.com/repos/Loyalsoldier/geoip/releases
  GITHUB_USER='Loyalsoldier'
  GITHUB_REPO='geoip'
  GITHUB_FILENAME='Country.mmdb'

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date

elif [ "${1}" = "xray"          ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'

  # https://api.github.com/repos/xtls/xray-core/releases
  GITHUB_USER='XTLS'
  GITHUB_REPO='Xray-core'
  GITHUB_FILENAME=''
  GITHUB_FILENAME_LINUX='Xray-linux-64.zip'
  GITHUB_FILENAME_DARWIN='Xray-macos-arm64-v8a.zip'

  # get binary link for target platform
  select_os_filename "${GITHUB_FILENAME_LINUX}" "${GITHUB_FILENAME_DARWIN}"

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date


elif [ "${1}" = "xray-beta"     ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='xray.zip'
  FILE_PERMISSION='755'

  # https://api.github.com/repos/xtls/xray-core/releases
  GITHUB_USER='XTLS'
  GITHUB_REPO='Xray-core'
  GITHUB_FILENAME=''
  GITHUB_FILENAME_LINUX='Xray-linux-64.zip'
  GITHUB_FILENAME_DARWIN='Xray-macos-arm64-v8a.zip'

  # get binary link for target platform
  select_os_filename "${GITHUB_FILENAME_LINUX}" "${GITHUB_FILENAME_DARWIN}"

  # 根据GitHub文件信息生成链接
  generate_pre_release_links

  # 格式化日期
  format_github_date


elif [ "${1}" = "sing-box"      ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'

  # https://api.github.com/repos/SagerNet/sing-box/releases
  GITHUB_USER='SagerNet'
  GITHUB_REPO='sing-box'
  GITHUB_FILENAME=''
  GITHUB_FILENAME_LINUX='linux-amd64.tar.gz'
  GITHUB_FILENAME_DARWIN='darwin-arm64.tar.gz'

  # get binary link for target platform
  select_os_filename "${GITHUB_FILENAME_LINUX}" "${GITHUB_FILENAME_DARWIN}"

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date


elif [ "${1}" = "sing-box-beta" ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='sing-box.tar.gz'
  FILE_PERMISSION='755'

  # https://api.github.com/repos/SagerNet/sing-box/releases
  GITHUB_USER='SagerNet'
  GITHUB_REPO='sing-box'
  GITHUB_FILENAME=''
  GITHUB_FILENAME_LINUX='linux-amd64.tar.gz'
  GITHUB_FILENAME_DARWIN='darwin-arm64.tar.gz'

  # get binary link for target platform
  select_os_filename "${GITHUB_FILENAME_LINUX}" "${GITHUB_FILENAME_DARWIN}"

  # 根据GitHub文件信息生成链接
  generate_pre_release_links

  # 格式化日期
  format_github_date


elif [ "${1}" = "hysteria"      ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='hysteria'
  FILE_PERMISSION='755'

  # https://api.github.com/repos/apernet/hysteria/releases
  GITHUB_USER='apernet'
  GITHUB_REPO='hysteria'
  GITHUB_FILENAME=''
  GITHUB_FILENAME_LINUX='linux-amd64'
  GITHUB_FILENAME_DARWIN='darwin-arm64'

  # get binary link for target platform
  select_os_filename "${GITHUB_FILENAME_LINUX}" "${GITHUB_FILENAME_DARWIN}"

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date


elif [ "${1}" = "tuic"          ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='tuic'
  FILE_PERMISSION='755'

  # https://api.github.com/repos/apernet/hysteria/releases
  GITHUB_USER='EAimTY'
  GITHUB_REPO='tuic'
  GITHUB_FILENAME=''
  GITHUB_FILENAME_LINUX='x86_64-linux-gnu'
  GITHUB_FILENAME_DARWIN='aarch64-macos'

  # get binary link for target platform
  select_os_filename "${GITHUB_FILENAME_LINUX}" "${GITHUB_FILENAME_DARWIN}"

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date

elif [ "${1}" = "wgcf"          ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='wgcf'
  FILE_PERMISSION='755'

  # https://api.github.com/repos/apernet/hysteria/releases
  GITHUB_USER='ViRb3'
  GITHUB_REPO='wgcf'
  GITHUB_FILENAME=''
  GITHUB_FILENAME_LINUX='linux_amd64'
  GITHUB_FILENAME_DARWIN='darwin_arm64'

  # get binary link for target platform
  select_os_filename "${GITHUB_FILENAME_LINUX}" "${GITHUB_FILENAME_DARWIN}"

  # 根据GitHub文件信息生成链接
  generate_latest_release_links

  # 格式化日期
  format_github_date

elif [ "${1}" = "warp-go"       ];  then

  # 本地文件信息
  FILE_LOCAL_PATH="${LOCAL_BIN_DIR}"
  FILE_LOCAL_NAME='warp-go.tar.gz'
  FILE_PERMISSION='755'

  # https://gitlab.com/api/v4/projects/38543271/releases
  GITLAB_USER='ProjectWARP'
  GITLAB_REPO='warp-go'
  GITLAB_REPO_ID='38543271'
  GITLAB_FILENAME='linux_amd64.tar.gz'

  # 根据GitHub文件信息生成链接
  generate_gitlab_release_links

  # 格式化日期
  format_gitlab_date

else
  FILE_LOCAL_PATH='ERROR'
  FILE_LOCAL_NAME='ERROR'
  FILE_PERMISSION='ERROR'
  GITHUB_USER='ERROR'
  GITHUB_REPO='ERROR'
  GITHUB_FILENAME='ERROR'
  return 1


fi

# ------------------------------------------------------------
## 3. FUNCTIONS
# ------------------------------------------------------------

# 3.1
function echo_job() {

  echo ''
  echo ">> \$OS_NAME is: $(uname)"
  echo ">> \$FILE_LOCAL_NAME is: ${FILE_LOCAL_NAME}"
  echo ">> \$FILE_LOCAL_PATH is: ${FILE_LOCAL_PATH}"
  echo ">> \$FILE_PERMISSION is: ${FILE_PERMISSION}"
  echo ''
  echo ">> \$GITHUB_API is: ${GITHUB_API}"
  echo ''
  echo ">> \$GITHUB_RELEASE_VERSION is: ${GITHUB_RELEASE_VERSION}"
  echo ">> \$GITHUB_RELEASE_PUBLISHED_AT is: ${GITHUB_RELEASE_PUBLISHED_AT}"
  echo ">> \$GITHUB_RELEASE_PUBLISHED_AT_FORMATTED is: ${GITHUB_RELEASE_PUBLISHED_AT_FORMATTED}"
  echo ">> \$GITHUB_RELEASE_ASSET_DOWNLOAD_URL is: ${GITHUB_RELEASE_ASSET_DOWNLOAD_URL}"
  echo ">> \$GITHUB_RELEASE_ASSET_UPDATED_AT is: ${GITHUB_RELEASE_ASSET_UPDATED_AT}"
  echo ''
  echo ">> \$GITLAB_RELEASE_VERSION is: ${GITLAB_RELEASE_VERSION}"
  echo ">> \$GITLAB_RELEASE_RELEASED_AT is: ${GITLAB_RELEASE_RELEASED_AT}"
  echo ">> \$GITLAB_RELEASE_TAG_PATH is: ${GITLAB_RELEASE_TAG_PATH}"
  echo ">> \$GITLAB_RELEASE_ASSET_DOWNLOAD_URL is: ${GITLAB_RELEASE_ASSET_DOWNLOAD_URL}"
  echo ''
  echo ">> \$ASSET_DATE_FORMATTED is: ${ASSET_DATE_FORMATTED}"
  echo ''

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

# ----------- to-do
# 3.4 下载checksum，一直不会写
# function fun download_checksum_to_tmp() {
#   some code here
# }

# 3.5 验证checksum，一直不会写
# function fun checksum() {
#   some code here
# }
# ---------- to-do

# 3.6 处理压缩文件
# 如果下载的xray的zip文件，就需要先解压出binary文件（其他文件没用）
function uncompress_tmpfile() {

  if [ -f ${TMP_DIR}/xray.zip ]; then
    echo ''
    echo ">> xray.zip file is found in ${TMP_DIR}"
    # https://unix.stackexchange.com/questions/14120/extract-only-a-specific-file-from-a-zipped-archive-to-a-given-directory
    unzip -j "${TMP_DIR}/xray.zip" "xray" -d "${TMP_DIR}"
    echo ''
    echo ">> zip file extracted"
    FILE_LOCAL_NAME='xray'
    echo ''
    echo ">> FILE_LOCAL_NAME changed to ${FILE_LOCAL_NAME}"

  elif [ -f ${TMP_DIR}/sing-box.tar.gz ]; then
    echo ''
    echo ">> sing-box.tar.gz file is found in ${TMP_DIR}"
    tar -xzf "${TMP_DIR}/sing-box.tar.gz" --strip-components=1 -C "${TMP_DIR}"
    echo ''
    echo ">> tar.gz file extracted"
    FILE_LOCAL_NAME='sing-box'
    echo ''
    echo ">> FILE_LOCAL_NAME changed to ${FILE_LOCAL_NAME}"

  elif [ -f ${TMP_DIR}/warp-go.tar.gz ]; then
    echo ''
    echo ">> warp-go.tar.gz file is found in ${TMP_DIR}"
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
function rectify_file_date() {
  touch -t "${1}" "${2}"
  echo ''
  echo ">> ${FILE_LOCAL_NAME}'s date has been changed to ${GITHUB_RELEASE_ASSET_UPDATED_AT}"
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


# ------------------------------------------------------------
## 4. 主流程
# ------------------------------------------------------------

# 4.1 定义主流程
function main() {
  echo_job
  make_tmpdir
  download_target_to_tmpdir "${GITHUB_RELEASE_ASSET_DOWNLOAD_URL}" "${FILE_LOCAL_NAME}"
  # checksum
  uncompress_tmpfile
  check_install_path
  install_tmpfile "${FILE_PERMISSION}" "${FILE_LOCAL_NAME}" "${FILE_LOCAL_PATH}"
  rectify_file_date "${ASSET_DATE_FORMATTED}" "${FILE_LOCAL_PATH}/${FILE_LOCAL_NAME}"  
  cleanup_tmpfile
}

# 4.2 执行主流程
main "$@"
