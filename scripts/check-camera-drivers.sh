#!/bin/bash

# 相机驱动检查脚本

echo "📷 检查Pixel 4相机驱动状态..."

# 检查相机服务状态
echo "📋 相机服务状态:"
adb shell dumpsys media.camera | grep -E "(Camera.*is|Available cameras)"

# 检查相机权限
echo "🔐 相机权限状态:"
adb shell dumpsys media.camera | grep -E "(Permission|permission)"

# 检查相机设备列表
echo "📱 相机设备列表:"
adb shell ls -la /dev/camera*
adb shell ls -la /dev/video*

# 检查相机模块
echo "🔧 相机模块状态:"
adb shell dumpsys media.camera | grep -A 5 "Camera Module"

# 检查相机API状态
echo "📡 相机API状态:"
adb shell dumpsys media.camera | grep -E "(Camera.*API|API.*Camera)"

# 检查相机硬件信息
echo "⚙️ 相机硬件信息:"
adb shell getprop | grep -i camera
adb shell getprop | grep -i sensor

# 检查相机应用状态
echo "📱 相机应用状态:"
adb shell dumpsys media.camera | grep -A 3 "Camera App"

# 检查相机性能
echo "⚡ 相机性能信息:"
adb shell dumpsys media.camera | grep -E "(Performance|FPS|Resolution)"

# 检查相机错误日志
echo "❌ 相机错误日志:"
adb shell dumpsys media.camera | grep -i error

echo "✅ 相机驱动检查完成！"
