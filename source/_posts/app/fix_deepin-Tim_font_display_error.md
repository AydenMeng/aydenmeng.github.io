---
title: Linux入门的新方式
date: 2022-02-23 17:57:36
categories: [教程, Linux]
tags: [Linue, Ubuntu, Wine]
---
# 关于Deepin-wine Tim字体显示的问题

> 组装了新电脑，并且安装了ubuntu20.04，像往常一样，继续安装微信和Tim，但是遇到了Tim字体不显示的问题。~~其实微信也遇到了~~，简单介绍一下过程（~~没有时间~~）

## 安装deepin-wine的微信和Tim
参考链接：[https://github.com/zq1997/deepin-wine](https://github.com/zq1997/deepin-wine)

具体安装不再多做说明

## 微信的字体问题
微信默认使用微软雅黑，而且字体几乎没有新版和旧版的区别，直接从网上下载`msyh.ttc`到`/usr/share/fonts/`，然后`fc-cache -fv`刷新字体即可。重启微信，问题就解决了。

## TIM的字体问题
`Tim`用同样的方法并没能解决，至于网上说的一些手动注册的注册表方案也没有解决，是因为`win10`的`SimSun`字体相较于`win7`已经做了更新，`deepin-wine`已经无法正确识别并使用。所以换一下字体就好，但是网上的大多办法都没能解决我的问题，最后在`wiki`中发现了修改注册表的方法得以解决。说一下我的办法：

执行`env WINEPREFIX="~/.deepinwine/Deepin-TIM" deepin-wine6-stable regedit`打开注册表，把下图中的`MS Shell Dlg`的`两项`改成你想要的字体路径即可，这里我用的是微信同款`微软雅黑`。

![](https://gitee.com/mxdon/imgmdnice/raw/master/2022-2-23/1645622072051-1645622049(1).jpg)
## 参考文献
[http://linux-wiki.cn/wiki/Wine的中文显示与字体设置](http://linux-wiki.cn/wiki/Wine%E7%9A%84%E4%B8%AD%E6%96%87%E6%98%BE%E7%A4%BA%E4%B8%8E%E5%AD%97%E4%BD%93%E8%AE%BE%E7%BD%AE)

## 最后，点个关注不迷路

![](https://gitee.com/mxdon/imgmdnice/raw/master/2021-12-20/1639977405756-image.png)
