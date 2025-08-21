# Pixel 4 Android编译项目

[![CI](https://github.com/yourusername/pixel4-android-build/workflows/Android%20Build%20CI/badge.svg)](https://github.com/yourusername/pixel4-android-build/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Android](https://img.shields.io/badge/Platform-Android-green.svg)](https://www.android.com/)

## 📋 项目简介

本项目用于编译Pixel 4的Android系统，主要用于测试手机APP的设备信息获取情况。通过自定义编译的Android系统，可以更好地控制和测试设备信息的获取行为。

## 🎯 项目目标

- [x] 项目结构初始化
- [x] Git配置完成
- [x] GitHub Actions CI配置
- [x] 项目文档模板
- [ ] Android源码下载
- [ ] 编译环境配置
- [ ] 系统编译
- [ ] 设备信息测试

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
git clone https://github.com/yourusername/pixel4-android-build.git
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

- **项目主页**: [GitHub仓库](https://github.com/yourusername/pixel4-android-build)
- **问题反馈**: [Issues](https://github.com/yourusername/pixel4-android-build/issues)
- **讨论区**: [Discussions](https://github.com/yourusername/pixel4-android-build/discussions)

## 🙏 致谢

感谢所有为Android开源项目做出贡献的开发者们！

---

**注意**: 本项目目前处于初始阶段，Android源码编译功能正在开发中。请关注项目更新以获取最新进展。
