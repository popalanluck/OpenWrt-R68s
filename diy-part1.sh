#!/bin/bash
# =================================================================
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# =================================================================

# 添加软件源
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default

# 添加第三方软件包
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall
svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/luci-app-passwall

# Add cpufreq
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq
ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq

./scripts/feeds update -a
./scripts/feeds install -a -f

# 添加 istore应用商店
echo >> feeds.conf.default
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
./scripts/feeds update istore
./scripts/feeds install -d y -p istore luci-app-store

# nas-packages-luci

echo >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default
./scripts/feeds update nas nas_luci
./scripts/feeds install -a -p nas
./scripts/feeds install -a -p nas_luci

# 在线用户
svn export https://github.com/haiibo/packages/trunk/luci-app-onliner package/luci-app-onliner
sed -i '/bin\/sh/a\uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '/nlbwmon/a\uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by Alan/g" package/lean/default-settings/files/zzz-default-settings

# 执行命令来切换内核
sed -i 's/PATCHVER:=5.15/PATCHVER:=6.1/g' target/linux/rockchip/Makefile
sed -i 's/PATCHVER:=5.15/PATCHVER:=6.1/g' target/linux/x86/Makefile

# 修改默认IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# TTYD 不指定接口，同时实现自动登录
sed -i 's/option interface/#option interface/g' feeds/packages/utils/ttyd/files/ttyd.config
sed -i 's|bin/login|usr/libexec/login.sh|g' feeds/packages/utils/ttyd/files/ttyd.config

