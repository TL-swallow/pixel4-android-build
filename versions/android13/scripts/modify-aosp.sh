#!/bin/bash

# Android 13 - AOSP源码修改脚本

echo "🔧 开始修改Android 13 AOSP源码..."

# 设置环境变量
export AOSP_DIR="$(pwd)/../../aosp_rom_android13"

# 进入AOSP目录
cd $AOSP_DIR

# 创建隐私检测模块
echo "📁 创建隐私检测模块..."
mkdir -p frameworks/base/core/java/android/privacy/
mkdir -p frameworks/base/core/java/android/privacy/detector/

# 创建隐私检测核心类
cat > frameworks/base/core/java/android/privacy/detector/PrivacyDetector.java << 'EOF'
package android.privacy.detector;

import android.util.Log;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class PrivacyDetector {
    private static final String TAG = "PrivacyDetector";
    private static final ConcurrentHashMap<String, DetectionRecord> detectionRecords = new ConcurrentHashMap<>();
    
    public static class DetectionRecord {
        public String packageName;
        public String apiName;
        public String stackTrace;
        public long timestamp;
        public String data;
        
        public DetectionRecord(String packageName, String apiName, String stackTrace, String data) {
            this.packageName = packageName;
            this.apiName = apiName;
            this.stackTrace = stackTrace;
            this.timestamp = System.currentTimeMillis();
            this.data = data;
        }
    }
    
    public static void recordDetection(String packageName, String apiName, String data) {
        String stackTrace = getStackTrace();
        DetectionRecord record = new DetectionRecord(packageName, apiName, stackTrace, data);
        detectionRecords.put(packageName + "_" + apiName + "_" + record.timestamp, record);
        
        Log.w(TAG, "Privacy Detection: " + packageName + " -> " + apiName + " -> " + data);
    }
    
    private static String getStackTrace() {
        StringBuilder sb = new StringBuilder();
        StackTraceElement[] elements = Thread.currentThread().getStackTrace();
        for (int i = 3; i < Math.min(elements.length, 10); i++) {
            sb.append(elements[i].toString()).append("\n");
        }
        return sb.toString();
    }
    
    public static Map<String, DetectionRecord> getDetectionRecords() {
        return new HashMap<>(detectionRecords);
    }
}
EOF

# 应用隐私检测补丁
echo "🔍 应用隐私检测补丁..."
patch -p1 < ../../versions/android13/patches/privacy-detection.patch

echo "✅ Android 13 AOSP源码修改完成！"
echo ""
echo "📋 已修改的文件："
echo "- frameworks/base/core/java/android/privacy/detector/PrivacyDetector.java (新增)"
echo "- 应用了隐私检测补丁"
echo ""
echo "📋 下一步：运行 ./versions/android13/scripts/build-aosp.sh 开始编译"
