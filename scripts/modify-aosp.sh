#!/bin/bash

# Pixel 4 Android编译项目 - AOSP源码修改脚本

echo "🔧 开始修改AOSP源码..."

# 进入AOSP目录
cd aosp_rom

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

# 修改ApplicationPackageManager.java
echo "🔍 修改ApplicationPackageManager.java..."
patch -p1 << 'EOF'
--- a/frameworks/base/core/java/android/app/ApplicationPackageManager.java
+++ b/frameworks/base/core/java/android/app/ApplicationPackageManager.java
@@ -20,6 +20,7 @@ import android.content.pm.PackageManager;
 import android.content.pm.PermissionInfo;
 import android.content.pm.ResolveInfo;
 import android.content.pm.SharedLibraryInfo;
+import android.privacy.detector.PrivacyDetector;
 import android.util.Log;
 
 import com.android.internal.annotations.VisibleForTesting;
@@ -100,6 +101,7 @@ public class ApplicationPackageManager extends PackageManager {
     @Override
     public int checkPermission(String permName, String pkgName) {
+        PrivacyDetector.recordDetection(pkgName, "checkPermission", permName);
         try {
             return mPM.checkPermission(permName, pkgName);
         } catch (RemoteException e) {
@@ -110,6 +112,7 @@ public class ApplicationPackageManager extends PackageManager {
     @Override
     public List<PackageInfo> getInstalledPackages(int flags) {
+        PrivacyDetector.recordDetection(getCallingPackage(), "getInstalledPackages", String.valueOf(flags));
         try {
             return mPM.getInstalledPackages(flags, mContext.getUserId());
         } catch (RemoteException e) {
@@ -120,6 +123,7 @@ public class ApplicationPackageManager extends PackageManager {
     @Override
     public List<ApplicationInfo> getInstalledApplications(int flags) {
+        PrivacyDetector.recordDetection(getCallingPackage(), "getInstalledApplications", String.valueOf(flags));
         try {
             return mPM.getInstalledApplications(flags, mContext.getUserId());
         } catch (RemoteException e) {
EOF

# 修改TelephonyManager.java
echo "📞 修改TelephonyManager.java..."
patch -p1 << 'EOF'
--- a/frameworks/base/core/java/android/telephony/TelephonyManager.java
+++ b/frameworks/base/core/java/android/telephony/TelephonyManager.java
@@ -20,6 +20,7 @@ import android.annotation.SystemApi;
 import android.content.Context;
 import android.os.Build;
 import android.os.RemoteException;
+import android.privacy.detector.PrivacyDetector;
 import android.telephony.ims.ImsManager;
 import android.util.Log;
 
@@ -200,6 +201,7 @@ public class TelephonyManager {
     @RequiresPermission(Manifest.permission.READ_PHONE_STATE)
     public String getDeviceId() {
+        PrivacyDetector.recordDetection(getCallingPackage(), "getDeviceId", "IMEI");
         try {
             ITelephony telephony = getITelephony();
             if (telephony != null) {
@@ -220,6 +222,7 @@ public class TelephonyManager {
     @RequiresPermission(Manifest.permission.READ_PHONE_STATE)
     public String getImei(int slotIndex) {
+        PrivacyDetector.recordDetection(getCallingPackage(), "getImei", "slotIndex: " + slotIndex);
         try {
             ITelephony telephony = getITelephony();
             if (telephony != null) {
EOF

echo "✅ AOSP源码修改完成！"
echo ""
echo "📋 已修改的文件："
echo "- frameworks/base/core/java/android/privacy/detector/PrivacyDetector.java (新增)"
echo "- frameworks/base/core/java/android/app/ApplicationPackageManager.java"
echo "- frameworks/base/core/java/android/telephony/TelephonyManager.java"
echo ""
echo "📋 下一步：运行 ./scripts/build-aosp.sh 开始编译"
