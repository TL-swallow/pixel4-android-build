#!/bin/bash

# 显示驱动检查脚本

echo "🖥️ 检查Pixel 4显示驱动状态..."

# 检查显示服务状态
echo "📋 显示服务状态:"
adb shell dumpsys display | grep -E "(Display.*is|Display Service)"

# 检查显示设备列表
echo "📱 显示设备列表:"
adb shell dumpsys display | grep -A 10 "Display Devices"

# 检查显示硬件信息
echo "⚙️ 显示硬件信息:"
adb shell getprop | grep -i display
adb shell getprop | grep -i screen
adb shell getprop | grep -i resolution
adb shell getprop | grep -i density

# 检查显示设备文件
echo "📁 显示设备文件:"
adb shell ls -la /dev/graphics/
adb shell ls -la /sys/class/graphics/

# 检查显示权限
echo "🔐 显示权限状态:"
adb shell dumpsys display | grep -E "(Permission|permission)"

# 检查显示配置
echo "⚙️ 显示配置:"
adb shell dumpsys display | grep -A 5 "Display Configuration"

# 检查显示模式
echo "🎨 显示模式:"
adb shell dumpsys display | grep -A 3 "Display Mode"

# 检查显示亮度
echo "💡 显示亮度:"
adb shell dumpsys display | grep -A 3 "Brightness"

# 检查显示错误日志
echo "❌ 显示错误日志:"
adb shell dumpsys display | grep -i error

# 检查特定显示组件
echo "🔍 特定显示组件状态:"
echo "主屏幕:"
adb shell dumpsys display | grep -A 3 "Primary Display"
echo "刷新率:"
adb shell dumpsys display | grep -A 3 "Refresh Rate"
echo "HDR支持:"
adb shell dumpsys display | grep -A 3 "HDR"

# 检查触摸屏状态
echo "👆 触摸屏状态:"
adb shell dumpsys input | grep -A 5 "Touch Screen"

echo "✅ 显示驱动检查完成！"
