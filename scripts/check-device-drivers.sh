#!/bin/bash

# 设备驱动检查脚本

echo "🔍 检查Pixel 4设备驱动完备性..."

# 检查设备连接
echo "📱 检查设备连接状态..."
adb devices

# 检查设备型号
echo "📋 检查设备型号..."
adb shell getprop ro.product.model
adb shell getprop ro.product.name
adb shell getprop ro.product.device

# 检查基带版本
echo "📶 检查基带版本..."
adb shell getprop gsm.version.baseband

# 检查网络类型
echo "🌐 检查网络类型..."
adb shell getprop ro.telephony.default_network

# 检查运营商信息
echo "📞 检查运营商信息..."
adb shell getprop gsm.operator.alpha
adb shell getprop gsm.operator.numeric
adb shell getprop gsm.operator.iso-country

# 检查SIM卡状态
echo "📱 检查SIM卡状态..."
adb shell getprop gsm.sim.state
adb shell getprop gsm.sim.operator.alpha
adb shell getprop gsm.sim.operator.numeric

# 检查网络信号强度
echo "📡 检查网络信号强度..."
adb shell dumpsys telephony.registry | grep -E "(mSignalStrength|mServiceState)"

# 检查WiFi状态
echo "📶 检查WiFi状态..."
adb shell dumpsys wifi | grep -E "(Wi-Fi is|mWifiState)"

# 检查蓝牙状态
echo "🔵 检查蓝牙状态..."
adb shell dumpsys bluetooth | grep -E "(Bluetooth is|mState)"

# 检查摄像头状态
echo "📷 检查摄像头状态..."
adb shell dumpsys media.camera | grep -E "(Camera.*is|Available cameras)"

# 检查传感器状态
echo "⚡ 检查传感器状态..."
adb shell dumpsys sensorservice | grep -E "(Sensor.*is|Available sensors)"

echo "✅ 设备驱动检查完成！"
