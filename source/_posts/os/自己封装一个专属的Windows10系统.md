---
title: 自己封装一个专属的Windows10系统
date: 2021-12-05 22:59:33
categories: [教程, Windows]
tags: [系统封装, Windows]
---
# 自己封装一个专属的Windows10系统
## 设计
每次重装都要把软件重新整一遍，十分麻烦，所以就寻思着直接封装一个集成了软件的系统。但是为啥只预装这些软件呢，因为软件和系统更新换代快，没必要太多，另外我自己也没必要老是重装，给大家贡献一款上手就能用的方便系统玩玩得了。

<!--more-->

> 集成的软件从浏览器、到下载、到文件查找、到清理、卸载、安全，基本适用于各行各业的伙伴使用。至于开发，不会配置开发环境的话还干开发嘛？/滑稽



![预想效果](https://gitee.com/mxdon/img/raw/master/2020/20200404013123694.png)

## 使用NTLITE精简一个系统
下载：`https://www.ntlite.com/download/`
![](https://gitee.com/mxdon/img/raw/master/2020/20200331082105544.png)
![免费使用就足够了](https://gitee.com/mxdon/img/raw/master/2020/20200331082445844.png)

### 把系统ISO镜像解压
![](https://gitee.com/mxdon/img/raw/master/2020/20200331082936145.png)
添加镜像文件夹（不知道这里为啥不能直接添加ISO文件），然后就直接添加刚才解压的文件夹就好。
![](https://gitee.com/mxdon/img/raw/master/2020/20200331083226964.png)
删除不想要的系统版本
![](https://gitee.com/mxdon/img/raw/master/2020/20200331083435480.png)
双击加载所要精简的系统，或者选中后点击上面的加载。
![](https://gitee.com/mxdon/img/raw/master/2020/20200331084158489.png)
按照需求作如下更改：

 - 移除广告、闹钟、反馈、获取帮助、消息、人脉、Skype、你的手机、移动计划、钱包服务、游戏周边等选项及功能
 - 移除edge浏览器桌面快捷方式
 - 移除小娜
 - 关闭Windows Defender
 - 移除更新中的edge浏览器自动安装
 - 将“此电脑”、“控制面板”和“回收站”置于桌面
 - 禁用人脉功能
 - 自动显示文件后缀名

### 保存映像
点击开始，勾选**创建ISO**并命名（忘了截图，略）
![](https://gitee.com/mxdon/img/raw/master/2020/20200331095655129.png)
## 虚拟机配置
![创建虚拟机](https://gitee.com/mxdon/img/raw/master/2020/20200318214154707.png)
![自定义虚拟机即将安装的系统](https://gitee.com/mxdon/img/raw/master/2020/20200331110220928.png)
![选新的，因为我用的就是14版本的](https://gitee.com/mxdon/img/raw/master/2020/20200331110233911.png)
由于需要进入审核模式，所以这里务必要选择稍后安装操作系统。
![稍后安装操作系统](https://gitee.com/mxdon/img/raw/master/2020/20200331110324553.png)
![其他的64位，不知道别的选项会不会有影响，为了干净，就选其他的](https://gitee.com/mxdon/img/raw/master/2020/2020033111040233.png)
![选择创建位置及名字](https://gitee.com/mxdon/img/raw/master/2020/20200331110549626.png)
![配置处理器](https://gitee.com/mxdon/img/raw/master/2020/20200331110747827.png)
我的电脑有16G内存，所以这里分配了4G的虚拟机内存，仅供参考
![配置内存，一般为物理机的一半](https://gitee.com/mxdon/img/raw/master/2020/20200331110855153.png)
封装系统不需要网络连接
![不使用网络连接](https://gitee.com/mxdon/img/raw/master/2020/20200331110958212.png)
默认即可
![IO控制器](https://gitee.com/mxdon/img/raw/master/2020/2020033111101289.png)
![虚拟磁盘](https://gitee.com/mxdon/img/raw/master/2020/20200331111022307.png)
分配25G硬盘空间
![分配25G空间](https://gitee.com/mxdon/img/raw/master/2020/20200331111102786.png)
![默认命名，与之前设置的位置相同](https://gitee.com/mxdon/img/raw/master/2020/20200331111126610.png)
![](https://gitee.com/mxdon/img/raw/master/2020/20200331111243332.png)

## 使用虚拟机进入审核模式
在**虚拟机-设置**选择使用NTLITE精简的系统镜像，点击**确定**
![](https://gitee.com/mxdon/img/raw/master/2020/2020033111183925.png)
然后开启虚拟机，进入系统安装界面
![](https://gitee.com/mxdon/img/raw/master/2020/20200331111936688.png)
接受条款，进入下一步
![接受条款，进入下一步](https://gitee.com/mxdon/img/raw/master/2020/20200331112054150.png)
选择安装位置，点击下一步
![默认安装位置](https://gitee.com/mxdon/img/raw/master/2020/20200331112124662.png)
帖子里说在如下界面按快捷键进入审核模式，但是我没有见到这个界面，随便按了两下就进来了。。。
![远景的帖子](https://gitee.com/mxdon/img/raw/master/2020/2020033112070260.png)
![审核模式](https://gitee.com/mxdon/img/raw/master/2020/20200331120807806.png)
> 后来经过多次尝试，除了上面的接受协议，等到界面不再让你选择的时候按快捷键就行，你品，你细品
## 集成软件
选择**取消**退出系统准备工具，然后就可以进行软件的集成了。
这里我准备了之前总结过的各类软件，分别是：

 - 杀毒——火绒
 - 卸载——geek
 - 下载——fdm
 - 清理——dism++
 - 浏览器——谷歌浏览器（使用免安装版谷歌打包了一些网站和插件，看图标你懂的）![](https://gitee.com/mxdon/img/raw/master/2020/20200403153343565.png)
 - 工具——everything
 - 解压——bandzip

然后将软件打包成镜像文件，在虚拟机设置中——将ISO镜像文件设置替换之前的系统镜像。

![这个地方](https://gitee.com/mxdon/img/raw/master/2020/c782657a-5ba2-44e2-9fa6-94742ee7a6ca.png)

然后在虚拟机中进行安装即可。

## 设置
使用软媒魔方进行部分设置。内容如下图所示：
![去除快捷方式上的箭头之类](https://gitee.com/mxdon/img/raw/master/2020/20200403235640406.png)
oem信息：设置为：mxdon
一些设置优化：
![设置oem厂商为Mxdon](https://gitee.com/mxdon/img/raw/master/2020/20200404002249403.png)
最后安装出的效果预想：
![好看嘛](https://gitee.com/mxdon/img/raw/master/2020/20200404013123694-1586100907192.png)
## 封装
重启虚拟机，勾选“通用”，关机选项选择**关机**
![选关机比较稳](https://gitee.com/mxdon/img/raw/master/2020/2020040423293748.png)
![等待](https://gitee.com/mxdon/img/raw/master/2020/20200404232914246.png)
替换镜像为pe，打开电源事进入固件，调整cd-rom为第一启动选项
![替换pe系统镜像，这里使用技术员pe](https://gitee.com/mxdon/img/raw/master/2020/20200404232529284.png)
![防止热键没办法进BIOS然后直接进系统](https://gitee.com/mxdon/img/raw/master/2020/20200404234452745.png)
![调整引导顺序](https://gitee.com/mxdon/img/raw/master/2020/20200404234632900.png)
在pe种打开dism++
![pe中的dism++](https://gitee.com/mxdon/img/raw/master/2020/2020040423475695.png)
根据大小选定“会话”
![选择系统盘中的系统进行清理](https://gitee.com/mxdon/img/raw/master/2020/20200404235021875.png)

**删除`Administrator`以及`defaultuser0`文件夹。**

打开运行，输入命令：

`dism /capture-image /capturedir:D:\ /imagefile:E:\ABC.wim /name:"Windows1909_Professional_By_Mxdon" /compress:maximum`

其中`D`是我的系统盘，`E`是`wim`
文件导出的路径`Windows1909_Professional_By_Mxdon`是卷标，`ABC`是`wim`名，`maximum`代表最大压缩（微软的方式），默认是`fast`（如果还有更改需求的话可以用fast）
完成后**关闭虚拟机**，用`7zip`打开虚拟机文件，比如我的是`1909.vmdk`根据文件大小，可知我导出的`E:\ABC.wim`应该在`2.ntfs`下，相当于其中的E盘
![7zip打开虚拟机的vmdk文件](https://gitee.com/mxdon/img/raw/master/2020/20200405004934184.png)
打开`2.ntfs`，可以把`wim`文件导出
![把wim文件解压出来](https://gitee.com/mxdon/img/raw/master/2020/20200405005005202.png)

重命名为`install.wim`这样得到一个`wim`文件就就算封装完成了。

## 一些问题

- wim文件貌似只能使用pe带的安装器安装，无法直接通过Windows平台安装。**可以通过整合到ISO镜像中解决**
- 在将wim文件重新整合到ISO镜像中进行安装时，无法显示可用的映像。**可用通过编辑source文件夹下EI.cfg文件解决**
![](https://gitee.com/mxdon/img/raw/master/2020/9b0d00f0-5587-46c2-aa32-bcd505a15ad7.png)
![](https://gitee.com/mxdon/img/raw/master/2020/a65d3f75-8a2f-480c-9ea2-fbaf34b1aa9a.png)
- 编辑EI.cfg文件没能解决问题，然后就不想试了，以后有机会再玩吧。
- 封装的系统安装后桌面不是预先设置的那样，手动放在桌面的快捷方式也没了。**应该是在pe中清理的过头了**不整了。（封装的软件在`C:\dir_install`文件夹下~里面还有Windows永久激活工具噢~，背景图片在`C:\windows\background.jpg`)

## 下载
NTLITE：`https://www.ntlite.com/download/`

7zip:`https://sparanoid.com/lab/7z/`

VMware:`http://www.xue51.com/search.asp?wd=VMware`

软媒魔方：`https://mofang.ruanmei.com/`

**系统中集成的软件**：

火绒：`https://www.huorong.cn/person5.html`

bandzip：`https://www.bandisoft.com/bandizip/`

fdm：`https://www.freedownloadmanager.org/zh/`

geek：`https://geekuninstaller.com/`

everything：`https://www.voidtools.com/zh-cn/`

绿色版谷歌浏览器：`https://pan.baidu.com/s/1sVQgF01_Ekqxg-657ugS7w` 
提取码：`qrgh`

**最终封装出的`wim`文件**：`https://pan.baidu.com/s/1ryWEjl4bqn23G3vVd55zLA `
提取码：`04xc` 

## 参考文献
[零基础学封装系统-Windows封装教程-定制属于你自己的系统-Windows 7篇](https://www.bilibili.com/video/BV1ib411g7Sd?p=8)
[最强Win10优化-NtLite作业，快来抄啊](https://www.bilibili.com/video/BV1Gb41117pt)
[Windows 10简易精简封装教程](http://bbs.pcbeta.com/forum.php?mod=viewthread&tid=1757374&highlight=%B7%E2%D7%B0)
[16353自制64位中国版五合一镜像 附教程](http://bbs.pcbeta.com/viewthread-1756381-1-1.html)
[最新WIN10系统封装教程2019系列](https://blog.csdn.net/weixin_43707156/article/details/99223157)
[合并Windows系统镜像教程](https://www.cnblogs.com/jairkong/p/3738387.html)
[win7系统封装wim教程](https://wenku.baidu.com/view/c57dcab783c4bb4cf6ecd152.html)
[[Windows] 【浏览器】谷歌浏览器绿色免安装版，可装非C盘](https://www.52pojie.cn/thread-1125559-1-1.html)



## 往期回顾

- [电脑必备软件清单5——清理类](http://mp.weixin.qq.com/s?__biz=MzI4NDkzNTA3NQ==&mid=2247485346&idx=1&sn=639d4dd4bd8a1492fdcdd91144506fd5&chksm=ebf2916edc8518788b864d91de200bc06e48c8f9a54b3ff1e0282df5b768f76f2f888b24b51c&scene=21#wechat_redirect)
- [电脑必备软件清单4——杀毒类](http://mp.weixin.qq.com/s?__biz=MzI4NDkzNTA3NQ==&mid=2247485336&idx=1&sn=01a7a8141dd3e18442a6bd39627f7942&chksm=ebf29154dc85184296521ad90569d6769eed0b892acc5b5c291c9e2f134ee6264742a9d8f0e8&scene=21#wechat_redirect)
- [电脑必备软件清单3——下载类](http://mp.weixin.qq.com/s?__biz=MzI4NDkzNTA3NQ==&mid=2247485304&idx=1&sn=5d04fd640b2eaebbcf2be83385908a08&chksm=ebf291b4dc8518a28784a429ac7fda02dbd11791b05abe238a1f8866b0f70698ca152853d309&scene=21#wechat_redirect)
- [电脑必备软件清单2——工具类](http://mp.weixin.qq.com/s?__biz=MzI4NDkzNTA3NQ==&mid=2247485289&idx=2&sn=50e6a793257082ce4e2130492159f5a3&chksm=ebf291a5dc8518b345fe189aadc5ae55ff94799b5ee53384e1a9c94bdbef45a5a9f51194f332&scene=21#wechat_redirect)
- [电脑必备软件清单1——卸载类](http://mp.weixin.qq.com/s?__biz=MzI4NDkzNTA3NQ==&mid=2247485254&idx=1&sn=942e25584d1fb75198fbf39b1462fddb&chksm=ebf2918adc85189c0345f1fb7a5147130bdf76f4245b7a61859147838484490931dec13aeed5&scene=21#wechat_redirect)

# 最后，点个关注不迷路

<img src="https://gitee.com/mxdon/img/raw/master/2020/640" alt="null" style="zoom: 48%;" />

<img src="https://gitee.com/mxdon/img/raw/master/2020/00D0202D97CDF9F318D419116E03C5FA.jpg" alt="img" style="zoom: 33%;" />
