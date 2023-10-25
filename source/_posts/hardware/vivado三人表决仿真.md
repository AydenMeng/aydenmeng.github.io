---
title: vivado三人表决仿真
date: 2019-08-06 16:17:14
categories: [硬件设计, Verilog]
tags: [Verilog, Vivado]
---

# 概述

下面以三人表决电路的verilog仿真来了解一下vivado软件的使用。

<!--more-->

## 编写设计文件

首先可以在开始的界面通过create new project来新建工程，也可以通过`file-->project-->new...`来新建工程

![](/images/vivado三人表决仿真/1.png)

点击next

![](/images/vivado三人表决仿真/2.png)

然后给文件起个名字，见名知意最好

![](/images/vivado三人表决仿真/3.png)

一开始我们不需要通过程序来添加源文件，所以这个勾可以勾上

![](/images/vivado三人表决仿真/4.png)

相应器件默认选择就好

![](/images/vivado三人表决仿真/5.png)

点击完成项目就新建成功了

![](/images/vivado三人表决仿真/6.png)

在source面板中点击加号，如图右半部分可以新建三种文件，即约束文件、源（设计）文件、仿真文件，这里首先新建源文件即可。

![](/images/vivado三人表决仿真/8.png)

点击create file对文件的名字、路径和语言进行设置，这里只设置设计文件的名字即可。

![](/images/vivado三人表决仿真/9.png)

点击完成。

![](/images/vivado三人表决仿真/10.png)

这里要我们设置设置文件的输入输出端口，我们可以在这设置，也可以在代码中自行编写。

![](/images/vivado三人表决仿真/11.png)

在source面板中双击源文件即可查看其中代码，这里我已编写完成，按`ctrl S`保存，source文件中不出现错误文件，即表明代码编写无误

```
module srbj(
    input a,
    input b,
    input c,
    output d
    );
    assign d=a&b|a&c|b&c;
endmodule
```

![](/images/vivado三人表决仿真/12.png)

错误示例：

![](/images/vivado三人表决仿真/13.png)

点击左侧的`RTL ANALYSIS`可以生成相关的逻辑图，检查逻辑是否有问题

![](/images/vivado三人表决仿真/15.png)

## 编写仿真文件

同理新建仿真文件，且无需设置输入输出端口

![](/images/vivado三人表决仿真/14.png)

编写代码如下

```
module srbjsimu;
reg a,b,c;				//三个寄存器
wire d;
srbj sl(a,b,c,d);		//实例化三人表决源文件对象
initial
begin
a=0;b=0;c=0;			//初始值为0
end
always #10 {a,b,c}={a,b,c}+1;		//每延迟10，对abc进行加1，即在0-7之间循环
endmodule
```

点击左侧`RUN　Simulation`查看仿真结果

![](/images/vivado三人表决仿真/16.png)

点击图示两个按钮可将视图调整至合适

![](/images/vivado三人表决仿真/17.png)

完整图如下，可通过拖动黄色的时间帧查看每个位置输入输出的情况。

![](/images/vivado三人表决仿真/18.png)
