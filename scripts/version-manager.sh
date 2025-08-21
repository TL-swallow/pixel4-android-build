#!/bin/bash

# 版本管理脚本

VERSION_DIR="versions"

show_help() {
    echo "📱 Android版本管理工具"
    echo ""
    echo "用法: $0 [命令] [版本]"
    echo ""
    echo "命令:"
    echo "  list                   列出所有可用版本"
    echo "  info [版本]            显示版本信息"
    echo "  setup [版本]           设置指定版本"
    echo "  download [版本]        下载指定版本的源码"
    echo "  build [版本]           编译指定版本"
    echo "  flash [版本]           刷机指定版本"
    echo "  help                   显示此帮助信息"
}

list_versions() {
    echo "📋 可用版本列表:"
    if [ -d "$VERSION_DIR" ]; then
        for version in "$VERSION_DIR"/*; do
            if [ -d "$version" ]; then
                version_name=$(basename "$version")
                echo "  ✅ $version_name"
            fi
        done
    else
        echo "  ❌ 没有找到版本目录"
    fi
}

setup_version() {
    local version=$1
    if [ ! -d "$VERSION_DIR/$version" ]; then
        echo "❌ 版本 $version 不存在"
        return 1
    fi
    echo "🔧 设置版本: $version"
    if [ -f "$VERSION_DIR/$version/scripts/check-android13-env.sh" ]; then
        "$VERSION_DIR/$version/scripts/check-android13-env.sh"
    fi
    echo "$version" > .current_version
    echo "✅ 版本 $version 设置完成"
}

download_version() {
    local version=$1
    if [ ! -d "$VERSION_DIR/$version" ]; then
        echo "❌ 版本 $version 不存在"
        return 1
    fi
    echo "📥 下载版本: $version"
    if [ -f "$VERSION_DIR/$version/scripts/download-aosp.sh" ]; then
        "$VERSION_DIR/$version/scripts/download-aosp.sh"
    fi
}

build_version() {
    local version=$1
    if [ ! -d "$VERSION_DIR/$version" ]; then
        echo "❌ 版本 $version 不存在"
        return 1
    fi
    echo "🔨 编译版本: $version"
    if [ -f "$VERSION_DIR/$version/scripts/build-aosp.sh" ]; then
        "$VERSION_DIR/$version/scripts/build-aosp.sh"
    fi
}

flash_version() {
    local version=$1
    if [ ! -d "$VERSION_DIR/$version" ]; then
        echo "❌ 版本 $version 不存在"
        return 1
    fi
    echo "📱 刷机版本: $version"
    if [ -f "$VERSION_DIR/$version/scripts/flash-device.sh" ]; then
        "$VERSION_DIR/$version/scripts/flash-device.sh"
    fi
}

case "$1" in
    "list")
        list_versions
        ;;
    "setup")
        setup_version "$2"
        ;;
    "download")
        download_version "$2"
        ;;
    "build")
        build_version "$2"
        ;;
    "flash")
        flash_version "$2"
        ;;
    "help"|"--help"|"-h"|"")
        show_help
        ;;
    *)
        echo "❌ 未知命令: $1"
        show_help
        exit 1
        ;;
esac
