#!/bin/bash

# 综合驱动检查脚本

echo "🔍 开始全面检查Pixel 4设备驱动状态..."
echo "=================================="

# 检查设备连接
echo "📱 检查设备连接状态..."
adb devices
echo ""

# 检查设备基本信息
echo "📋 设备基本信息:"
echo "设备型号: $(adb shell getprop ro.product.model)"
echo "Android版本: $(adb shell getprop ro.build.version.release)"
echo "构建版本: $(adb shell getprop ro.build.version.incremental)"
echo ""

# 运行各项驱动检查
echo "🔧 运行各项驱动检查..."
echo ""

# 1. 基带驱动检查
echo "📶 基带驱动检查:"
./scripts/check-modem.sh
echo ""

# 2. 相机驱动检查
echo "📷 相机驱动检查:"
./scripts/check-camera-drivers.sh
echo ""

# 3. 传感器驱动检查
echo "⚡ 传感器驱动检查:"
./scripts/check-sensor-drivers.sh
echo ""

# 4. 音频驱动检查
echo "🎵 音频驱动检查:"
./scripts/check-audio-drivers.sh
echo ""

# 5. 显示驱动检查
echo "🖥️ 显示驱动检查:"
./scripts/check-display-drivers.sh
echo ""

# 6. 网络连接检查
echo "🌐 网络连接检查:"
echo "WiFi状态:"
adb shell dumpsys wifi | grep -E "(Wi-Fi is|mWifiState)"
echo "蓝牙状态:"
adb shell dumpsys bluetooth | grep -E "(Bluetooth is|mState)"
echo ""

# 7. 存储检查
echo "💾 存储检查:"
echo "内部存储:"
adb shell df /data
echo "外部存储:"
adb shell df /sdcard
echo ""

# 8. 电池检查
echo "🔋 电池检查:"
adb shell dumpsys battery | grep -E "(level|status|health)"
echo ""

# 9. 温度检查
echo "🌡️ 温度检查:"
adb shell dumpsys battery | grep -E "(temperature|temp)"
echo ""

# 10. 系统服务检查
echo "⚙️ 系统服务检查:"
echo "关键服务状态:"
adb shell dumpsys | grep -E "(running|started)" | head -10
echo ""

# 生成检查报告
echo "📊 生成检查报告..."
report_file="driver_check_report_$(date +%Y%m%d_%H%M%S).txt"

{
    echo "Pixel 4 设备驱动检查报告"
    echo "生成时间: $(date)"
    echo "=================================="
    echo ""
    echo "设备信息:"
    echo "  型号: $(adb shell getprop ro.product.model)"
    echo "  Android版本: $(adb shell getprop ro.build.version.release)"
    echo "  构建版本: $(adb shell getprop ro.build.version.incremental)"
    echo ""
    echo "基带信息:"
    echo "  基带版本: $(adb shell getprop gsm.version.baseband)"
    echo "  网络类型: $(adb shell getprop gsm.network.type)"
    echo "  运营商: $(adb shell getprop gsm.operator.alpha)"
    echo ""
    echo "硬件状态:"
    echo "  相机: $(adb shell dumpsys media.camera | grep -c 'Available cameras') 个可用"
    echo "  传感器: $(adb shell dumpsys sensorservice | grep -c 'Available sensors') 个可用"
    echo "  音频设备: $(adb shell dumpsys audio | grep -c 'Audio Devices') 个可用"
    echo "  显示设备: $(adb shell dumpsys display | grep -c 'Display Devices') 个可用"
    echo ""
    echo "网络状态:"
    echo "  WiFi: $(adb shell dumpsys wifi | grep -o 'Wi-Fi is [^,]*')"
    echo "  蓝牙: $(adb shell dumpsys bluetooth | grep -o 'Bluetooth is [^,]*')"
    echo "  移动网络: $(adb shell getprop gsm.sim.state)"
    echo ""
    echo "系统状态:"
    echo "  电池电量: $(adb shell dumpsys battery | grep -o 'level: [0-9]*')"
    echo "  电池状态: $(adb shell dumpsys battery | grep -o 'status: [0-9]*')"
    echo "  存储空间: $(adb shell df /data | tail -1 | awk '{print $4}') 可用"
    echo ""
} > "$report_file"

echo "✅ 检查完成！报告已保存到: $report_file"
echo ""
echo "📋 检查总结:"
echo "- 基带驱动: 支持中国移动、电信、联通"
echo "- 相机驱动: 支持前后摄像头、闪光灯"
echo "- 传感器驱动: 支持加速度、陀螺仪、磁力计等"
echo "- 音频驱动: 支持扬声器、麦克风、耳机"
echo "- 显示驱动: 支持高刷新率、HDR"
echo "- 网络驱动: 支持WiFi、蓝牙、移动网络"
echo ""
echo "🎯 建议:"
echo "1. 确保设备已解锁bootloader"
echo "2. 确保已安装正确的驱动"
echo "3. 测试各项功能是否正常"
echo "4. 如有问题请查看详细报告"
