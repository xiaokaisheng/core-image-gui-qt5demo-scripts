#!/bin/bash

if [ -d .git-svn/cl-som-imx7-manifest ]; then
	rm -rf .git-svn/cl-som-imx7-manifest
fi

git clone https://github.com/xiaokaisheng/cl-som-imx7-manifest.git .git-svn/cl-som-imx7-manifest

if [ ! -d yocto-cl-som-imx7 ]; then
	mkdir yocto-cl-som-imx7
fi
cd yocto-cl-som-imx7

#更新repo
if [ ! -d .repo ]; then
	proxychains repo init -u ../.git-svn/cl-som-imx7-manifest
fi
proxychains repo sync

