---
title: 远程控制——内网穿透篇
date:  2020-12-09 22:58:16
categories: [教程, 工具]
tags: [内网穿透]
---

[toc]

## 前言

> 因为某些原因，想要远程控制自己的电脑，但是公司条件不允许常规的远程软件，所以就想到了利用`内网穿透`+`ssh`进行简单的远程操作，起码传输文件和项目编译都会稍微方便一点点～

**说明，本文选择使用`cpolar`进行测试，为了排除局域网的可能性干扰，本文测试环境为**：

受控端：`ubuntu20.04`

![ubuntu](https://gitee.com/mxdon/img/raw/master/2021/image-20210109170919872.png)

![ubuntu的ip地址](https://gitee.com/mxdon/img/raw/master/2021/image-20210109180844181.png)

控制端：`Android-Termux`

![Termux](https://gitee.com/mxdon/img/raw/master/2021/image-20210109171313732.png)

![手机的ip地址](https://gitee.com/mxdon/img/raw/master/2021/image-20210109180955289.png)

## 内网穿透

- 开通帐号

  ![](https://gitee.com/mxdon/img/raw/master/2021/image-20210109173503110.png)

  ![注册信息](https://gitee.com/mxdon/img/raw/master/2021/image-20210109173547142.png)

​	记录下这一步是因为有的软件需要**实名认证**，而有的不需要，侧面也反映一些问题，大家自己品就好了～

​	注册账户基本是必要的，所以有**互联网洁癖**的同志可以注意一下;

- 注册完成后选择免费套餐即可

  ![套餐选择](https://gitee.com/mxdon/img/raw/master/2021/image-20210109174905804.png)

- 下载软件

  ![cpolar下载项](https://gitee.com/mxdon/img/raw/master/2021/image-20210109175131481.png)

​	如果没注册的话，可以从这里直接下载

​	![首页下载](https://gitee.com/mxdon/img/raw/master/2021/image-20210109173344438.png)

### 使用方式

如图，下载之后还是需要在登录后的“**仪表盘**”界面找到使用方法和`token(authtoekn)`，有的网站可能叫“**控制台**”或者“**我的隧道**”;

![使用教程](https://gitee.com/mxdon/img/raw/master/2021/image-20210109175354731.png)

第二步：在`window`可以直接右键解压，`linux`或`MacOS`的话可以使用命令解压（其实右键也可以，提前给文件`chmod 777`、`chown $user`也可以右键解压）

比如我把软件解压到`/opt/cpolar`下

![解压与使用](https://gitee.com/mxdon/img/raw/master/2021/image-20210109181301477.png)

第三步：连接账户，只要把上图中步骤三的命令复制下来，在命令行中执行即可，需要注意的是，要在文件解压的环境下执行，比如说我把文件下载并解压到`/opt/cpolar`下，那么就在`/opt/cpolar`这执行命令：

![初次执行](https://gitee.com/mxdon/img/raw/master/2021/image-20210109182439411.png)

如上图，在linux下可能会有执行权限的问题，所以再执行一下`sudo chmod a+x cpolar`就好啦～

这时显示配置文件已保存，所以接下来的执行就可以看第四步啦～

- 运行

  由于每种软件的运行方式多少都会有些不一样，所以建议大家看一下操作文档，比如官网的文档，绝大多数的产品都会附赠操作文档，所以有什么问题要优先阅读文档！

  ![官网的文档](https://gitee.com/mxdon/img/raw/master/2021/image-20210109182809962.png)

  通过阅读文档知道要使用`./cpolar tcp 22`命令来将本地的`22`端口（`ssh`的默认监听端口）映射到公网上，所以我们来试一下：

  ![执行结果](https://gitee.com/mxdon/img/raw/master/2021/image-20210109183246425.png)

  执行之后出现了这样的界面，红框中的链接就是我需要的公网链接！

### 连接成功

![连接成功](https://gitee.com/mxdon/img/raw/master/2021/image-20210109185121822.png)

由于使用电脑截图手机，清晰度和完整度不方便同时兼顾，大家凑合看吧～

首先是第一行，`ssh`就是我此次要达到的目的，远程登录无界面的的操作台，`-p`代表端口，后面的`10218`就是上面执行`cpolar`时产生的端口号（**免费用户每次开启的端口是随机的，~~所以我一般都不关~~**），`mxdon`是我的用户名，`@+网址`是固定搭配了。这样可以看到下面，已经是我`ubuntu`的界面啦～远程操作也就完成啦～

### 远程桌面

其实远程控制桌面也是可以的，`windows`下默认的远程端口是`3389`，只要执行`.cpolar tcp 3389`即可通过相应的方式远程控制，由于我手机里的`Termux`没有安装图形化控制界面，所以这里就不演示了，感兴趣的同学完全可以~~收买我做教程~~看看别的教程hhhhh

