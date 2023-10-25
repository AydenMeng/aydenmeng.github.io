---
title: verilog设计加法器
date: 2019-08-07 19:29:37
categories: [硬件设计, Verilog]
tags: [Verilog, 加法器]
---

# 概述

本文利用了硬件行为描述、数据流描述、结构描述三种方法分别写了几个加法器

<!--more-->

## 一位半加法器

即两个一位的二进制数相加，得到其正常相加的结果的最后一位。

#### 仿真波形图

![](/images/verilog%E8%AE%BE%E8%AE%BE%E8%AE%A1%E5%8A%A0%E6%B3%95%E5%99%A8/6.png)

### 硬件行为描述

#### 设计文件

```
module bjqxw(a,b,sum,cout);
    input a,b;
    output sum,cout;
    reg sum,cout;
    always @(a or b)
        begin
            case({a,b})
                2'b00:begin
                    sum=0;cout=0;
                    end
                2'b01:begin
                    sum=1;cout=0;
                    end
                2'b10:begin
                    sum=1;cout=0;
                    end
                2'b11:begin
                    sum=0;cout=1;
                    end 
            endcase
        end
endmodule
```

#### 仿真结构图

![](/images/verilog设设计加法器/12.png)

#### 仿真文件

```
module bjqxwsimu;
    reg a,b;
    wire sum,cout;
    bjqxw sl(a,b,sum,cout);
    initial
        begin
            a=0;b=0;
        end
    always #10 {a,b}={a,b}+1;
endmodule
```

### 结构描述

#### 设计文件

```
module add(a,b,sum,cout);
    input a,b;
    output sum,cout;
    xor(sum,a,b);
    and(cout,a,b);
endmodule
```

#### 仿真结构图

![](/images/verilog设设计加法器/5.png)

#### 仿真文件

```
module add1;
    reg a,b;
    wire sum,cout;
    add ul(a,b,sum,cout);
    initial
    begin
        a=0;b=0;
    end
    always #10 {a,b}={a,b}+1;
endmodule
```

### 数据流描述

#### 设计文件

```
endmodulemodule add3(a,b,sum,cout);
    input a,b;
    output sum,cout;
    wire sum,cout;
    assign sum=a^b;
    assign cout=a&b;
endmodule
```

#### 仿真结构图

![](/images/verilog%E8%AE%BE%E8%AE%BE%E8%AE%A1%E5%8A%A0%E6%B3%95%E5%99%A8/5.png)

#### 仿真文件

```
module add1;
    reg ain,bin;
    reg clk;
    wire sum1,cout1;
    initial
    begin
        ain=0;bin=0;clk=0;
    end
    always #50 clk=~clk;
    always @(posedge clk)
    begin
        ain={$random}%2;
        #3 bin={$random}%2;
    end
    add3 ul(.a(ain),.b(bin),.sum(sum1),.cout(cout1));
endmodule
```

## 一位全加器

#### 仿真波图

![](/images/verilog%E8%AE%BE%E8%AE%BE%E8%AE%A1%E5%8A%A0%E6%B3%95%E5%99%A8/7.png)

### 硬件行为描述

#### 设计文件

```
module qjq(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    reg sum,cout;
    always @(a or b or cin)
    begin
    case ({cin,a,b})
        3'b000:begin
            sum=0;cout=0;
        end
        3'b001:begin
            sum=1;cout=0;
        end
        3'b010:begin
            sum=1;cout=0;
        end
       3'b011:begin
            sum=0;cout=1;
        end
        3'b100:begin
            sum=1;cout=0;
        end
        3'b101:begin
            sum=0;cout=1;
        end
        3'b110:begin
            sum=0;cout=1;
        end
        3'b111:begin
            sum=1;cout=1;
        end
      endcase 
     end
endmodule
```

#### 仿真结构图

![](/images/verilog%E8%AE%BE%E8%AE%BE%E8%AE%A1%E5%8A%A0%E6%B3%95%E5%99%A8/6.5.png)

#### 仿真文件

```
module qjq1;
    reg a,b,cin;
    wire sum,cout;
    qjq ul(a,b,cin,sum,cout);
    initial
    begin
        a=0;b=0;cin=0;
    end
    always #10 {a,b,cin}={a,b,cin}+1;
endmodule
```

### 结构描述

#### 设计文件

```
module qiq(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    wire q1,q2,q3;
    xor(sum,a,b,cin);
    or(q1,a,b);
    or(q2,b,cin);
    or(q3,a,cin);
    and(cout,q1,q2,q3);
endmodule
```

#### 仿真结构图

![](/images/verilog设设计加法器/10.png)

#### 仿真文件

```
module qjq1;
    reg a,b,cin;
    wire sum,cout;
    qiq ul(a,b,cin,sum,cout);
    initial
    begin
        a=0;b=0;cin=0;
    end
    always #10 {a,b,cin}={a,b,cin}+1;
endmodule
```

### 数据流描述

#### 设计文件

```
module qjq(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    assign {sum,cout}=a+b+cin;
endmodule
```

#### 仿真结构图

![](/images/verilog设设计加法器/11.png)

#### 仿真文件

```
module qjqsimu;
    reg a,b,cin;
    wire sum,cout;
    qjq sl(a,b,cin,sum,cout);
    initial
        begin
            a=0;b=0;cin=a&b;
        end
    always #20 {a,b}={a,b}+1;
endmodule
```

## 四位全加器

### 数据流描述

#### 设计文件

```
module qjq(a,b,cin,sum,cout);
    input [3:0] a,b;
    input cin;
    output [3:0] sum;
    output cout;
    assign {sum,cout}=a+b+cin;
endmodule
```

#### 仿真结构图

![](/images/verilog设设计加法器/8.png)

#### 仿真文件

```
module qjqsimu;
    reg [3:0] a,b;
    reg cin;
    wire [3:0] sum;
    wire cout;
    qjq sl(a,b,cin,sum,cout);
    initial
        begin
            a=4'b0000;b=4'b0000;cin=0;
        end
    always #20 {a,b}={a,b}+4'b0001;
endmodule
```

#### 仿真波图

![](/images/verilog设设计加法器/9.png)

ps：将上述输入输出的字段长度对应修改，可得到相应数位的全加器数据流描述
