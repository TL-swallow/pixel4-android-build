# Pixel 4 Android编译项目

[![CI](https://github.com/TL-swallow/pixel4-android-build/workflows/Android%20Build%20CI/badge.svg)](https://github.com/TL-swallow/pixel4-android-build/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Android](https://img.shields.io/badge/Platform-Android-green.svg)](https://www.android.com/)

## 📋 项目简介

本项目用于编译Pixel 4的Android系统，主要用于**Android App隐私合规检测**。通过直接修改AOSP源码实现对操作系统所有层级的深度控制和集成，实现从底层到应用层的全面隐私合规检测。

### 🎯 项目优势
- **系统级监控**: 直接修改AOSP源码，无需Hook框架
- **高性能**: 避免Frida/Xposed等Hook框架的性能开销
- **高稳定性**: 系统级集成，不会导致应用崩溃
- **全面检测**: 覆盖权限申请、设备信息、位置信息等38个检测点

## 🎯 项目目标

- [x] 项目结构初始化
- [x] Git配置完成
- [x] GitHub Actions CI配置
- [x] 项目文档模板
- [ ] Android源码下载 (Android 11.0.0_r2)
- [ ] 编译环境配置
- [ ] AOSP源码修改 (38个检测点)
- [ ] 系统编译
- [ ] 合规检测APP开发
- [ ] 设备信息测试

## 🔍 隐私合规检测项

基于Android 11.0.0_r2版本源码修改，适配Pixel 4机型，包含以下38个检测点：

### 📱 权限与包管理
| 检测项 | 文件路径 | 目标函数 |
|--------|----------|----------|
| 权限申请 | `frameworks/base/core/java/android/app/ApplicationPackageManager.java` | `checkPermission()` |
| 获取APP安装列表 | `frameworks/base/core/java/android/app/ApplicationPackageManager.java` | `getInstalledPackages()` |
| 获取APP安装列表 | `frameworks/base/core/java/android/app/ApplicationPackageManager.java` | `getInstalledApplications()` |
| 正在运行的进程 | `frameworks/base/core/java/android/app/ActivityManager.java` | `getRunningAppProcesses()` |
| 正在运行的服务 | `frameworks/base/core/java/android/app/ActivityManager.java` | `getRunningServiceControlPanel()` |

### 📶 设备信息
| 检测项 | 文件路径 | 目标函数 |
|--------|----------|----------|
| 获取Mac地址 | `frameworks/base/core/java/android/app/admin/DevicePolicyManager.java` | `getWifiMacAddress()` |
| 获取蓝牙名称 | `frameworks/base/core/java/android/bluetooth/BluetoothAdapter.java` | `getName()` |
| 获取蓝牙Mac地址 | `frameworks/base/core/java/android/bluetooth/BluetoothDevice.java` | `getAddress()` |
| 获取设备序列号 | `frameworks/base/core/java/android/os/Build.java` | `getSerial()` |
| 获取Android_id | `frameworks/base/core/java/android/provider/Settings.java` | `getString()` |

### 📞 通信信息
| 检测项 | 文件路径 | 目标函数 |
|--------|----------|----------|
| 获取IMEI | `frameworks/base/core/java/android/telephony/TelephonyManager.java` | `getDeviceId()` |
| 获取IMEI | `frameworks/base/core/java/android/telephony/TelephonyManager.java` | `getImei()` |
| 获取MEID | `frameworks/base/core/java/android/telephony/TelephonyManager.java` | `getMeid()` |
| 获取MCC/MNC | `frameworks/base/core/java/android/telephony/TelephonyManager.java` | `getNetworkOperatorName()` |
| 获取IMSI | `frameworks/base/core/java/android/telephony/TelephonyManager.java` | `getSubscriberId()` |
| 获取电话号码 | `frameworks/base/core/java/android/telephony/TelephonyManager.java` | `getLine1Number()` |

### 📍 位置信息
| 检测项 | 文件路径 | 目标函数 |
|--------|----------|----------|
| 获取纬度信息 | `frameworks/base/location/java/android/location/Location.java` | `getLatitude()` |
| 获取经度信息 | `frameworks/base/location/java/android/location/Location.java` | `getLongitude()` |
| 获取最后已知位置 | `frameworks/base/location/java/android/location/LocationManager.java` | `getLastKnownLocation()` |
| 获取基站cid信息 | `frameworks/base/telephony/java/android/telephony/gsm/GsmCellLocation.java` | `getCid()` |
| 获取基站lac信息 | `frameworks/base/telephony/java/android/telephony/gsm/GsmCellLocation.java` | `getLac()` |

### 📷 传感器与硬件
| 检测项 | 文件路径 | 目标函数 |
|--------|----------|----------|
| 打开摄像头 | `frameworks/base/core/java/android/content/Camera.java` | `open()` |
| 打开摄像头 | `frameworks/base/core/java/android/hardware/camera2/CameraManager.java` | `openCameraDeviceUserAsync()` |
| 获取传感器信息 | `frameworks/base/core/java/android/hardware/SensorManager.java` | `getSensorList()` |

### 📋 系统信息
| 检测项 | 文件路径 | 目标函数 |
|--------|----------|----------|
| 获取系统属性 | `frameworks/base/core/java/android/os/SystemProperties.java` | `get()` |
| 设置系统属性 | `frameworks/base/core/java/android/os/SystemProperties.java` | `set()` |
| 获取附近Wifi列表 | `frameworks/base/wifi/java/android/net/wifi/WifiInfo.java` | `getScanResults()` |
| 获取Mac地址 | `frameworks/base/wifi/java/android/net/wifi/WifiInfo.java` | `getFactoryMacAddresses()` |

## 🚀 快速开始

### 环境要求

- **操作系统**: Ubuntu 20.04+ 或 Linux发行版
- **内存**: 至少16GB RAM
- **存储**: 至少100GB可用空间
- **网络**: 稳定的网络连接（用于下载源码）

### 安装依赖

```bash
# 更新系统包
sudo apt-get update

# 安装编译依赖
sudo apt-get install -y \
  git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib \
  g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev \
  libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 项目初始化

```bash
# 克隆项目
git clone https://github.com/TL-swallow/pixel4-android-build.git
cd pixel4-android-build

# 运行初始化脚本
./scripts/init-git.sh
```

## 📁 项目结构

```
AndroidROM/
├── .github/                    # GitHub配置
│   ├── workflows/             # CI/CD工作流
│   ├── ISSUE_TEMPLATE/        # Issue模板
│   └── ...                    # 其他GitHub配置
├── scripts/                   # 脚本文件
│   └── init-git.sh           # Git初始化脚本
├── .gitignore                # Git忽略文件
├── package.json              # 项目配置
└── README.md                 # 项目说明
```

## 🔧 开发环境

### 系统要求

- **Java**: OpenJDK 17
- **Python**: 3.8+
- **Git**: 2.25+
- **Make**: 4.0+

### 环境检查

```bash
# 检查Java版本
java -version

# 检查Python版本
python3 --version

# 检查Git版本
git --version
```

## 📝 使用说明

### 1. 项目设置

```bash
# 安装项目依赖
npm install

# 运行设置脚本
npm run setup
```

### 2. 编译流程

```bash
# 运行编译
npm run build
```

### 3. 测试验证

```bash
# 运行测试
npm run test
```

## 📱 安装与使用

### 系统要求
- **设备**: Google Pixel 4 (coral)
- **Android版本**: Android 11.0.0_r2
- **存储空间**: 至少100GB可用空间
- **内存**: 至少16GB RAM

### 刷机步骤

1. **进入bootloader模式**:
   ```bash
   adb reboot bootloader
   ```

2. **设置环境变量**:
   ```bash
   export ANDROID_PRODUCT_OUT='/path/to/your/coral_rom'
   ```

3. **刷机**:
   ```bash
   fastboot flashall -w
   ```

4. **如果存储空间不够，指定分区大小**:
   ```bash
   fastboot flashall -S 50M -w
   ```

### 使用方法

1. **启动合规检测APP**: 打开系统中集成的"合规检测APP"
2. **连接网络**: 确保电脑和手机处于同一局域网
3. **查看结果**: 在浏览器中访问 `http://192.168.xxx.xxx:8080/`
4. **查看详情**: 点击详情查看具体的调用堆栈

### 检测结果展示

- **实时监控**: 显示APP的隐私信息获取行为
- **调用堆栈**: 详细显示API调用路径
- **统计分析**: 提供数据采集统计信息
- **违规标记**: 自动标记可能的隐私违规行为

## 🤝 贡献指南

我们欢迎所有形式的贡献！请查看以下指南：

### 提交Issue

1. 使用我们的[Issue模板](.github/ISSUE_TEMPLATE/bug_report.md)
2. 详细描述问题或建议
3. 提供复现步骤（如果适用）

### 提交PR

1. Fork本项目
2. 创建功能分支
3. 提交更改
4. 使用我们的[PR模板](.github/pull_request_template.md)

## 📄 许可证

本项目采用 [MIT许可证](LICENSE) - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [Android开源项目](https://source.android.com/)
- [Pixel设备支持](https://developers.google.com/android/images)
- [AOSP编译指南](https://source.android.com/setup/building)

## 📞 联系方式

- **项目主页**: [GitHub仓库](https://github.com/TL-swallow/pixel4-android-build)
- **问题反馈**: [Issues](https://github.com/TL-swallow/pixel4-android-build/issues)
- **讨论区**: [Discussions](https://github.com/TL-swallow/pixel4-android-build/discussions)

## 🙏 致谢

感谢所有为Android开源项目做出贡献的开发者们！

---

**注意**: 本项目目前处于初始阶段，Android源码编译功能正在开发中。请关注项目更新以获取最新进展。
