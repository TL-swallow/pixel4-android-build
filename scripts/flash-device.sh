#!/bin/bash

# Pixel 4 Android编译项目 - 设备刷机脚本

echo "📱 开始刷机到Pixel 4设备..."

# 检查设备连接
echo "🔍 检查设备连接..."
adb devices

# 检查是否进入bootloader模式
echo "📋 检查bootloader模式..."
fastboot devices

if [ $? -ne 0 ]; then
    echo "⚠️  设备未进入bootloader模式，正在重启..."
    adb reboot bootloader
    sleep 10
fi

# 设置环境变量
export ANDROID_PRODUCT_OUT="$(pwd)/aosp_rom/out/target/product/coral"

echo "🚀 开始刷机..."
echo "📁 镜像路径: $ANDROID_PRODUCT_OUT"

# 解锁bootloader（如果需要）
echo "🔓 解锁bootloader..."
fastboot flashing unlock

# 刷机
echo "📥 刷写系统镜像..."
fastboot flashall -w

# 如果存储空间不够，使用指定大小
if [ $? -ne 0 ]; then
    echo "⚠️  存储空间不足，使用指定大小刷机..."
    fastboot flashall -S 50M -w
fi

echo "🔄 重启设备..."
fastboot reboot

echo "✅ 刷机完成！"
echo ""
echo "📋 设备将自动重启，请等待系统启动完成"
echo "📋 启动后可以运行 ./scripts/start-detection.sh 开始隐私检测"
