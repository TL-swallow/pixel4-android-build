#!/bin/bash

# Pixel 4 Android编译项目 - Git初始化脚本

echo "🚀 开始初始化Git仓库..."

# 检查是否已经初始化
if [ -d ".git" ]; then
    echo "⚠️  Git仓库已经存在，跳过初始化步骤"
else
    echo "📁 初始化Git仓库..."
    git init
fi

# 添加所有文件
echo "📝 添加文件到暂存区..."
git add .

# 创建初始提交
echo "💾 创建初始提交..."
git commit -m "🎉 初始化Pixel 4 Android编译项目

- 添加项目配置文件
- 添加GitHub Actions CI配置
- 添加Issue和PR模板
- 添加行为准则
- 配置.gitignore文件"

# 设置远程仓库（需要用户手动配置）
echo ""
echo "🔗 下一步：设置远程仓库"
echo "请运行以下命令设置您的GitHub仓库："
echo ""
echo "git remote add origin https://github.com/yourusername/pixel4-android-build.git"
echo "git branch -M main"
echo "git push -u origin main"
echo ""

echo "✅ Git初始化完成！"
echo ""
echo "📋 接下来您可以："
echo "1. 在GitHub上创建新仓库"
echo "2. 运行上述命令连接远程仓库"
echo "3. 开始按照README.md进行Android编译"
