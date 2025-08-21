#!/bin/bash

# AOSP镜像源测试脚本

echo "🌐 测试AOSP镜像源速度..."

# 定义镜像源列表
mirrors=(
    "https://mirrors.tuna.tsinghua.edu.cn/git/AOSP/platform/manifest"
    "https://mirrors.ustc.edu.cn/aosp/platform/manifest"
    "https://mirrors.huaweicloud.com/repository/aosp/platform/manifest"
    "https://mirror.sjtu.edu.cn/aosp/platform/manifest"
    "https://aosp.tuna.tsinghua.edu.cn/platform/manifest"
)

# 测试函数
test_mirror() {
    local url=$1
    local name=$2
    
    echo "🔍 测试 $name ($url)"
    
    # 测试连接速度
    start_time=$(date +%s.%N)
    if curl -s --connect-timeout 10 --max-time 30 "$url" > /dev/null 2>&1; then
        end_time=$(date +%s.%N)
        duration=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "0")
        echo "✅ $name: 连接成功 (${duration}s)"
        echo "$name|$url|$duration" >> mirror_speed_test.txt
    else
        echo "❌ $name: 连接失败"
        echo "$name|$url|FAILED" >> mirror_speed_test.txt
    fi
}

# 清理旧测试文件
rm -f mirror_speed_test.txt

echo "📊 开始测试镜像源速度..."
echo ""

# 测试每个镜像源
test_mirror "${mirrors[0]}" "清华大学镜像源"
test_mirror "${mirrors[1]}" "中科大镜像源"
test_mirror "${mirrors[2]}" "华为云镜像源"
test_mirror "${mirrors[3]}" "上海交大镜像源"
test_mirror "${mirrors[4]}" "清华大学AOSP镜像源"

echo ""
echo "📋 测试结果汇总:"
echo "=================="

if [ -f mirror_speed_test.txt ]; then
    # 按速度排序
    sort -t'|' -k3 -n mirror_speed_test.txt | while IFS='|' read name url speed; do
        if [ "$speed" != "FAILED" ]; then
            printf "%-20s: %s\n" "$name" "${speed}s"
        else
            printf "%-20s: %s\n" "$name" "连接失败"
        fi
    done
fi

echo ""
echo "🏆 推荐使用最快的镜像源进行下载"
echo "📝 测试结果已保存到: mirror_speed_test.txt"
