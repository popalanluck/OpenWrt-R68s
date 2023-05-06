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
# sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate   # 定制默认IP

# Configure pppoe connection
#uci set network.wan.proto=pppoe
#uci set network.wan.username='yougotthisfromyour@isp.su'
#uci set network.wan.password='yourpassword'

# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon

# Themes
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

# 添加额外软件包


# 科学上网插件


# 科学上网插件依赖

#编译alist

rm -rf feeds/packages/lang/golang
#旧版 svn export https://github.com/sbwml/packages_lang_golang/branches/20.x feeds/packages/lang/golang#
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
rm -rf package/feeds/kenzo/alist
rm -rf package/feeds/kenzo/luci-app-alist
git clone https://github.com/sbwml/luci-app-alist package/alist

./scripts/feeds update -a
./scripts/feeds install -a -f
rm -rf package/feeds/kenzo/alist
rm -rf package/feeds/kenzo/luci-app-alist
