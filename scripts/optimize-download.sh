#!/bin/bash

# AOSP下载速度优化脚本

echo "🚀 优化AOSP下载速度..."

# 检查当前下载状态
echo "📊 检查当前下载状态..."
if [ -d "aosp_rom_android13" ]; then
    cd aosp_rom_android13
    echo "📁 当前下载目录: $(pwd)"
    
    # 检查下载进度
    if [ -f ".repo/manifest.xml" ]; then
        echo "✅ repo已初始化"
        
        # 显示下载进度
        echo "📈 当前下载进度:"
        repo status 2>/dev/null | head -10
        
        # 检查网络连接
        echo "🌐 检查网络连接..."
        ping -c 3 mirrors.ustc.edu.cn > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "✅ 中科大镜像源连接正常"
        else
            echo "❌ 中科大镜像源连接异常"
        fi
    fi
else
    echo "❌ 下载目录不存在"
    exit 1
fi

# 优化Git配置
echo "🔧 优化Git配置..."
git config --global http.postBuffer 524288000
git config --global http.maxRequestBuffer 100M
git config --global core.compression 9
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999

# 优化repo配置
echo "⚙️ 优化repo配置..."
export REPO_BUFFER_SIZE=524288000
export REPO_MAX_JOBS=8

# 检查系统资源
echo "💻 检查系统资源..."
echo "CPU核心数: $(nproc)"
echo "可用内存: $(free -h | grep Mem | awk '{print $7}')"
echo "可用存储: $(df -h . | tail -1 | awk '{print $4}')"

# 优化下载参数
echo "📥 优化下载参数..."
echo "建议的下载命令:"
echo "repo sync -j$(nproc) --network-only --no-tags"

# 创建优化后的下载脚本
cat > optimized_sync.sh << 'EOF'
#!/bin/bash

# 优化的repo sync脚本

echo "🚀 开始优化下载..."

# 设置环境变量
export REPO_BUFFER_SIZE=524288000
export REPO_MAX_JOBS=8

# 优化Git配置
git config --global http.postBuffer 524288000
git config --global http.maxRequestBuffer 100M
git config --global core.compression 9
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999

# 开始同步
echo "📥 开始同步源码..."
repo sync -j$(nproc) --network-only --no-tags

echo "✅ 下载完成！"
EOF

chmod +x optimized_sync.sh

echo ""
echo "📋 优化建议:"
echo "1. 使用更多并行任务: repo sync -j$(nproc)"
echo "2. 跳过标签下载: --no-tags"
echo "3. 仅网络下载: --network-only"
echo "4. 增加缓冲区大小: REPO_BUFFER_SIZE=524288000"
echo ""
echo "🎯 运行优化下载: ./optimized_sync.sh"
