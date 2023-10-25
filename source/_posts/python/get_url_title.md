---
title: 自动获取参考链接的标题
date: 2021-12-05 22:59:33
categories: [软件编程, Python]
tags: [爬虫, 脚本]
---
# 自动获取参考链接的标题

> 众所周知，我也是一个~~托更的~~自媒体的创作者

写的文章经常需要提及一些参考文章，大多数来源于互联网，如下图：

![上上次文章的参考文献](https://gitee.com/mxdon/img/raw/master/img/image-20210112223039400.png)

看着感觉还行吧，但是写的时候真的是有点头大，一遍一遍的复制链接，再一遍一遍的对应链接去复制标题，十分的不银杏～

于是懒人总算想起来写一个爬虫脚本直接获取不就完事了吗？

说干就干：

啊完成了：

```python
import requests
import time
import random
import urllib3
from bs4 import BeautifulSoup

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning) # 防止ssl请求报错

heads = {'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'}

src = open("link2md.txt","r")
des = open("res.txt","w")

lines = src.readlines()

for line in lines:
    
    url = line.strip("\n").replace(" ","") # 把文件里的链接去除一些不必要的符号
    try:	
        res = requests.get(url,timeout=30,headers=heads,verify=False)
        res.encoding = 'UTF-8' # 解码
        content = res.text
        soup = BeautifulSoup(content,'html.parser') # 获取网页

        target = soup.find('title') # 获取标题
        result = "["+target.text+"]("+url+")\n"

        print("[\033[32m%s\033[0m](\033[34m%s\033[0m)" % (target.text,url) ) # 彩色打印
        des.write(result)
        #time.sleep(random.random()*3)
        #time.sleep(0.1)   # 如果爬的太快，可以定义一下爬取时间
    except:
        print("[\033[31m############   Something Error  #############\033[0m](\033[31m%s\033[0m)"% (url)) # 彩色打印
        continue

src.close()
des.close()
```

## 使用

1. 把参考链接写入到`link2md.txt`的文件中

   ![参考链接](https://gitee.com/mxdon/img/raw/master/img/image-20210125234247025.png)

2. 运行

   ```python
   python3 link2md.py
   ```

3. 完成

   ![控制台打印输出](https://gitee.com/mxdon/img/raw/master/img/image-20210125234627855.png)

   文件中也有写入正确的结果：

   ![写入文件的结果](https://gitee.com/mxdon/img/raw/master/img/image-20210126000237981.png)

## 其他

本来还想封装成跨平台的小软件，算了算了，凑合用吧～

> 如果有同学想封装，再可视化一下，记得发我一份谢谢～

