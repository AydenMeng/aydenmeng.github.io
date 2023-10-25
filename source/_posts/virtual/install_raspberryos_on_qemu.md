---
title: Ubuntu19.10使用Qemu安装树莓派
date:  2020-12-09 22:58:16
categories: [教程, Linux]
tags: [树莓派, Linux, Qemu, Ubuntu]
---


# Ubuntu19.10使用Qemu安装树莓派
> 之前一直是在Windows下鼓捣虚拟机，这次试试qemu

<!--more-->

## 安装

### 安装qemu
```shell
sudo apt install qemu
```
![](https://gitee.com/mxdon/img/raw/master/img/ac90e76e-456d-468b-a0d9-1ceba4b51e93.png)
### 安装树莓派
在github上找到相应版本的内核和设备树文件。
![](https://gitee.com/mxdon/img/raw/master/img/9daa7d40-b017-45ea-a4c6-ef36585853bf.png)
先创建一个项目目录，把镜像文件、设备树文件，和内核文件都放进去
![](https://gitee.com/mxdon/img/raw/master/img/f60a70ac-1dbd-4bda-8477-0262cb5fa05f.png)
然后`fdisk -l 2020-02-13-raspbian-buster.img`查看硬盘实体使用情况
![](https://gitee.com/mxdon/img/raw/master/img/c645d24a-54c2-48e9-9832-fb1b057b0e13.png)
将`img2`的起点地址乘以单元扇区大小，得到镜像应该挂载的偏移量。
![](https://gitee.com/mxdon/img/raw/master/img/bf603b12-b393-48af-a1bb-d6c6fa81c760.png)
`sudo mount -v -o offset=272629760 -t ext4 ~/qemu_raspi/2020-02-13-raspbian-buster.img /mnt/raspbian`其中的`/mnt/raspbian`文件夹要提前建好
![](https://gitee.com/mxdon/img/raw/master/img/f2b268bc-9d61-48e9-bb91-666fb14e9176.png)
接下来编辑`/mnt/raspbian/ld.so.preload`文件，将其中的内容注释（行首加“#”注释），然后使用umount卸载已经加载的文件系统

```
sudo umount /mnt/raspbian
```
然后执行模拟树莓派的命令，参考github上的说明：
![](https://gitee.com/mxdon/img/raw/master/img/a1d75ece-522a-4e83-a2a7-f45f72ba4682.png)
修改相关参数，最终命令如下：
```
qemu-system-arm -kernel ~/qemu_raspi/kernel-qemu-4.19.50-buster -cpu arm1176 -m 256 -M versatilepb -serial stdio -append "root=/dev/sda2 rootfstype=ext4 rw" -hda ~/qemu_raspi/2020-02-13-raspbian-buster.img -redir tcp:5022::22 -no-reboot
```
其中参数可以通过使用`qemu-system-arm -help | grep "\-参数"`的命令形式，查看命令的相关介绍：
![](https://gitee.com/mxdon/img/raw/master/img/7541d2b2-d89f-4c2e-847d-e289a8778e84.png)
> - -M：设定模拟的开发板类型. versatilepb 是 ARM Versatile Platform Board
	- -cpu：select CPU ('-cpu help' for list)——指定cpu类型，模拟ARM1176 CPU. Raspberry Pi 板上搭载了 Broadcom BCM2835, 这个处理器用的是ARM1176JZ-F.
	- -m：[size=]megs[,slots=n,maxmem=size]——RAM的大小是256MB. 设定成比256MB大的值板子好像不能启动.
	- -drive：[file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]——指定要制作文件、输入类型、……
	- -net：[user|tap|bridge|socket][,option][,option][,...](use the -netdev option if possible instead)——大概是网络连接的一些参数
	- -dtb：file    use 'file' as device tree image——是镜像文件解压出来有的一些文件，叫设备树引导文件，与内核文件共同编译成支持qemu启动的内核
	- -kernel：bzImage use 'bzImage' as kernel image——内核
    - -serial stdio——重定向Guest 的串口到Host的标准输入输出.
	- -append：cmdline use 'cmdline' as kernel command line——使用“ cmdline”作为内核命令行

然后便开始启动树莓派：
![](https://gitee.com/mxdon/img/raw/master/img/7a95fa3b-0c69-4323-be09-48241748af15.png)
这一步我还以为是创建用户，想了一大会密码，
![](https://gitee.com/mxdon/img/raw/master/img/4abfdaa8-cfc9-4089-9642-4a05fd2eabc8.png)
结果用户密码是固定的：用户名: pi, 密码: raspberry
![](https://gitee.com/mxdon/img/raw/master/img/67879246-8605-4fea-9af4-877b50ad2183.png)
终于登录成功了。
### 图形化界面
上面可以看到是没有图形化界面的，但是运行最开始时有写vnc的相关信息，所以再装一下vnc viewer
![](https://gitee.com/mxdon/img/raw/master/img/0b4efa23-fe41-4c69-9bc3-b29b8d76f926.png)
官网下载即可。
![](https://gitee.com/mxdon/img/raw/master/img/7413d847-95ac-45bf-b502-f4ddacda836a.png)
安装
![](https://gitee.com/mxdon/img/raw/master/img/1de786a3-cfb1-47dd-b0a6-b4b7ad2d8275.png)
软件自动显示了5900端口的树莓派
![](https://gitee.com/mxdon/img/raw/master/img/97206bcb-68bb-42fa-986d-ed95279ddcff.png)
但是还是没有图形界面显示
![](https://gitee.com/mxdon/img/raw/master/img/b69cce76-d4e4-428a-bbf9-921d0c02fd54.png)
参考其中的日志
![](https://gitee.com/mxdon/img/raw/master/img/e40bd7e6-14cf-4ed4-9fc6-64056b5c6d43.png)
经过排查，是内核文件不匹配造成的，这一点在提供内核的github界面也有说明，万能设备树文件支持的是`stretch`系列的树莓派
![](https://gitee.com/mxdon/img/raw/master/img/61d8a762-fdc0-43cf-abec-3fe18b35ce10.png)
所以更换镜像为：`2018-06-27-raspbian-stretch.img`，内核更改为：`kernel-qemu-4.14.79-stretch`，重新按照之前的步骤重复即可。最终打开图形界面：
![](https://gitee.com/mxdon/img/raw/master/img/81ae7a84-4328-419b-913a-f113625b7422.png)

## 下载
树莓派——清华开源软件镜像站：`https://mirrors.tuna.tsinghua.edu.cn/raspbian-images/raspbian/images/`

树莓派——树莓派实验室（好像是官网）：`https://shumeipai.nxez.com/download#os`

vncviewer：`https://www.realvnc.com/en/connect/download/viewer/`

## 参考文献
[QEMU搭建树莓派环境](https://blog.csdn.net/yalecaltech/article/details/90524245)
[使用qemu虚拟机运行树莓派(linux kernel 4.9)](https://blog.csdn.net/talkxin/article/details/79505826)
[Windows中使用QEMU创建树莓派虚拟机](https://blog.csdn.net/weixin_30256505/article/details/101739642)
[用QEMU模拟树莓派Raspberry Pi的方法](https://www.linuxidc.com/Linux/2014-08/105511.htm)
[qemu-rpi-kernel](https://github.com/dhruvvyas90/qemu-rpi-kernel)
[RASPBERRY PI ON QEMU](https://azeria-labs.com/emulate-raspberry-pi-with-qemu/)
[ubuntu下使用vnc viewer](https://www.cnblogs.com/penny772866/p/5927796.html)
