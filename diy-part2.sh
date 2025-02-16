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

# 修改默认IP
# sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate   # 定制默认IP

# Configure pppoe connection
#uci set network.wan.proto=pppoe
#uci set network.wan.username='yougotthisfromyour@isp.su'
#uci set network.wan.password='yourpassword'

# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/feeds/kenzo/alist
rm -rf package/feeds/kenzo/luci-app-alist
# rm -rf package/network/services/fullconenat
# git clone -b main --single-branch https://github.com/lxz1104/openwrt-fullconenat package/network/services/fullconenat

# rm -rf package/feeds/kenzo/luci-theme-argone
# rm -rf package/feeds/kiddin9/luci-base
# rm -rf package/feeds/kiddin9/luci-theme-argon
# rm -rf package/feeds/kiddin9/firewall
# rm -rf package/feeds/kiddin9/firewall4
# rm -rf package/feeds/kiddin9/luci-app-apinger
# rm -rf package/feeds/kiddin9/luci-app-keepalived
# rm -rf package/feeds/kiddin9/luci-app-lorawan-basicstation

# Themes
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/feeds/kiddin9/luci-theme-argon

# 取消bootstrap为默认主题，将默认主题改为 argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile


# 添加额外软件包
# Alist
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-alist package/alist


# 修改配置
sed -i "s|'enabled'|enabled|g" package/feeds/nas_luci/luci-app-istorex/root/etc/config/istorex
sed -i "s|'model'|model|g" package/feeds/nas_luci/luci-app-istorex/root/etc/config/istorex
sed -i "s|'wizard'|'router'|g" package/feeds/nas_luci/luci-app-istorex/root/etc/config/istorex

# Disable bridge firewalling by default
echo '# Disable bridge firewalling by default' >>package/base-files/files/etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-arptables=0' >>package/base-files/files/etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-ip6tables=0' >>package/base-files/files/etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-iptables=0' >>package/base-files/files/etc/sysctl.conf

# Disable bridge firewalling for docker
sed -i 's/enable/Disable/g' feeds/packages/utils/dockerd/files/etc/sysctl.d/sysctl-br-netfilter-ip.conf
sed -i 's/ip6tables=1/ip6tables=0/g' feeds/packages/utils/dockerd/files/etc/sysctl.d/sysctl-br-netfilter-ip.conf
sed -i 's/iptables=1/iptables=0/g' feeds/packages/utils/dockerd/files/etc/sysctl.d/sysctl-br-netfilter-ip.conf

# sed -i "s|'enabled'|enabled|g" package/feeds/kiddin9/luci-app-istorex/root/etc/config/istorex
# sed -i "s|'model'|model|g" package/feeds/kiddin9/luci-app-istorex/root/etc/config/istorex
# sed -i "s|'wizard'|'router'|g" package/feeds/kiddin9/luci-app-istorex/root/etc/config/istorex

# 科学上网插件 


# 科学上网插件依赖

# 删除编译出错的无用补丁
# rm -rf target/linux/rockchip/patches-6.1/113-ethernet-stmicro-stmmac-Add-SGMII-QSGMII-support.patch
# rm -rf target/linux/generic/backport-5.15/430-v6.3-ubi-Fix-failure-attaching-when-vid_hdr-offset-equals.patch
rm -rf target/linux/generic/backport-5.10/430-v6.3-ubi-Fix-failure-attaching-when-vid_hdr-offset-equals.patch
rm -rf target/linux/generic/pending-5.15/790-bus-mhi-core-add-SBL-state-callback.patch
# rm -rf target/linux/generic/backport-5.4/011-kbuild-export-SUBARCH.patch
# rm -rf target/linux/ipq807x/patches-5.4/0002-v5.8-arm64-dts-ipq8074-qcom-Re-arrange-dts-nodes-based-on.patch
# rm -rf target/linux/ipq807x/patches-5.4/104-arm64-dts-ipq8074-Add-SMEM-nodes.patch
# rm -rf target/linux/ipq807x/patches-5.4/105-arm64-dts-ipq8074-Add-SCM-node.patch
# rm -rf target/linux/ipq807x/patches-5.4/106-11-arm64-dts-qcom-Enable-Q6v5-WCSS-for-ipq8074-SoC.patch
# rm -rf target/linux/ipq807x/patches-5.4/107-arm64-dts-ipq8074-Add-WLAN-node.patch
# rm -rf target/linux/ipq807x/patches-5.4/901-arm64-qcom-dts-add-IPQ8074-dts.patch
# rm -rf target/linux/ipq807x/patches-5.4/997-device_tree_cmdline.patch
# rm -rf target/linux/ipq807x/patches-5.4/*.*
