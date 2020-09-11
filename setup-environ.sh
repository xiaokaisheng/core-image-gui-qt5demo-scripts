#!/bin/bash

cd yocto-cl-som-imx7

if [ ! -e sources/meta-myqtdemo ]; then
   git clone https://github.com/xiaokaisheng/meta-myqtdemo.git sources/meta-myqtdemo
fi 

if [ -e build-xwayland-imx7/conf/local.conf ]; then
    # 恢复生成环境
    source setup-environment build-xwayland-imx7
    return
fi

#创建生成环境
MACHINE=cl-som-imx7 DISTRO=fsl-imx-xwayland \
    source sources/meta-bsp-imx7/tools/setup-env -b build-xwayland-imx7

#修改conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-myqtdemo \"" >> ./conf/bblayers.conf

#修改conf/local.conf
if [ -d /home/shared-folder/yocto-downloads ]; then
	#添加Mirror
	echo "INHERIT += \"own-mirrors\"" >> ./conf/local.conf
	echo "SOURCE_MIRROR_URL = \"file:///home/shared-folder/yocto-downloads\"" >> ./conf/local.conf
fi

# 添加wifi支持
echo "DISTRO_FEATURES_append = \" wifi \"" >> ./conf/local.conf
echo "IMAGE_INSTALL_append = \" kernel-modules openssh-sshd openssh-sftp-server openssh-sftp networkmanager wpa-supplicant wireless-tools linux-firmware vim \"" >> ./conf/local.conf
# 消除对connman的依赖
echo "IMAGE_FEATURES_remove = \"tools-testapps\"" >> ./conf/local.conf

echo "IMAGE_INSTALL_append = \" myqtdemo \"" >> ./conf/local.conf 
