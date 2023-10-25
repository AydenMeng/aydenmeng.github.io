---
title: Java环境变量配置超详细教程
date: 2019-01-15 17:03:22
categories: [教程, Windows]
tags: [Java, 教程, 环境变量]
---

# 概述

Java的环境配置并不是特别难，但是对刚上手的新手来说确实是一个大问题

<!--more-->

首先下载jdk安装包[网址](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)进去选择自己需要的版本下载就行了，这里演示的是jdk-8u131-windows-x64_8.0.1310.11，版本稍老，道理一样
## 安装
下载后直接双击运行，这时会让你选择安装路径
![](/images/Java环境变量配置超详细教程/image1.png)
![](/images/Java环境变量配置超详细教程/image2.png)
默认是C盘，这里改成自己想要存放的地方，我放在了我D盘的ROUTE文件夹下的java目录下的jdk1.8.0_131
![](/images/Java环境变量配置超详细教程/22.png)
然后点击确定，下一步，开始跑进度条，但是不一会就会弹窗出来jre的安装路径
![](/images/Java环境变量配置超详细教程/image3.png)
我们点击更改，然后选择一个别的文件夹,我这里放在了java文件夹下的jre1.8文件夹，因为老放C盘等C盘满了就很麻烦，所以做好分类条理清晰点用着也舒服。
![](/images/Java环境变量配置超详细教程/image4.png)
然后点击下一步
![](/images/Java环境变量配置超详细教程/image5.png)
接着等待跑进度条，分分钟完事
![](/images/Java环境变量配置超详细教程/image6.png)
然后就安装结束了，点击完成即可
![](/images/Java环境变量配置超详细教程/image7.png)

## 环境变量的配置
接下来就是环境变量的配置

首先右键此电脑，选择属性
![](/images/Java环境变量配置超详细教程/23.png)
点击左侧的高级系统设置
![](/images/Java环境变量配置超详细教程/24.png)
点击环境变量
![](/images/Java环境变量配置超详细教程/25.png)
在下方的系统变量中点击新建
![](/images/Java环境变量配置超详细教程/image8.png)
新建变量名为JAVA_HOME
变量值我们点击浏览目录，选择jdk的安装路径jdk1.8.0_131文件夹
然后点击确定
![](/images/Java环境变量配置超详细教程/image9.png)
![](/images/Java环境变量配置超详细教程/image10.png)
![](/images/Java环境变量配置超详细教程/image11.png)
到这里还没有完成，别着急
然后我们还要继续新建一个环境变量
变量名为CLASSPATH
变量值为

```
.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
```
%之间的相当于一个路径的绝对引用，好处是如果你想给别人演示一遍这个教程，只需要重新安装一边jdk，环境变量重新说说就行了
当然你也可以自己选择浏览文件，这里不做过多演示
![](/images/Java环境变量配置超详细教程/image12.png)
到这里还是没有完成
接下来配置系统变量path，这里有点东西要注意，一不小心就出错

### path系统变量的配置
#### 先按做一遍错误示范
我们点击path环境变量进行编辑
![](/images/Java环境变量配置超详细教程/image13.png)
然后点击右侧的编辑
![](/images/Java环境变量配置超详细教程/image14.png)
在编辑框的后面输入

```
;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;
```
注意：符号都是英文符号
然后点击确定，确定，确定，直到退出环境变量的设置的地方，这就算是配置完成了
这时候如果打开cmd小黑框进行验证环境变量是否配置成功的话，分别输入java、javac、java -version再分别回车，但是javac的回车后面会报错，这里暂时先不放图片了
#### 接下来做正确示范
在按照上述错误做法进行的时候我们退出来可以发现path系统变量的值多了一个双引号
![](/images/Java环境变量配置超详细教程/image16.png)
所以我们只需要再次点击编辑，然后点击编辑文本
![](/images/Java环境变量配置超详细教程/image17.png)
接下里窗口会变成下图这样，我们移动光标找到两个双引号并删除就ok了
![](/images/Java环境变量配置超详细教程/image18.png)
当然，如果没有按照错误的做法来做的话，直接点击编辑文本，然后把;%JAVA_HOME%/bin;%JAVA_HOME%/jre\bin;输入进去当然就直接ok了

##### ps：貌似win7系统可以直接点编辑就有编辑文本的效果
## 检查是否安装成功
打开cmd，下面三种命令同时成功才算是真正的成功，否则还是无法使用。
输入java回车出现类似下图即为成功
![](/images/Java环境变量配置超详细教程/image19.png)
输入javac回车出现类似下图即为成功
![](/images/Java环境变量配置超详细教程/image20.png)
输入java -version回车出现类似下图即为成功
![](/images/Java环境变量配置超详细教程/image21.png)
