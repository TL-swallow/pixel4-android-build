#!/bin/bash

# AOSP下载监控脚本

echo "📊 AOSP下载监控..."

# 检查下载目录
DOWNLOAD_DIR="/home/swallow/aosp_rom_android13"

if [ ! -d "$DOWNLOAD_DIR" ]; then
    echo "❌ 下载目录不存在: $DOWNLOAD_DIR"
    exit 1
fi

cd "$DOWNLOAD_DIR"

# 检查repo进程
echo "🔍 检查repo下载进程..."
repo_processes=$(ps aux | grep "repo sync" | grep -v grep | wc -l)
if [ $repo_processes -gt 0 ]; then
    echo "✅ repo下载进程正在运行 ($repo_processes 个进程)"
    ps aux | grep "repo sync" | grep -v grep
else
    echo "❌ 没有repo下载进程在运行"
fi

# 检查下载进度
echo ""
echo "📈 下载进度统计:"
total_projects=$(repo list | wc -l)
downloaded_projects=$(find . -name ".git" -type d | wc -l)
progress_percent=$((downloaded_projects * 100 / total_projects))

echo "总项目数: $total_projects"
echo "已下载: $downloaded_projects"
echo "进度: ${progress_percent}%"

# 显示进度条
echo ""
echo "进度条:"
bar_length=50
filled_length=$((progress_percent * bar_length / 100))
bar=""
for ((i=0; i<bar_length; i++)); do
    if [ $i -lt $filled_length ]; then
        bar="${bar}█"
    else
        bar="${bar}░"
    fi
done
echo "[$bar] ${progress_percent}%"

# 检查存储空间
echo ""
echo "💾 存储空间使用情况:"
df -h . | tail -1

# 检查网络连接
echo ""
echo "🌐 网络连接状态:"
ping -c 1 mirrors.ustc.edu.cn > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ 中科大镜像源连接正常"
else
    echo "❌ 中科大镜像源连接异常"
fi

# 显示最近下载的项目
echo ""
echo "📥 最近下载的项目:"
find . -name ".git" -type d -exec ls -ld {} \; | head -10 | awk '{print $9}' | sed 's|/.git||' | sed 's|^./||'

# 显示缺失的项目
echo ""
echo "❌ 缺失的项目:"
repo status | grep "missing" | head -10

echo ""
echo "📋 监控完成！"
echo "💡 提示: 下载完成后可以运行 'repo status' 检查完整状态"
