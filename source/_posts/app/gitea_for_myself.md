---
title: 个人git仓库搭建过程
date: 2022-01-22 17:57:36
categories: [教程, Git]
tags: [Git, Linux, 教程]
---
# 个人git仓库搭建过程


## 准备

1. gitea——gitea是一款轻量开源git服务器，可以在本地搭建。

2. mysql——gitea需要数据库支持，mysql对个人用户比较方便。

## 搭建

### mysql

由于服务器没有root权限，所以数据库需要非root用户安装，可以参考：[https://cloud.tencent.com/developer/article/1583129](https://cloud.tencent.com/developer/article/1583129)

> PS: 如果有root权限的话完全不必这么麻烦～

下载过程省略

配置文件：
```
[client]                                                                                                                                                                                      
port=3333
socket=/home/mxdon/gitea/mysql/mysql.sock

[mysqld]
port=3333
basedir=/home/mxdon/gitea/mysql
datadir=/home/mxdon/gitea/mysql/data
pid-file=/home/mxdon/gitea/mysql/mysql.pid
socket=/home/mxdon/gitea/mysql/mysql.sock
log_error=/home/mxdon/gitea/mysql/error.log
server-id=100
```

> 注意：由于3306端口常被占用，需要更改

启动命令
```
/home/mxdon/gitea/mysql/bin/mysqld_safe --defaults-file=/home/mxdon/gitea/mysql/my.cnf --user=mxdon
```

> 注意：这里的user是mysql的主机用户，与文件夹的拥有者不同

### gitea

启动命令
```
/home/mxdon/gitea/gitea web -p 5000
```

-p 指定http访问端口，默认是3000

然后打开15.2.5.5:5000网址，即可进行图形配置，这里只放出ini文件：


```
APP_NAME = mxdon资料共享
RUN_USER = mxdon
RUN_MODE = prod

[security]
INTERNAL_TOKEN     = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYmYiOjE2MzY0NDM5MzB9.LyfUN-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
INSTALL_LOCK       = true                                                                                                                                                                     
SECRET_KEY         = okb73n7MVPRTC1UAeIlxxxxxxxxxxxxxxxxxxxxxxxfunuGv7tPVRQD9CvJMQGFv
PASSWORD_HASH_ALGO = pbkdf2

[server]
LOCAL_ROOT_URL   = http://localhost:5000/
SSH_DOMAIN       = 15.2.5.5
DOMAIN           = 15.2.5.5
HTTP_PORT        = 5000
ROOT_URL         = http://15.2.5.5:5000/
DISABLE_SSH      = false
SSH_PORT         = 22
LFS_START_SERVER = true
LFS_CONTENT_PATH = /home/mxdon/gitea/data/lfs
LFS_JWT_SECRET   = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxQ6N80
OFFLINE_MODE     = false

[database]
DB_TYPE  = mysql
HOST     = 15.2.5.5:3333
NAME     = gitea
USER     = mxdon
PASSWD   = mxdon123
SCHEMA   = 
SSL_MODE = disable
CHARSET  = utf8
PATH     = /home/mxdon/gitea/data/gitea.db
LOG_SQL  = false

[repository]
ROOT = /home/mxdon/gitea/data/gitea-repositories

[mailer]
ENABLED = false

[service]
REGISTER_EMAIL_CONFIRM            = false
ENABLE_NOTIFY_MAIL                = false
DISABLE_REGISTRATION              = false
ALLOW_ONLY_EXTERNAL_REGISTRATION  = false
ENABLE_CAPTCHA                    = false
REQUIRE_SIGNIN_VIEW               = false
DEFAULT_KEEP_EMAIL_PRIVATE        = false
DEFAULT_ALLOW_CREATE_ORGANIZATION = true
DEFAULT_ENABLE_TIMETRACKING       = true                                                                                                                                                      
NO_REPLY_ADDRESS                  = noreply.localhost

[picture]
DISABLE_GRAVATAR        = false
ENABLE_FEDERATED_AVATAR = true

[openid]
ENABLE_OPENID_SIGNIN = true
ENABLE_OPENID_SIGNUP = true

[session]
PROVIDER = file

[log]
MODE      = console
LEVEL     = info
ROOT_PATH = /home/mxdon/gitea/log
ROUTER    = console
```

> 注意，其中mysql的账户需要有远程访问的权限，并建议新建数据库gitea用作gitea服务器交互，配置过程如下，其中先设权限后建数据库，以防数据库被弄脏使索引不匹配

```
mysql> GRANT ALL ON *.* TO 'mxdon'@'%';
mysql> create database gitea;
mysql> flush privileges;
```

使用如下命令查看，可以验证：
```
mysql> use mysql;
mysql> select user, host from user;
+---------------+-----------+
| user          | host      |
+---------------+-----------+
| mxdon         | %         |
| mysql.session | localhost |
| mysql.sys     | localhost |
| root          | localhost |
+---------------+-----------+
4 rows in set (0.00 sec)
```

## 自启动

没有root权限没法自启动，只能假装一下: nohup

可以写一个简单的脚本：

另外，不要在脚本中添加echo输出一些提示信息，这样会使scp不生效，我也不知道为什么
```
#!/bin/sh
Pgitea=`ps -aux | grep "/home/mxdon/gitea/gitea web -p 5000"`
Pmysql=`ps -aux | grep "/home/mxdon/gitea/mysql/bin/mysqld_safe --defaults-file"`
if [ ${#Pmysql} -eq 0 ]
then
nohup /home/mxdon/gitea/mysql/bin/mysqld_safe --defaults-file=/home/mxdon/gitea/mysql/my.cnf --user=mxdon > /home/mxdon/gitea/mysql/.nohup.log 2>&1 &
fi
if [ ${#Pgitea} -eq 0 ]
then
nohup /home/mxdon/gitea/gitea web -p 5000 > /home/mxdon/gitea/.nohup.log 2>&1 &
fi
```

命名为.gitea.sh

每次可以直接source一下即可，也可以写进bashrc中：
```
source /home/mxdon/.gitea.sh
```

另外，由于mysql的启动有些麻烦，可以使用alias:
```
alias mysql='/home/mxdon/gitea/mysql/bin/mysql -S /home/mxdon/gitea/mysql/mysql.sock'
```

这样就可以无痕使用mysql

## 最后，点个关注不迷路

> 公众号：[孟游先生的旅游笔记](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8a089ae12bfb4ca9a9e5d9ac82f58d43~tplv-k3u1fbpfcp-zoom-1.image)
