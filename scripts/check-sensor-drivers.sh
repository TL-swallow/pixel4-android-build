#!/bin/bash

# 传感器驱动检查脚本

echo "⚡ 检查Pixel 4传感器驱动状态..."

# 检查传感器服务状态
echo "📋 传感器服务状态:"
adb shell dumpsys sensorservice | grep -E "(Sensor.*is|Available sensors)"

# 检查传感器列表
echo "📱 传感器列表:"
adb shell dumpsys sensorservice | grep -A 10 "Available sensors:"

# 检查传感器权限
echo "🔐 传感器权限状态:"
adb shell dumpsys sensorservice | grep -E "(Permission|permission)"

# 检查传感器硬件信息
echo "⚙️ 传感器硬件信息:"
adb shell getprop | grep -i sensor
adb shell getprop | grep -i accelerometer
adb shell getprop | grep -i gyroscope
adb shell getprop | grep -i magnetometer
adb shell getprop | grep -i proximity
adb shell getprop | grep -i light

# 检查传感器设备文件
echo "📁 传感器设备文件:"
adb shell ls -la /dev/sensor*
adb shell ls -la /sys/class/sensors/

# 检查传感器数据
echo "📊 传感器数据状态:"
adb shell dumpsys sensorservice | grep -A 5 "Sensor Data"

# 检查传感器校准状态
echo "🎯 传感器校准状态:"
adb shell dumpsys sensorservice | grep -i calibrat

# 检查传感器错误日志
echo "❌ 传感器错误日志:"
adb shell dumpsys sensorservice | grep -i error

# 检查特定传感器状态
echo "🔍 特定传感器状态:"
echo "加速度传感器:"
adb shell dumpsys sensorservice | grep -A 3 "Accelerometer"
echo "陀螺仪传感器:"
adb shell dumpsys sensorservice | grep -A 3 "Gyroscope"
echo "磁力计传感器:"
adb shell dumpsys sensorservice | grep -A 3 "Magnetometer"
echo "距离传感器:"
adb shell dumpsys sensorservice | grep -A 3 "Proximity"
echo "光线传感器:"
adb shell dumpsys sensorservice | grep -A 3 "Light"

echo "✅ 传感器驱动检查完成！"
