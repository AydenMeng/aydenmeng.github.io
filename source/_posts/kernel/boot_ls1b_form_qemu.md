---
title: 龙芯杯无开发板如何开发和调试linux
date: 2021-12-05 22:59:33
categories: [嵌入式, Linux]
tags: [龙芯, Linux, gdb]
---

# 龙芯杯无开发板如何开发和调试linux
## 背景
> 因为龙芯杯的`cpu`是`32`位的，具体来说是基于`GS232`的，恰好给的`pmon`引导文件是用于`ls1b`的，`ls1b`的核也是`GS232`的，所以就想到可以直接基于`ls1b`的虚拟机来开发操作系统，这样就可以加快操作系统的开发周期，而不需要依托于上板才能看出操作系统存在的问题(大多数)。

## Qemu搭建
1. 虚拟机采用qemu，因为qemu支持ls1b，pmon的话可以直接使用发布包里面给的，也可以使用龙芯开源的ls1b的pmon，后者开机有图形显示，仅此而已，都是够用的。

   - 首先是下载和安装`qemu`，从官网和清华源之类的地方下载是只有很少龙芯机器支持的，这里用`https://gitee.com/martinqiao/qemu.git`
   
     配置和编译如下：
   ```bash
   mkdir build4mips
   cd build4mips
   ../configure --target-list=mipsel-softmmu --disable-werror
   make
   ```
     其中`--target-list`后面的选项，在此调试需求下，必须的是`mipsel-softmmu`，有更多兴趣的可以加上`mips64el-softmmu`，`mips64el-linux-user`，`mipsel-linux-user`等，自行了解即可。其中带有`softmmu`的选项是系统级虚拟机，`linux-user`为用户级虚拟机。
   
     - `../configure`的时候如果出现`ERROR`报错，缺少依赖的话，用`apt-cache search 依赖`，然后再安装即可，如果不报`ERROR`的错，应该就可以直接`make`

   

## 利用qemu测试pmon
2. 在真实的机器上是绕不开BootLoader这一层的，在龙芯里也就是PMON，在Qemu中可以带着PMON一起运行Linux。
   
   ```bash
   qemu-5.2.0/build4mips/mipsel-softmmu/qemu-system-mipsel -M ls1b -serial stdio -m 2048 -bios ../loongson/pmon/zloader.ls1b/gzrom.bin
   ```
   

## 利用Qemu和Pmon测试操作系统

3. 利用`qemu`调试操作系统

   做系统开发的话嘛，写系统大家就各自加油吧，太难讲了（等以后的同学完善这一块吧），然后调试就是用这种方式。首先要准备一个写好的内核。就是一般编译出来的`vmlinux`文件（啊我好罗嗦）
   
   > 由于自己写的，还不行，所以就用源码编译一份，用作演示
   
### 提供linux内核  

   qemu支持带pmon引导操作系统，当然更广为人知的是直接引导操作系统，然而直接引导一个操作系统可能不止需要一个操作系统的内核，还需要`模拟内存的磁盘文件`，`设备树文件`等，而且按照龙芯杯的需求，只需要一个内核文件即可，所以我们只做一个操作系统的内核即可（但是没有根文件系统就没法交互）。

   此处参考最后文末最后一篇文章
   1. 获取源码`http://ftp.loongnix.org/embedd/ls1b/bootloader/`
   
   2. 在`http://ftp.loongnix.org/embed/ls1b/boot/` 下载`ramdisk.tar.gz`，并将其解压到`/mnt/ramdisk1` 目录中（解决某种报错，遇到就知道了）

   3. `cp config.ls1b .config`修改内核配置

   4. `make vmlinux ARCH=mips`编译内核

   5. `mipsel-linux-strip vmlinux`精简内核

> 依赖问题自行解决……

这时在源码目录下就出现了`vmlinux`文件，也就可以使用了。

### 搭建tftp服务器
大赛发布包有提供这样的文件教程，但是是`windows`的，可能在`windows`下大家更好操作，~~但是我已经好久没碰`windows`了……~~ 所以`linux`的，凑合看吧……

1. 安装`tftp-server`，在不同的发行版，包的名字可能不太一样，自己查一下吧（龙芯的操作系统上叫`tftp-server`，我在网上看别的都是`tftpd`大家自行斟酌）
   
