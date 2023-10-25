---
title: 使用树莓派搭建wordpress博客网站
date:  2020-12-09 22:58:16
categories: [教程, 嵌入式]
tags: [树莓派, 网站搭建, wordpress]
cover: 
---

# 使用树莓派搭建wordpress博客网站

## 下载wordpress
下载地址：`https://wordpress.org/`

<!--more-->

![](/images/使用树莓派搭建wordpress博客网站/46f1b7ce-9f21-444b-b252-ec0892dd70d8.png)

## 安装树莓派
详情参考《这篇文章》

## 环境搭建
> 由于虚拟机出现了点问题——无法设置共享文件夹——`virtualbox`中，文件权限修改的时候总会报错“`read only file system`”，尝试了重新挂载等诸多方法未果，改到`Windows`下使用`VMware`，结果安装`VMwaretools`的选项呈灰色，无法点击，也是没能解决（最近没能解决的事情也太多了……）

但是作业还是要交的，只能暂时放弃修复，选择使用网盘传输（奶牛快传）（可气的是共享粘贴板也没办法正常使用……）：

![](/images/使用树莓派搭建wordpress博客网站/3b4c819a-8183-4e49-b79a-d75eb2fabcc2.png)
只好手动输入网址：

![](/images/使用树莓派搭建wordpress博客网站/ff160488-6d22-4a2a-a586-26627bfe9073.png)
### 安装`php`

```
sudo apt install php
```
默认安装的版本是`7.3`
可用`php -v`查看

### 安装`mysql`
常规思路也还是不行（疯了，树莓派使我处处碰壁），经过一番查证，应该安装`mysql`的升级版——`mariadb`，安装命令：

```
sudo apt-get install mariadb-server
```
默认情况下MariaDB安装好后都没有配置访问用户的密码，因此如果需要远程连接时会无法连接。因此需要先对root用户设置密码。首先透过上一步中的命令连接至MariaDB，输入如下语句进行密码的修改:

```
use mysql;
UPDATE user SET password=password('你的密码') WHERE user='root';
UPDATE user SET plugin='mysql_native_password' WHERE user = 'root';
flush privileges;
exit
```
重启服务
```
sudo systemctl restart mariadb
```

重启完成后，试用密码进行mariadb登录，验证是否修改成功
```
mysql -u root -p
```
### 安装apache
自带啦，不用安装啦

## 配置wordpress
将`wordpress`解压到`/var/www/`的目录下，名字随意，这里我的文件夹叫做`blog`
```
sudo unzip wordpress.zip
```
访问`localhost`，显示如下：
![](/images/使用树莓派搭建wordpress博客网站/19d506c3-cf88-48c7-a589-14a9ebf75185.png)

更改`apache`的首页定向,要不然访问`localhost`的时候自动就是`/var/www/`文件夹下默认的`html`文件夹及其下面的`index.html`
```
sudo nano /etc/apache2/sites-available/000-default.conf
```
![](/images/使用树莓派搭建wordpress博客网站/fd161472-ea7c-4638-bcb6-9d25b722b4ab.png)
然后又报没有`MySQL`扩展的错误
![](/images/使用树莓派搭建wordpress博客网站/8aee8efa-51a5-4abd-9a3f-d529469fe89d.png)
安装扩展解决：
```
sudo apt install php-mysql
```
然后又报错：建立数据库连接出错
![](/images/使用树莓派搭建wordpress博客网站/c74c9e22-024f-4745-b9aa-210fb1278562.png)
经查询，是因为数据库的配置和连接问题。
打开数据库：
```
连接数据库
mysql -u root -p

创建wordpress数据库
create database wordpress;

创建名叫wordpress的用户，密码是root（可自行修改）
grant all on wordpress.* to wordpress@'localhost' identified by 'root';

刷新更改
flush privileges;
```
这样数据库就建立完了，接下来是与`wordpress`进行链接：
```
把配置文件'wp-config-sample.php'的名字改成'wp-config.php'
sudo mv wp-config-sample.php wp-config.php

编辑配置文件
sudo nano wp-config.php
```
将数据库的相关信息，一一对应修改掉：
![](/images/使用树莓派搭建wordpress博客网站/19cc7f6b-7115-4075-9bc6-97abef24924f.png)

然后再访问`localhost/blog/index.php`即可开始配置`wordpress`
![](/images/使用树莓派搭建wordpress博客网站/30a69add-e0c2-4de5-a3eb-697752dd5940.png)
部分设置如图：然后点击下方的安装即可。
![](/images/使用树莓派搭建wordpress博客网站/bc7e6993-72a9-4a86-aef6-c472a85b1967.png)
然后登录
![](/images/使用树莓派搭建wordpress博客网站/6390f0cf-5828-4ca2-8e8b-f8b05f759e35.png)
试写一篇并发布：
![](/images/使用树莓派搭建wordpress博客网站/3d5f2fc7-0d53-421d-8262-4c90871eeaa7.png)
最终效果：
![](/images/使用树莓派搭建wordpress博客网站/ceebb4eb-a3e1-4f38-b759-6fde31795529.png)

锵锵~计网作业完事啦

## 参考文献
[WordPress的安装过程](http://codex.wordpress.org.cn/WordPress%E7%9A%84%E5%AE%89%E8%A3%85%E8%BF%87%E7%A8%8B#.E8.91.97.E5.90.8D.E7.9A.845.E5.88.86.E9.92.9F.E5.AE.89.E8.A3.85.E6.AD.A5.E9.AA.A4)
[Ubuntu下安装PHP](https://blog.csdn.net/sitebus/article/details/97435428)
[Linux下安装配置MySQL+Apache+PHP+WordPress的详细笔记](https://www.cnblogs.com/bluewelkin/p/3808226.html)
[Linux上安装 wordpress（apache，php，mysql）](https://blog.csdn.net/danmaidesenling/article/details/51280273)
[Linux 下Wordpress博客搭建](https://www.cnblogs.com/ftl1012/p/9302206.html)
[关于在树莓派上不能安装MySql](https://blog.csdn.net/armcsdn/article/details/100481814)
[解决WordPress建立数据库连接时出错](https://www.wpdaxue.com/error-establishing-a-database-connection.html)
[您的 PHP 似乎没有安装运行 WordPress 所必需的 MySQL 扩展”处理方法](https://www.cnblogs.com/x_wukong/p/5859882.html)
