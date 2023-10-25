---
title: hvml02-grammar
date: 2022-09-27 22:00:33
categories: [编程语言, Hvml]
tags: [教程, Hvml, 图形化]
---

# hvml02 学习hvml的语法

## 关键字

> 在HVML中将其称为标签, 我是这么理解的.

HVML 为不同的操作引入了大约 20 个标签：

1. hvml, head 和 body 被称为 框架标签（frame tag）; 它们用于定义 HVML 程序的框架或者整体结构。
2. archetype, achedata, error 和 except 被称为 模板标签（template tag）; 它们用于定义参数化模板。
3. init, test, iterate, define, call, include, load, exit, return, update, back 和其他使用动词的标签被称为 动词标签（verb tag），它们用于定义操作数据、更新目标文档或控制虚拟机的动作。


**注意，body 标签不是外部标签，它是 HVML 的框架标签。用于定义一个 HVML 程序的入口体。实际上，您可以在 HVML 程序中定义多个 body 元素，并告诉解释器使用特定的主体作为程序的主入口。**

类比成C语言, body就像是main函数.


## 数据类型

### 基本数据类型

|类型|说明|
|---|-------|
|null| 空|
|boolean| 用于表示真假逻辑值，可取 true 或 false 两种值。|
|number|用于表达整数或浮点数，一般情况下，等价于 C 语言的 double 类型（双精度浮点数）。|
|string|用于表达文本，始终使用 UTF-8 编码。|
|array | 可使用索引引用的多个数据项，容量可变。|
|object |用单个或多个键值对（key-value pair）表示，亦称字典、关联数组等；键值对也常被称作属性（property）。|

### 扩展数据类型

|类型|说明|
|---|-------|
|undefined| 该数据仅在内部使用，用来表示数据尚未就绪，或在更新容器数据时移除一个成员。|
|exception| 该数据仅在内部使用，用来表示异常。|
|longint|应实现为 64 位有符号整数。|
|ulongint|应实现为 64 位无符号整数。|
|longdouble | 对应 C 语言 long double 类型。|
|bsequence|~应该指字符数组~|
|tuple|可使用索引引用的多个数据项，一旦创建，其容量不可变，其成员不可移除，仅可置空。|
|set|特殊的数组，其中的成员可根据其值或者对象数组上的唯一性键值确保唯一性。|

### 特殊数据类型
|类型|说明|
|---|-------|
|dynamic value| 动态值本质上由 获取器（getter） 和 设置器（setter） 方法构成，读取时，由获取器返回对应的值，设置时，由设置器完成对应的工作。|
|native entity|由底层实现的原生实体，通常用于代表一些可执行复杂操作的抽象数据，如读写流、长连接等。这些复杂操作包括实现虚拟属性上的获取器或设置器方法，实现对原生对象的观察（observe）等。|

> 上述特殊数据类型属于内部数据类型，仅在运行时有效，在 HVML 代码中可通过变量和表达式访问。


## 变量
[HVML 预定义变量](https://github.com/HVML/hvml-docs/blob/master/zh/hvml-spec-predefined-variables-v1.0-zh.md)

### 变量初始化

1. 
