#!/bin/bash

# Pixel 4 Android编译项目 - AOSP编译脚本

echo "🔨 开始编译AOSP..."

# 进入AOSP目录
cd aosp_rom

# 设置编译环境
echo "🔧 设置编译环境..."
source build/envsetup.sh
lunch aosp_coral-userdebug

# 设置编译参数
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="-Xmx4g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache
export CCACHE_SIZE=50G

# 创建ccache目录
mkdir -p $CCACHE_DIR

# 开始编译
echo "🚀 开始编译系统镜像..."
make -j$(nproc) systemimage

echo "📱 编译用户数据分区..."
make -j$(nproc) userdataimage

echo "🔧 编译vendor分区..."
make -j$(nproc) vendorimage

echo "📦 编译boot镜像..."
make -j$(nproc) bootimage

echo "✅ AOSP编译完成！"
echo ""
echo "📋 编译输出位置："
echo "- 系统镜像: out/target/product/coral/system.img"
echo "- 用户数据: out/target/product/coral/userdata.img"
echo "- Vendor镜像: out/target/product/coral/vendor.img"
echo "- Boot镜像: out/target/product/coral/boot.img"
echo ""
echo "📋 下一步：运行 ./scripts/flash-device.sh 刷机到设备"
