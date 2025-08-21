#!/bin/bash

# 基带驱动检查脚本

echo "📶 检查Pixel 4基带驱动状态..."

# 检查基带版本
echo "📋 基带版本信息:"
adb shell getprop gsm.version.baseband
adb shell getprop gsm.version.ril-impl

# 检查基带状态
echo "📡 基带状态:"
adb shell getprop gsm.current.phone-type
adb shell getprop gsm.network.type
adb shell getprop gsm.sim.state

# 检查网络注册状态
echo "🌐 网络注册状态:"
adb shell dumpsys telephony.registry | grep -A 5 "mServiceState"

# 检查信号强度
echo "📶 信号强度:"
adb shell dumpsys telephony.registry | grep -A 3 "mSignalStrength"

# 检查运营商信息
echo "📞 运营商信息:"
adb shell getprop gsm.operator.alpha
adb shell getprop gsm.operator.numeric
adb shell getprop gsm.operator.iso-country

# 检查SIM卡信息
echo "📱 SIM卡信息:"
adb shell getprop gsm.sim.operator.alpha
adb shell getprop gsm.sim.operator.numeric
adb shell getprop gsm.sim.countryiso

# 检查网络类型
echo "🌍 网络类型:"
adb shell getprop ro.telephony.default_network
adb shell getprop ro.telephony.ril_class

# 检查VoLTE状态
echo "📞 VoLTE状态:"
adb shell getprop persist.dbg.volte_avail_ovr
adb shell getprop persist.dbg.vt_avail_ovr

# 检查WiFi Calling状态
echo "📶 WiFi Calling状态:"
adb shell getprop persist.dbg.wfc_avail_ovr

# 检查网络频段
echo "📡 网络频段:"
adb shell dumpsys telephony.registry | grep -A 10 "CellInfo"

# 检查网络连接
echo "🔗 网络连接测试:"
ping -c 3 8.8.8.8

echo "✅ 基带驱动检查完成！"
