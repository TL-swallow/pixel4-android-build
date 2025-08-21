#!/bin/bash

# 音频驱动检查脚本

echo "🎵 检查Pixel 4音频驱动状态..."

# 检查音频服务状态
echo "📋 音频服务状态:"
adb shell dumpsys audio | grep -E "(Audio.*is|Audio Service)"

# 检查音频设备列表
echo "📱 音频设备列表:"
adb shell dumpsys audio | grep -A 10 "Audio Devices"

# 检查音频硬件信息
echo "⚙️ 音频硬件信息:"
adb shell getprop | grep -i audio
adb shell getprop | grep -i speaker
adb shell getprop | grep -i microphone
adb shell getprop | grep -i headphone

# 检查音频设备文件
echo "📁 音频设备文件:"
adb shell ls -la /dev/snd/
adb shell ls -la /proc/asound/

# 检查音频权限
echo "🔐 音频权限状态:"
adb shell dumpsys audio | grep -E "(Permission|permission)"

# 检查音频路由
echo "🛣️ 音频路由状态:"
adb shell dumpsys audio | grep -A 5 "Audio Routing"

# 检查音频流状态
echo "🌊 音频流状态:"
adb shell dumpsys audio | grep -A 3 "Audio Streams"

# 检查音频焦点
echo "🎯 音频焦点状态:"
adb shell dumpsys audio | grep -A 5 "Audio Focus"

# 检查音频错误日志
echo "❌ 音频错误日志:"
adb shell dumpsys audio | grep -i error

# 检查特定音频组件
echo "🔍 特定音频组件状态:"
echo "扬声器:"
adb shell dumpsys audio | grep -A 3 "Speaker"
echo "麦克风:"
adb shell dumpsys audio | grep -A 3 "Microphone"
echo "耳机:"
adb shell dumpsys audio | grep -A 3 "Headphone"
echo "蓝牙音频:"
adb shell dumpsys audio | grep -A 3 "Bluetooth"

echo "✅ 音频驱动检查完成！"
