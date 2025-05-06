#!/bin/bash

# 遇到错误时退出
set -e

# 第5步：更新和升级系统软件包
echo "正在更新和升级系统软件包..."
sudo apt update && sudo apt upgrade -y

# 第6步：安装 soundness-layer
echo "正在安装 soundness-layer..."
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# 第7步：安装 Rust
echo "正在安装 Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 第8步：加载 bashrc 并安装 soundnessup
echo "正在加载 ~/.bashrc 并安装 soundnessup..."
source ~/.bashrc
soundnessup install

# 第9步：更新 soundnessup
echo "正在更新 soundnessup..."
soundnessup update

# 第10步：生成密钥
echo "正在生成密钥..."
# 使用 expect 自动化交互式密码输入（直接回车）
/usr/bin/expect <<EOF
spawn soundness-cli generate-key --name my-key
expect "Enter passphrase"
send "\r"
expect "Confirm passphrase"
send "\r"
expect eof
EOF

# 提示用户保存公钥
echo "脚本执行完成！请保存显示的公钥（public key），后续会用到。"