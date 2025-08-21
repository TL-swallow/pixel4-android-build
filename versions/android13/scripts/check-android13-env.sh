#!/bin/bash

# Android 13 环境检查脚本

echo "🔍 检查Android 13编译环境..."

# 检查操作系统
echo "📋 检查操作系统..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✅ 操作系统: Linux"
    lsb_release -a 2>/dev/null || echo "⚠️  无法获取详细版本信息"
else
    echo "❌ 不支持的操作系统: $OSTYPE"
    echo "请使用Linux系统进行编译"
    exit 1
fi

# 检查内存
echo "💾 检查内存..."
total_mem=$(free -g | awk '/^Mem:/{print $2}')
if [ $total_mem -ge 16 ]; then
    echo "✅ 内存: ${total_mem}GB (满足要求)"
else
    echo "❌ 内存不足: ${total_mem}GB (需要至少16GB)"
    exit 1
fi

# 检查存储空间
echo "💿 检查存储空间..."
available_space=$(df -BG . | awk 'NR==2 {print $4}' | sed 's/G//')
if [ $available_space -ge 150 ]; then
    echo "✅ 可用空间: ${available_space}GB (满足要求)"
else
    echo "❌ 存储空间不足: ${available_space}GB (需要至少150GB)"
    exit 1
fi

# 检查CPU核心数
echo "🖥️  检查CPU..."
cpu_cores=$(nproc)
if [ $cpu_cores -ge 4 ]; then
    echo "✅ CPU核心数: ${cpu_cores} (满足要求)"
else
    echo "⚠️  CPU核心数较少: ${cpu_cores} (推荐8核以上)"
fi

# 检查Java版本
echo "☕ 检查Java版本..."
if command -v java &> /dev/null; then
    java_version=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2)
    echo "✅ Java版本: $java_version"
    
    # 检查是否为OpenJDK 11
    if [[ $java_version == *"11"* ]]; then
        echo "✅ 使用推荐的OpenJDK 11"
    else
        echo "⚠️  建议使用OpenJDK 11 (当前: $java_version)"
    fi
else
    echo "❌ Java未安装"
    echo "请运行: sudo apt-get install openjdk-11-jdk"
    exit 1
fi

# 检查Python版本
echo "🐍 检查Python版本..."
if command -v python3 &> /dev/null; then
    python_version=$(python3 --version 2>&1 | cut -d' ' -f2)
    echo "✅ Python版本: $python_version"
else
    echo "❌ Python3未安装"
    echo "请运行: sudo apt-get install python3"
    exit 1
fi

# 检查Git版本
echo "📚 检查Git版本..."
if command -v git &> /dev/null; then
    git_version=$(git --version | cut -d' ' -f3)
    echo "✅ Git版本: $git_version"
else
    echo "❌ Git未安装"
    echo "请运行: sudo apt-get install git"
    exit 1
fi

# 检查repo工具
echo "📦 检查repo工具..."
if command -v repo &> /dev/null; then
    echo "✅ repo工具已安装"
else
    echo "⚠️  repo工具未安装"
    echo "请运行以下命令安装repo:"
    echo "mkdir -p ~/bin"
    echo "curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo"
    echo "chmod a+x ~/bin/repo"
    echo "export PATH=~/bin:$PATH"
fi

# 检查编译依赖
echo "🔧 检查编译依赖..."
dependencies=(
    "gcc"
    "g++"
    "make"
    "flex"
    "bison"
    "zip"
    "curl"
    "ccache"
)

missing_deps=()
for dep in "${dependencies[@]}"; do
    if ! command -v $dep &> /dev/null; then
        missing_deps+=($dep)
    fi
done

if [ ${#missing_deps[@]} -eq 0 ]; then
    echo "✅ 编译依赖已安装"
else
    echo "❌ 缺少依赖: ${missing_deps[*]}"
    echo "请运行: sudo apt-get install ${missing_deps[*]}"
    exit 1
fi

# 检查网络连接
echo "🌐 检查网络连接..."
if ping -c 1 mirrors.tuna.tsinghua.edu.cn &> /dev/null; then
    echo "✅ 网络连接正常"
else
    echo "⚠️  无法连接到清华镜像源"
    echo "请检查网络连接或使用其他镜像源"
fi

echo ""
echo "🎉 环境检查完成！"
echo ""
echo "📋 下一步操作："
echo "1. 运行 ./scripts/download-aosp.sh 下载Android 13源码"
echo "2. 运行 ./scripts/modify-aosp.sh 修改源码"
echo "3. 运行 ./scripts/build-aosp.sh 开始编译"
echo ""
echo "📚 详细配置请参考: docs/android13-config.md"
