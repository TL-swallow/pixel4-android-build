#!/bin/bash

# Android 13 - AOSP源码下载脚本

echo "🚀 开始下载Android 13 AOSP源码..."

# 设置环境变量
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/AOSP/platform/manifest'
export AOSP_VERSION='android-13.0.0_r1'
export DEVICE_NAME='coral'  # Pixel 4代号
export AOSP_DIR="$(pwd)/../../aosp_rom_android13"

# 创建源码目录
mkdir -p $AOSP_DIR
cd $AOSP_DIR

echo "📥 初始化repo..."
repo init -u $REPO_URL -b $AOSP_VERSION

echo "📋 同步源码..."
repo sync -j$(nproc)

echo "🔧 设置编译环境..."
source build/envsetup.sh
lunch aosp_$DEVICE_NAME-userdebug

echo "✅ Android 13 AOSP源码下载完成！"
echo ""
echo "📁 源码位置: $AOSP_DIR"
echo "📋 下一步："
echo "1. 运行 ./versions/android13/scripts/modify-aosp.sh 进行源码修改"
echo "2. 运行 ./versions/android13/scripts/build-aosp.sh 开始编译"
