---
title: run linux on loongson_FPGA
date: 2020-08-13 22:12:19
categories: [嵌入式, Linux]
tags: [龙芯, Linux]
cover: 
---

# 必读

## 1、运行要求

以下例子是ucore移植过程示例，Soc要求为较完备的SoC ：集成 DDR3控制器以连接DDR3颗粒 为内存；集成串口控制器以进行交互；其他可选模块可扩展SoC的功能 ，如网口、 VGA等

<!--more-->

cpu务必实现tlb指令及tlb模块，cache指令和cache模块不必实现

交叉编译工具编译ucore

> 理论上来说，Soc应该都具备以上要求，cpu也实现了tlb，交叉工具在北航实验中已经用到，系统已经编译完成，先不用考虑。

## 2、系统编译

ucore编译后的目标文件是obj/ucore-kernel-initrd，即内核文件，对比北航的系统应该是仿真文件vmlinux文件，都是elf文件，先这么猜着。（没错，后文已经证实！）

## 3、运行系统

先运行pmon，再通过网卡加载ucore至内存，再通过pmon调试（串口之类的），

可以将ucore的elf文件转换为coe文件，应该要用到交叉编译环境mipsel-linux-，这样可以直接使用ram引导系统，我觉得没必要吧，而且没有参考示例，不稳……

# 软件准备

## 0、串口软件

直接用Windows下环境，SecureCRTP串口软件（D:\fdm_download\nscscc2020_group_v0.01\soc_run_os_v0.01\lab_environment_v1.00\uart_soft\SecureCRTPortable）

![image-20200814000018297](/images/run-linux-on-loongson-FPGA/image-20200814000018297.png)

## 1、搭建Tftp服务器

**win10直接打开如下文件即可**

D:\fdm_download\nscscc2020_group_v0.01\soc_run_os_v0.01\lab_environment_v1.00\tftp\tftpd32.450

![image-20200814000508515](/images/run-linux-on-loongson-FPGA/image-20200814000508515.png)

# 运行Linux

## 1、烧写pmon

![image-20200814001801521](/images/run-linux-on-loongson-FPGA/image-20200814001801521.png)

> 其中烧写进flash的bit文件应该是`D:\fdm_download\nscscc2020_group_v0.01\soc_run_os_v0.01\lab_environment_v1.00\flash_programmer\programmer_by_uart`下的programmer_by_uart.bit文件（没错！）![image-20200814010553766](/images/run-linux-on-loongson-FPGA/image-20200814010553766.png)
>
> 使用vivado的open hardware manager，串口软件Secure（上面有说明）![image-20200814010517873](/images/run-linux-on-loongson-FPGA/image-20200814010517873.png)

### 1.1、烧写soc_up

下载bit流文件参考vivado使用说明1.6节，原文有错，这里刚好可以理解出该soc_up_33M.bit流文件为soc生成的，这里可以先使用gs132的试一下？

这样就可以运行pmon了，波特率设置为57600，

> 这里可以把bit文件转mcs文件固化进FPGA的SPI flash的方法，就不用重新导入了，这个等仿真完了再尝试。



## 2、运行Linux的方法

- 1.启动pmon，通过网口load Linux内核进入FPGA上的DDR3内存上，命令为`load tftp://服务器IP/vmlinux`
- 2.在教学soc上，波特率为115200，与pmon不同
- 3.启动pmon后给开发板网卡配置同网段IP

![image-20200814001121698](/images/run-linux-on-loongson-FPGA/image-20200814001121698.png)

- 4.加载内存到NandFlash

  ![image-20200814001445310](/images/run-linux-on-loongson-FPGA/image-20200814001445310.png)

> 过程中需要的文件：
>
> - ucore编译后的目标文件是obj/ucore-kernel-initrd，即内核文件，对比北航的系统应该是仿真文件vmlinux文件，都是elf文件，先这么猜着。（没错，后文已经证实！）
> - 其中烧写进flash的bit文件应该是`D:\fdm_download\nscscc2020_group_v0.01\soc_run_os_v0.01\lab_environment_v1.00\flash_programmer\programmer_by_uart`下的programmer_by_uart.bit文件（没错！）
> - 下载bit流文件参考vivado使用说明1.6节，原文有错，这里刚好可以理解出该soc_up_33M.bit流文件为soc生成的，这里可以先使用gs132的试一下？（不太确定）
