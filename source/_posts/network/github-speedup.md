---
title: GitHub访问加速
date: 2021-12-19 00:16:15
categories: [软件编程, Python]
tags: [爬虫, 脚本, Github]
---

> 由于近些年`GitHub`分发网络被`dns`污染严重，导致国内用户访问速度巨慢，解决方法也有不少，详情参考“**参考文献**中的内容”

## 加速方法

1. 使用镜像网站或代理网站
2. `cdn`加速
4. 转入`gitee`加速

## 使用镜像网站

镜像网站地址：

1. [https://github.com.cnpmjs.org/ ](https://github.com.cnpmjs.org/) (常用)
2. [https://hub.fastgit.org/](https://hub.fastgit.org/) (常用)
3. [https://gitclone.com/](https://gitclone.com/)
4. [https://github-dotcom.gateway.web.tr/](https://github-dotcom.gateway.web.tr/)
5. [https://hub.xn--p8jhe.tw/?imyshare.com=friends](https://hub.xn--p8jhe.tw/?imyshare.com=friends)
6. [https://hub.xn--gzu630h.xn--kpry57d/?imyshare.com=friends](https://hub.xn--gzu630h.xn--kpry57d/?imyshare.com=friends)
7. [https://gh.api.99988866.xyz/](https://gh.api.99988866.xyz/)
8. [https://toolwa.com/github/](https://toolwa.com/github/)
9. [https://ghproxy.com/](https://ghproxy.com/) (代理加速)
10. [https://www.7ed.net/gra/](https://www.7ed.net/gra/)  (raw加速)

## `CDN`加速

> **Hosts**是一个没有扩展名的[系统文件](https://baike.baidu.com/item/系统文件/7581367)，可以用记事本等工具打开，其作用就是将一些常用的网址[域名](https://baike.baidu.com/item/域名/86062)与其对应的[IP地址](https://baike.baidu.com/item/IP地址)建立一个关联“数据库”，当用户在浏览器中输入一个需要登录的网址时，系统会首先自动从[Hosts文件](https://baike.baidu.com/item/Hosts文件)中寻找对应的[IP地址](https://baike.baidu.com/item/IP地址)，一旦找到，系统会立即打开对应网页，如果没有找到，则系统会再将网址提交DNS域名解析服务器进行IP地址的解析。
>
> 需要注意的是，Hosts文件配置的[映射](https://baike.baidu.com/item/映射/20402620)是静态的，如果网络上的计算机更改了请及时更新IP地址，否则将不能访问。

`CDN`加速便是通过修改`Hosts`文件，绕过国内的`dns`解析，直达`github`的`ip`地址，从而加速访问。

以下三个网站是常用的访问链接：

1. `github.com`
2. `assets-cdn.github.com`
3. `github.global.ssl.fastly.net`

首先在网址：[https://www.ipaddress.com/](https://www.ipaddress.com/)中查询上述域名的`ip`地址，然后对应添加至Hosts中即可，如下图：

![image-20211219235834074](https://gitee.com/mxdon/imgmdnice/raw/master/image-20211219235834074.png)

![image-20211220000000715](https://gitee.com/mxdon/imgmdnice/raw/master/image-20211220000000715.png)

![image-20211220000031755](https://gitee.com/mxdon/imgmdnice/raw/master/image-20211220000031755.png)

**由于直接添加会有权限问题，所以先把`Hosts`文件复制到桌面上，然后把复制的文件修改以后，再替换回去即可。**

### 一个简单的爬虫脚本

由于每个人的位置不一样，所查询到的`ip`可能也不一样，而且`github`的主机自身可能也会变动`ip`，所以写了个简单的爬虫脚本处理了一下，运行以后复制进去就行，`Linux`用户直接用即可！(`full_domain`列表中是`github`中几乎全部会用到的域名，强迫症患者可以对应打开修改)

```python
import requests
import time
import sys
import random
import urllib3
from bs4 import BeautifulSoup

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

heads = {'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'}

# All the options
# full_domain = [github.githubassets.com, central.github.com, desktop.githubusercontent.com, camo.githubusercontent.com, github.map.fastly.net, github.global.ssl.fastly.net, gist.github.com, github.io, github.com, assets-cdn.github.com, api.github.com, raw.githubusercontent.com, user-images.githubusercontent.com, favicons.githubusercontent.com, avatars5.githubusercontent.com, avatars4.githubusercontent.com, avatars3.githubusercontent.com, avatars2.githubusercontent.com, avatars1.githubusercontent.com, avatars0.githubusercontent.com, avatars.githubusercontent.com, codeload.github.com, github-cloud.s3.amazonaws.com, github-com.s3.amazonaws.com, github-production-release-asset-2e65be.s3.amazonaws.com, github-production-user-asset-6210df.s3.amazonaws.com, github-production-repository-file-5c1aeb.s3.amazonaws.com, githubstatus.com, github.community, media.githubusercontent.com]

website = "https://websites.ipaddress.com/"
# Necessary options
des_domain = ["github.com","assets-cdn.github.com","github.global.ssl.fastly.net"]
des_ip = []

def getip(domain):
    url = website + domain
    try:	
        res = requests.get(url,timeout=30,headers=heads,verify=False)
        res.encoding = 'UTF-8'
        content = res.text
        #print(content)

        soup = BeautifulSoup(content,'html.parser')

        iplist = soup.find('ul',class_='comma-separated')
        iptmp = str(iplist.find("li").text) + "    " + domain
        print(iptmp)
    except:
        print("[\033[31m############   Something Error  #############\033[0m](\033[31m%s\033[0m)"% (url))
        iptmp = '' 

    des.write(iptmp + "\n")

if __name__ == '__main__':
    try:
        # Used in Windows
        # des = open("/mnt/c/Windows/System32/drivers/etc/hosts","a")
        # Used in Linux
        des = open("/etc/hosts","r")
        if "github" in str(des.readlines()):
            des.close()
            print("github dns configuration is already done!\n")
            sys.exit(0)

        des.close()
        des = open("/etc/hosts","a")
        print("# Add by mxdon, you can remove duplicate options manually\n")
        des.write("# Add by mxdon, you can remove duplicate options manually\n")
        for idomain in des_domain:
            getip(idomain)

    except:
        des.close()

```



## 转入`Gitee`加速

`gitee`可以直接将`github`或`gitlab`的仓库转入，所以只要知道想要访问的`github`地址，直接导入`gitee`即可：完成后访问速度超级快！！（已经操作过数十个项目啦~）

![image-20211220001157876](https://gitee.com/mxdon/imgmdnice/raw/master/image-20211220001157876.png)

如上图，一般比较有名的项目在`gitee`上已经被同步了，也可以直接用，但有时候不是最新的，有洁癖的朋友自行选择噢

## 参考文献

[github访问加速 - 知乎](https://zhuanlan.zhihu.com/p/75994966)
[提高国内访问 github 速度的 9 种方法！ - 知乎](https://zhuanlan.zhihu.com/p/314071453)
[Github RAW 加速服务 - 7ED Service](https://www.7ed.net/gra/)
[github 镜像站_CHAOS_ORDER的博客-CSDN博客_github镜像站](https://blog.csdn.net/CHAOS_ORDER/article/details/110811952)
[那些你用得上的镜像网站 - SegmentFault 思否](https://segmentfault.com/a/1190000023396995)
[hosts_百度百科](https://baike.baidu.com/item/hosts/10474546)

## 最后，点个关注不迷路

![](https://gitee.com/mxdon/imgmdnice/raw/master/640)
