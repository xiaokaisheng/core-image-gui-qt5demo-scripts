# 使用说明
## 相关文件
  * prep-yocto.sh: 执行该脚本将通过google repo工具, 将cl-som-imx7模块的yocto meta文件下载到yocto-cl-som-imx7
  * setup-environ.sh: 执行`source setup-environ.sh`会在yocto-cl-som-imx7/build-fb-imx7目录下建立yocto编译环境, 后续执行`bitbake -k fsl-image-qt5-validation-imx`可以生成cl-som-imx7的linux镜像

## 常用命令
  * 下载yocto meta文件到yocto-cl-som-imx7
    ```
    ./prep-yocto.sh
    ```

  * 初始化编译环境(yocto-cl-som-imx7/build-fb-imx)
    ```
    source setup-environ.sh
    ```

  * 创建linux镜像(进入编译环境后才能执行)
    ```
    bitbake fsl-image-qt5-validation-imx
    ```
  * 烧写imx7的镜像到sdcard
    ```
    #将linux镜像写入到sdcard (sdcard对应的设备文件可以通过`lsblk`命令发现, 下面例子中使用`/dev/sdX`代替)
    bzcat ~/path/to/build-fb-imx7/tmp/deploy/images/cl-som-imx7/fsl-image-qt5-validation-imx-cl-som-imx7.sdcard.bz2 | sudo dd of=/dev/sdX bs=1M conv=fsync status=progress
    ```

