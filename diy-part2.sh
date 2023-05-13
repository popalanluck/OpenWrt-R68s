#!/bin/bash
# ==============================================================
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# ===============================================================

#修改默认IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate   # 定制默认IP

# Configure pppoe connection
#uci set network.wan.proto=pppoe
#uci set network.wan.username='yougotthisfromyour@isp.su'
#uci set network.wan.password='yourpassword'

# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon
# rm -rf package/feeds/kenzo/luci-theme-argone

# Themes
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

# 取消bootstrap为默认主题，将默认主题改为 argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile


# 添加额外软件包


# 修改配置
sed -i "s|'enabled'|enabled|g" package/feeds/nas_luci/luci-app-istorex/root/etc/config/istorex
sed -i "s|'model'|model|g" package/feeds/nas_luci/luci-app-istorex/root/etc/config/istorex
sed -i "s|'wizard'|'router'|g" package/feeds/nas_luci/luci-app-istorex/root/etc/config/istorex

# 科学上网插件


# 科学上网插件依赖

#删除编译出错的无用补丁

rm -rf target/linux/rockchip/patches-6.1/113-ethernet-stmicro-stmmac-Add-SGMII-QSGMII-support.patch