2. 开启tftp服务，然后查看服务，这一点貌似都是一样的：
   ```bash
   systemctl start tftp.service
   systemctl status tftp.service
   ```
   其实目的是查看tftp的配置文件和根目录：
   
   ![](https://static01.imgkr.com/temp/40c7fb44c06444af8b1f1976ef13871d.png)
   图中`1`是tftp的配置文件所在，`2`是tftp的根目录，打开配置文件，修改根目录为自己想要的地方就行
   
   
### qemu+pmon+linux
OK，准备结束，正文开始，命令如下：
```bash
build4mips/mipsel-softmmu/qemu-system-mipsel -M ls1b -bios ../gzrom_ls1b.bin -serial stdio -m 2048 -smp 1 -net nic -nic user,net=10.20.4.0/24,host=10.20.4.16,tftp=/home/loongson/chip/
```
写成了代码格式，不知道大家能不能看完整吼吼吼就这样先～

稍作说明，`pmon`的加载和之前测试`pmon`的过程一样，区别在于增加了选项：
`-net nic -nic user,net=10.20.4.0/24,host=10.20.4.16,tftp=/home/loongson/chip/`

其中`-net nic -nic user`是增加了用户级网络配置，至于桥配置、tap配置等内容自行了解，我也不会。

后面的`net=10.20.4.0/24`是配置`qemu`的网络，其实不配这个好像也行，为什么说不配也行呢，因为`pmon`里还要重新配置，跟这个没关系，但是我不配就会失败……不明白，成功就行吧先

`host=10.20.4.16`是我的主机`ip`（内部机密，切勿泄漏）

`tftp=/home/loongson/chip/`是`tftp`的根目录，这个不配不行，不配的话在`pmon`里`load`的时候会显示没有权限。

经过上述的配置，进入到`pmon`的界面，跟之前介绍的`pmon`测试一样，但是这时，我们配置`pmon`的`ip`就可以和主机通信了：

1. 首先查看设备列表：
   
   ```
   devls
   ```
   
   选择带`net`字样的设备名词，我这里是`syn0`（不同设备好像不一样？我还没试过家里的电脑hhhh大家试一下）
   
2. 开启网络设备
   ```bash
   ifconfig syn0 up
   ```
   
3. 配置网络，这里当然要配置和主机`ip`同网段的地址，但是神奇的是，必须要把最后一位置`0`,比如我的`ip`是`10.20.4.16`,我给`pmon`配置`10.20.4.11`就不行，但是配置`10.20.4.0`就可以。

   还记得上面的命令是`net=10.20.4.0/24`，这里哪怕是改成`net=10.20.4.11/24`，在`pmon`里配置网络时也还是只有`10.20.4.0`可以，就很神奇。
   
   配置网络命令为：
   ```bash
   ifconfig syn0 10.20.4.0 netmask 255.255.254.0
   ```
   完整图示如下：
   ![](https://static01.imgkr.com/temp/6640dee8b412406c955afaa9eb1790da.png)
   其中`1`是开启网卡，`2`是配置网络，`3`是查看网络状态。
   
4. `load`内核
    首先我是把前面准备的内核文件`vmlinux`放在了`/home/loongson/chip/`目录下，也就是`tftp`服务器的根目录，所以`load`的时候如下即可：
    ```bash
    load tftp://10.20.4.16/vmlinux
    ```
    如下图，`load`成功
    ![](https://static01.imgkr.com/temp/972915aa819a43748bdffa6c3e7eba5b.png)

5. 进入`linux`系统
    大赛的发布包上一点和这一点都说的比较清楚了：
    
    ```bash
    g console=ttyS0,115200 rdinit=sbin/init
    ```
   其中`115200`是波特率，也就是`GS232`的串口波特率，咱们做系统调试的就不用改这个了。
   
    ![](https://static01.imgkr.com/temp/ef64b08f4efd4c91992269f5dcb103ff.png)
    看到`32`个寄存器的初始值了吧，跑了一大堆日志，然后就进入系统了：
   
    ![](https://static01.imgkr.com/temp/9d979c7416e5425e978fff38955cc105.png)
    完成。

## 调试
其实上面说的都是测试，调试的话是依赖于`qemu`的`gdb`支持，可以按行调试代码！不过上述测试就够我们开发了系统了。调试也就是锦上添花，如虎添翼，~~伤口撒盐~~

**那么如何调试呢?**

首先要会一点点`gdb`，本文不介绍。

一般的调试，在`qemu`命令行添加`-g 1234`之类的选项，就可以在另一个终端打开`gdb`，然后输入`target remote :1234`就可以调试了

调试系统内核，参考`https://www.cnblogs.com/powerrailgun/p/12161295.html`：

命令如下：

` build4mips/mipsel-softmmu/qemu-system-mipsel -M ls1b -bios ../gzrom_ls1b.bin   -serial stdio -m 4096  -net nic -nic user,net=10.20.4.0/24,host=10.20.4.16,tftp=/home/loongson/chip/ -smp 1 -S -gdb tcp::1235`

主要看最后的内容，`tcp::1235`和`-g 1235`是类似的。然后打开`gdb`调试，然后使用`ni`和`si`进行汇编级别的单步调试。



## 其他内容
网上有介绍别的可以调试内核的，我觉得吧，也挺麻烦的，而且线上的速度也不如本地调试快（其实`qemu`也用到了相关的子模块）。有兴趣可以参考：
[https://www.oschina.net/news/108450/linux-lab-0-2-rc1-released](https://www.oschina.net/news/108450/linux-lab-0-2-rc1-released)

还有内核的构建之类的，参考：
[https://blog.csdn.net/tongxin1101124/article/details/90213727](https://blog.csdn.net/tongxin1101124/article/details/90213727)

指令级调试：[http://happyseeker.github.io/virt/2017/07/06/qemu-i386-crash-in-linux-user-mode-on-loongson.html](http://happyseeker.github.io/virt/2017/07/06/qemu-i386-crash-in-linux-user-mode-on-loongson.html)

系统内核调试：[https://www.cnblogs.com/powerrailgun/p/12161295.html](https://www.cnblogs.com/powerrailgun/p/12161295.html)
