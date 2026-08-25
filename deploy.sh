#!/bin/bash
# 部署方舟动物园休息收入计分助手到 GitHub
# 用法：bash deploy.sh
set -e

REPO="ark-nova-break-income"
REMOTE_URL="git@github.com:Vincent1130/${REPO}.git"

cd "$(dirname "$0")"

# 1. 创建远程公开仓库（如已存在会报错，可忽略）
echo "==> 创建 GitHub 仓库 ${REPO} (public)"
gh repo create "${REPO}" --public --description "方舟动物园休息收入计分助手 - 移动端+平板布局，实时计算休息可得钱数" 2>&1 || echo "(仓库可能已存在，继续)"

# 2. 初始化本地 git（如已存在跳过）
if [ ! -d .git ]; then
    git init -b main
fi

# 3. 配置 origin
if ! git remote get-url origin >/dev/null 2>&1; then
    git remote add origin "${REMOTE_URL}"
else
    git remote set-url origin "${REMOTE_URL}"
fi

# 4. 提交
git add index.html
git commit -m "init: 方舟动物园休息收入计分助手" || echo "(无变更或已提交)"

# 5. 推送
git push -u origin main

echo ""
echo "==> 部署完成！"
echo "    仓库地址: https://github.com/Vincent1130/${REPO}"
echo "    启用 Pages: https://github.com/Vincent1130/${REPO}/settings/pages"
echo "    Pages 后将得到可访问的网页地址。"
