这个仓库存放一些我常用的 shell script.

### 1. file_update.sh
一个简单的拉取github更新的脚本

file_update.sh's To-Do List:
- [x] 支持常用github仓库
- [x] 支持gitlab（尝试）
- [x] 使用GitHub API来准确获取版本、获取下载链接、获取发布日期
- [ ] 因为依赖jq，所以应检查是否安装jq，没有的话则提示安装
- [x] 将下载的文件日期改为GitHub发布日期
- [ ] 对下载的文件进行checksum检查

### 2. generate_blacklist.sh
简单的从sing-box的日志文件里，拉取一些奇怪的访问IP，去重并排序。（以便用nftables屏蔽）

### 3. load_blacklist.sh
把 generate_blacklist.sh 生成的IP列表，动态加载到nftables的拦截规则中去
