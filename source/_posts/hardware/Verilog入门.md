---
title: Verilog入门
date: 2020-09-29 19:28:34
categories: [硬件设计, Verilog]
tags: [Verilog]
---

# Verilog入门

## 前言

最原始的，或许就是最有效的，一些缩写的全称或许是入门的关键。比如`xswl`（笑死我了）、`xmsl`（羡慕死了）等。

<!--more-->

## 名词解释

### Verilog

什么是`Verilog`？遇事蒙圈，上网浏览！

![image-20200929210846866](https://gitee.com/mxdon/img/raw/master/2020/image-20200929210846866.png)

> **`wikipedia`**:
>
> **Verilog**是一种用于描述、设计[电子系统](https://zh.wikipedia.org/wiki/电子学)（特别是[数字电路](https://zh.wikipedia.org/wiki/数字电路)）的[硬件描述语言](https://zh.wikipedia.org/wiki/硬件描述语言)，主要用于在[集成电路设计](https://zh.wikipedia.org/wiki/集成电路设计)，特别是[超大规模集成电路](https://zh.wikipedia.org/wiki/超大规模集成电路)的[计算机辅助设计](https://zh.wikipedia.org/wiki/计算机辅助设计)。Verilog是[电气电子工程师学会](https://zh.wikipedia.org/wiki/电气电子工程师学会)（IEEE）的1364号标准。

**`Verilog`全称是`Verilog Hardware Description Language`（`Verilog` 硬件描述语言），缩写`Verilog HDL`，简称`Verilog`**

**总之，就是用来描述硬件——描述电路的一种语言**，从前，CPU的设计是许多个工程师在纸上绘制的电路图，现在我们可以用变成语言来实现了。

### VHDL

那么上图中提到的`VHDL`是什么呢？全称是`Very-High-Speed Integerated Circuit Hardware Description Language`，这里千万不要以为`Verilog HDL`和`VHDL`是一样的东西噢！

### FPGA

> **`wikipedia`**:
>
> **现场可编程逻辑门阵列**（英语：**Field Programmable Gate Array**，缩写为**FPGA**），它以[PAL](https://zh.wikipedia.org/wiki/可程式陣列邏輯)、[GAL](https://zh.wikipedia.org/wiki/通用阵列逻辑)、[CPLD](https://zh.wikipedia.org/wiki/複雜可程式邏輯裝置)等[可编程逻辑器件](https://zh.wikipedia.org/wiki/可程式邏輯裝置)为技术基础发展而成。作为[专用集成电路](https://zh.wikipedia.org/wiki/特殊應用積體電路)中的一种半客制电路，它既弥补[完全客制](https://zh.wikipedia.org/w/index.php?title=完全客製&action=edit&redlink=1)电路不足，又克服原有[可编程逻辑组件](https://zh.wikipedia.org/w/index.php?title=可編程邏輯元件&action=edit&redlink=1)门电路数有限的缺点。

### EDA

> **`wikipedia`**:
>
> **电子设计自动化**（英语：**Electronic design automation**，[缩写](https://zh.wikipedia.org/wiki/縮寫)：**EDA**）是指利用[计算机辅助设计](https://zh.wikipedia.org/wiki/计算机辅助设计)（CAD）软件，来完成[超大规模集成电路](https://zh.wikipedia.org/wiki/超大规模集成电路)（VLSI）芯片的[功能设计](https://zh.wikipedia.org/wiki/集成电路设计)、[综合](https://zh.wikipedia.org/wiki/逻辑综合)、[验证](https://zh.wikipedia.org/wiki/功能验证)、[物理设计](https://zh.wikipedia.org/wiki/物理设计)（包括[布局](https://zh.wikipedia.org/wiki/布局_(集成电路))、[布线](https://zh.wikipedia.org/wiki/布线_(集成电路))、[版图](https://zh.wikipedia.org/wiki/集成电路版图)、[设计规则检查](https://zh.wikipedia.org/wiki/设计规则检查)等）等流程的设计方式。

> **思考1**：思考硬件描述语言设计方法的优缺点

## 语法入门

### Hello World

~~语言入门是不是都会从`Hello World`开始emmm~~

#### coding_1.0

```Verilog
module helloworld();
initial
begin
$display("Hello World!");  
$finish;
end
endmodule
```

![image-20200930154001387](https://gitee.com/mxdon/img/raw/master/2020/image-20200930154001387.png)

看起来是不是比`C`还简洁？！接下来我们来探究一下其中的秘密……

### 基本概念

- 关键字

  |     关键字      |           含义           |
  | :-------------: | :----------------------: |
  |     module      |       模块开始定义       |
  |      input      |       输入端口定义       |
  |     output      |       输出端口定义       |
  |      inout      |       双向端口定义       |
  |    parameter    |      信号的参数定义      |
  |      wire       |       wire信号定义       |
  |       reg       |       reg信号定义        |
  |     always      | 产生reg信号语句的关键字  |
  |     assign      | 产生wire信号语句的关键字 |
  |      begin      |      语句的起始标志      |
  |       end       |      语句的结束标志      |
  | posedge/negedge |      时序电路的标志      |
  |      case       |     Case语句起始标记     |
  |     default     |  Case语句的默认分支标志  |
  |     endcase     |     Case语句结束标记     |
  |       if        |     if/else语句标记      |
  |      else       |     if/else语句标记      |
  |       for       |       for语句标记        |
  |    endmodule    |       模块结束定义       |

- 模块结构：

  ```verilog
  module 模块名(a,b,c,d);
      input a,b;
      output c,d;
  endmodule
  //与下面等同
  module 模块名(input a,input b,output c,output d);
  endmodule
  ```

  

结合上面的代码进行说明：

```Verilog
module helloworld();	           //定义模块，及模块的名字
initial					          //初始化
    begin					      //代码块开始，相当于C语言的'{'
        $display("Hello World!");   //调用输出函数，相当于C语言的printf
        $finish;			       //调用结束函数，相当于C语言的return 0
    end							  //代码块结束，相当于C语言的'}'
endmodule						  //模块结束
```



为了让一个程序能够学到更多的东西，我们可以把上面的`hello world`程序修改的更加细致一些：

#### coding_1.1

```Verilog
`timescale 1ns/100ps
module helloworld(
    input wire[3:0] a,			//定义了输入端口a和b，输出端口result
    input wire[6:0] b,
    output reg  result
);

reg clk;

assign a = 4'b0001;				//初始化a和b
assign b = 7'b0000001;
initial begin    
        result <= 0;			//在a和b相等的条件下初始化result
        clk <= 0;
        $display("Hello,I am ready");
end

always #50 clk = ~clk;

always @(posedge clk)
begin
            
            $display("Hello World!");  
//            $finish;
end
always @(clk) begin
     $display("sir,where am I?");
end
always @ (result == 1)
    $display("haha");
endmodule
```

> **思考2**：`wire`和`reg`的区别？为什么`a`和`b`用`assign...=`赋值，而`result`用`always...<=`的形式赋值？

- 数据类型及其运算符

  先介绍一下常见的两种数据类型：

|  名称  |         含义         |           举例           |
| :----: | :------------------: | :----------------------: |
| `reg`  | `register`寄存器类型 |  reg[3:0] reg_a,reg_b;   |
| `wire` |      `wire`线型      | wire[4:0] wire_a,wire_b; |

针对上述**思考2**，应该可以观察到，`reg`型数据在`always`块中赋值，`wire`型数据在`assign`语句中赋值。这正是`reg`和`wire`的区别之一。其中`wire`对应连续赋值，如`assign`，`reg`对应过程赋值，如`always`和`initial`。

`wire`综合之后一般是一根导线，`reg`则要根据条件判断是组合逻辑（与原先电路状态无关）还是时序逻辑（跟原先电路状态有关）。

`wire`和`reg`的使用还是难以用以上几句话说清楚，大家自行继续思考呀~

再介绍一下运算符：

![image-20201003132847066](https://gitee.com/mxdon/img/raw/master/2020/image-20201003132847066.png)

![image-20201003095612690](https://gitee.com/mxdon/img/raw/master/2020/image-20201003095612690.png)

和C语言的运算符一毛一样！

### 语法小结

1. 所有的过程块(`initial`、`always`)、`assign`连续赋值语句等，都是并行执行的。
2. `Verilog`更加体现了数据传输的思想，表示一种通过变量名互相连接的关系。

### 条件语句

![image-20201003154811154](https://gitee.com/mxdon/img/raw/master/2020/image-20201003154811154.png)

- 常见的条件语句

  `if……else`、`while`、`case()……endcase`、`forever begin……end`、`for(;;)`等，具体与`C`相差无几。

### 结构说明语句

- `initial`——初始化语句，运行程序就立即开始

- `always`——只要符合条件，就会一直执行

  > **思考3**：`always`，`while`、`for`以及`forever`有什么区别？

- `task`——任务，`task task_name(input a,……);……endtask`

- `function`——函数，`function function_name(input a,……);……endfunction`

> **思考4**：任务和函数的区别，也可以扩展了解一下进程和线程的区别，加油！

### 系统函数

如上面的程序，`$display`函数就是一个非常有用的系统函数，这里我们不研究它的实现过程，只需要知道怎么用即可，如同`C`语言的`printf`，在不同的地方加一句`printf`，或许会对调试有很大的帮助！

其他的函数还有`$time、$setup、$write`等，遇到的时候可以再进行了解。

### 系统任务

与系统函数相似，常用的有`$readmemh、$readmemb、$finish、$stop`等，其与系统函数的区别，与任务和函数的区别一致。

### 必知必会

- ``include`——文件包含，所有的代码写在一个文件里那是很头疼的一件事，就像所有的器官都长在脑袋里那样令人费解。`include`的作用就是将分开的文件联系在一起，具体请查询“预编译”相关解释。
- ``timescale`—— `timescale 10ns/10ps` 其中`10ns`指时间单位，`10ps`指时间精度，模块中的时间均为`10ns`的整数倍，时间延迟的最小分辨率为`10ps`

