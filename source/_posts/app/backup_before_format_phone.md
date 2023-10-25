---
title: 手机备份到底备份什么
date: 2021-12-05 22:59:33
categories: [教程, 刷机]
tags: [刷机, OPPO, 数据备份]
---


# 手机备份到底备份什么

> 手机太卡了，换不起手机，所以就备份一下，刷一下

## 起因

   ![image-20210206161820003](https://gitee.com/mxdon/img/raw/master/img/image-20210206161820003.png)

手机开始卡了，内存也严重不足了，当然我可以只备份，再挨个清理，但是哪有刷机来的轻巧，所以我选择刷机。

> 搞不明白，以前4+64和现在8+128有什么区别……内存大了，软件也大了，这扩容的钱不白花了？

## 准备

1. 申请深度测试权限

   OPPO没有深度测试权限是没办法刷的

    ![image-20210206162131950](https://gitee.com/mxdon/img/raw/master/img/image-20210206162131950.png)

2. 下载固件包，去官网下就行了

![image-20210206162435140](https://gitee.com/mxdon/img/raw/master/img/image-20210206162435140.png)

3. 备份

   备份什么呢？手机的文件那么多，如何快速有效的备份呢？

   作为本文的核心内容，单独开一章来讲

## 如何快速备份

全备份？请出去，你豪爽的行事风格已经与我白嫖和抠门的文章风格不一致了，如果你有部分备份的想法，再往下看

1. 有针对性

   首先备份的东西一定要有价值，以我的角度，就是**软件**、**文件**、**图片**、**有用的聊天记录**

2. 备份方式

   软件可以直接发送给自己的QQ小号，文件也是一样

   有用的聊天记录直接截屏，和图片一起打包备份，至于没用的图片，每次拍完照自己删啊同志们

### 开始备份

#### 文件备份

啊文件备份嘛，这个真没啥经验，因为我很少用手机存文件，大多数都是在电脑上，手机上即使存了，我也会很快删除，所以大家及时备份文件吧哈哈哈哈

#### 聊天记录备份

截图，转到下面图片备份(**别忘了短信备份**)

#### 图片备份

`5G`超能力可以在线备份，我的话会离线备份，打开`开发者选项`，打开`USB`调试，连接电脑，把文件提取到电脑上某位置，并打包成压缩包，我就不多演示啦

当你清理完垃圾图片以后应该就会有类似的干净文件夹，所以直接打包就好啦

![image-20210206190621107](https://gitee.com/mxdon/img/raw/master/img/image-20210206190621107.png)

#### 软件备份

由于安卓的软件管理机制，不太好找。

所以有两种方法：

1. 有`QQ`会员，把软件发送给小号

![image-20210206183929525](https://gitee.com/mxdon/img/raw/master/img/image-20210206183929525.png)

2. 没有`QQ`会员，可以选择用`一个木函`操作一下，选择把要备份的应用，挨个提取安装包，如下图所示：

![image-20210206183442163](https://gitee.com/mxdon/img/raw/master/img/image-20210206183442163.png)

![image-20210206184230051](https://gitee.com/mxdon/img/raw/master/img/image-20210206184230051.png)

当然也是支持多选的呀~

![image-20210206184838865](https://gitee.com/mxdon/img/raw/master/img/image-20210206184838865.png)

惊了，我这还是挑着备份的，`74`个应用！！

![image-20210206184915219](https://gitee.com/mxdon/img/raw/master/img/image-20210206184915219.png)

备份完成之后，会提示备份的位置：

![image-20210206185054608](https://gitee.com/mxdon/img/raw/master/img/image-20210206185054608.png)

然后软件备份，就懂了吧

![image-20210206185223274](https://gitee.com/mxdon/img/raw/master/img/image-20210206185223274.png)

像上面说的备份图片一样，把软件也备份到电脑上就行了

![备份过程截图](https://gitee.com/mxdon/img/raw/master/img/image-20210206191453636.png)

## 顺便说说OPPO Reno ACE的刷机

`ACE`刚出的时候还是挺香的，我又xx买了`OPPO`，不过好在申请上面说的深度测试不麻烦，所以深度测试申请完就没什么难的了，网上教程挺多的。简单说一下

1. 深度测试申请完成后，直接点击进入深度测试就可以进入`fastboot`了

2. 进入`fastboot`之后，手机不要动，安装电脑安装`adb`和`fastboot`工具之后，执行`fastboot flashing unlock`，手机会进入另一个画面，然后用音量键选择解锁`bootloader`即可，两张图如下：

   ![选择解锁--unlock the bootloader](https://gitee.com/mxdon/img/raw/master/img/image-20210206214020675.png)

3. 解锁之后，输入`fastboot devices`检查`ADB/FASTBOOT`是否装好，如下图

   ![fastboot检查手机连接](https://gitee.com/mxdon/img/raw/master/img/image-20210206214343955.png)

4. 装完以后用`fastboot flash recovery path/to/the/path/of/twrp.img`刷入第三方`rec`

   ![刷入第三方rec](https://gitee.com/mxdon/img/raw/master/img/image-20210206214245993.png)

5. 然后别忘了今天的目的，清理空间，所以选择格式化`Data`

   ![格式化data](https://gitee.com/mxdon/img/raw/master/img/image-20210206214522857.png)

   ![输入yes开始格式化data](https://gitee.com/mxdon/img/raw/master/img/image-20210206214705203.png)

6. 格式化完`data`以后，要重启`rec`，否则原先的加密`data`会重亲覆盖现在的`data`

   

7. 然后在电脑上把固件包和magic复制到手机存储目录（忘记截图，做完第八步就没了）

8. 刷入固件，重亲安装系统

   ![点击安装后，选择固件包](https://gitee.com/mxdon/img/raw/master/img/image-20210206215035175.png)

   ![刷入固件](https://gitee.com/mxdon/img/raw/master/img/image-20210206214814719.png)

9. 重启进入系统

   完成

## 备份恢复

上面说了信息的备份，那么如何快速恢复？

按照上面的划分：

- 文件类，直接在电脑上待着

- 图片，复制到手机的DCIM文件夹内即可

- 软件，可以用命令逐个安装：

  ```bash
  for file in `ls`;do adb install $file;echo $file; done
  ```

  注意`ls`两边的不是引号，是键盘上数字`1`旁边的那个英文符号

  ![adb批量安装软件](https://gitee.com/mxdon/img/raw/master/img/image-20210207195559464.png)
