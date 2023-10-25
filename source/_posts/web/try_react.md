---
title: React实现五子棋游戏
date: 2020-10-28 11:09:57
categories: [软件编程, 前端]
tags: [React, 图形化]
---

# React实现五子棋游戏

<!--more-->

## 摘要

React 最早起源于 Facebook 的一个内部项目，因为公司对现有的 Javascript MVC 框架都不满意，就决定自己开发一套，用来架设 Instagram 的网站。开发完成后，发现这套东西很好用，就在 2013 年 5 月开源了。

Javascript操作网页的接口，全称为“文档对象模型”(Document Object Model)，简称DOM。而在网页对象层级之间，元素与元素的关系形成DOM树，在 DOM 树的状态需要发生变化时，虚拟 DOM 机制会将同一 Event loop 前后的 DOM 树进行对比，如果两个 DOM 树存在不一样的地方，那么 React 仅仅会针对这些不一样的区域来进行响应的 DOM 修改，从而实现最高效的 DOM 操作和渲染。

此外，在 React 里提及的“组件”，常规是一些可封装起来、复用的 UI 模块，可以理解为“带有细粒度 UI 功能的部分 DOM 区域”。然后我们可以把这些组件层层嵌套起来使用，当然这样组件间会存在依赖关系。

为了分析网站的结构，以及更好的学习React中组件的使用方法，面向对象的编程思想，本文通过搭建一个前端五子棋界面，对React的响应方式进行研究。

关键词：React；高效渲染；五子棋；

## 绪论

### 研究背景

MVC是一种设计模式，它将应用划分为3个部分：数据（模型）、展现层（视图）和用户交互（控制器）。React主要用于构建UI。从MVC模式中，只作为V层（视图层），即用React写Html+CSS。

React不同于传统的Html+CSS+Js的Web页面开发模式，它更强调组件化，使用组件的方式聚焦于视图层，借助Jsx来写高内聚UI组件，单向数据流模式使得UI组件状态的维护管理更加清晰。用React开发，组件化抽离页面元素，页面实现是相当于是拼装模式，对于页面相似度大的业务，会显得特高效、快捷。

### 论文组织结构

论文共分为四个章节，组织结构如下。

第一章 绪论。主要介绍react的研究背景和价值，并对本文的研究内容和技术路线做出概要描述。

第二章 论文研究基础。本章首先要介绍Html5、CSS、Javascript的相关基础知识进行陈述。接着再介绍React的基础语法。

第三章 React五子棋的实现细节。本章主要对五子棋的实现思路和部分代码进行解析，从而研究React的实现模式。

第四章 总结与展望。主要内容是对论文工作的总结和展望。

## 论文研究基础

本章主要介绍论文设计的相关背景知识。首先介绍Html5、CSS、Javascript的相关基础知识，接着再介绍React的使用方法。

### Html5

HTML5 是 HyperText Markup Language 5 的缩写，HTML5 技术结合了 HTML4.01 的相关标准并革新，符合现代网络发展要求，在 2008 年正式发布。HTML5 由不同的技术构成，其在互联网中得到了非常广泛的应用，提供更多增强网络应用的标准机。与传统的技术相比，HTML5 的语法特征更加明显，并且结合了SVG的内容。这些内容在网页中使用可以更加便捷地处理多媒体内容，而且 HTML5中还结合了其他元素，对原有的功能进行调整和修改，进行标准化工作。

为了更好地处理今天的互联网应用，HTML5添加了很多新元素及功能，比如： 图形的绘制，多媒体内容，更好的页面结构，更好的形式 处理，和几个api拖放元素，定位，包括网页 应用程序缓存，存储，网络工作者，等。

HTML5 新标签

|      标签      |        描述        |
| :------------: | :----------------: |
|   <!DOCTYPE>   |   定义文档类型。   |
|    `<html>`    | 定义一个 HTML 文档 |
|   `<title>`    | 为文档定义一个标题 |
|    `<body>`    |   定义文档的主体   |
| `<h1>`to`<h6>` |   定义 HTML 标题   |
|     `<p>`      |    定义一个段落    |
|     `<br>`     |  定义简单的折行。  |
|     `<hr>`     |    定义水平线。    |
|   `<!--…-->`   |    定义一个注释    |

### CSS

层叠样式表(英文全称：Cascading Style Sheets)是一种用来表现HTML（标准通用标记语言的一个应用）或XML（标准通用标记语言的一个子集）等文件样式的计算机语言。CSS不仅可以静态地修饰网页，还可以配合各种脚本语言动态地对网页各元素进行格式化。

CSS 能够对网页中元素位置的排版进行像素级精确控制，支持几乎所有的字体字号样式，拥有对网页对象和模型样式编辑的能力。

CSS样式可以直接存储于HTML网页或者单独的样式单文件。无论哪一种方式，样式单包含将样式应用到指定类型的元素的规则。外部使用时，样式单规则被放置在一个带有文件扩展名_css的外部样式单文档中。

样式规则是可应用于网页中元素，如文本段落或链接的格式化指令。样式规则由一个或多个样式属性及其值组成。内部样式单直接放在网页中，外部样式单保存在独立的文档中，网页通过一个特殊标签链接外部样式单。

名称CSS中的“层叠（cascading）”表示样式单规则应用于HTML文档元素的方式。具体地说，CSS样式单中的样式形成一个层次结构，更具体的样式覆盖通用样式。样式规则的优先级由CSS根据这个层次结构决定，从而实现级联效果。

CSS字体（Font） 属性

|       属性       |                           说明                            |
| :--------------: | :-------------------------------------------------------: |
|       font       |               在一个声明中设置所有字体属性                |
|   font-family    |                    规定文本的字体系列                     |
|    font-size     |                    规定文本的字体尺寸                     |
|    font-style    |                    规定文本的字体样式                     |
|   font-variant   |                    规定文本的字体样式                     |
|   font-weight    |                      规定字体的粗细                       |
|    @font-face    | 一个规则，允许网站下载并使用其他超过"Web- safe"字体的字体 |
| font-size-adjust |                   为元素规定 aspect 值                    |
|   font-stretch   |                 收缩或拉伸当前的字体系列                  |

### Javascript

JavaScript（通常缩写为JS）是一种高级的、解释型的编程语言[8]。JavaScript是一门基于原型、函数先行的语言[9]，是一门多范式的语言，它支持面向对象程序设计，命令式编程，以及函数式编程。它提供语法来操控文本、数组、日期以及正则表达式等，不支持I/O，比如网络、存储和图形等，但这些都可以由它的宿主环境提供支持。

JavaScript 语句标识符 (关键字) ：

|     语句     |                             描述                             |
| :----------: | :----------------------------------------------------------: |
|    break     |                        用于跳出循环。                        |
|    catch     |      语句块，在 try 语句块执行出错时执行 catch 语句块。      |
|   continue   |                    跳过循环中的一个迭代。                    |
| do ... while |    执行一个语句块，在条件语句为 true 时继续执行该语句块。    |
|     for      |      在条件语句为 true 时，可以将代码块执行指定的次数。      |
|  for ... in  | 用于遍历数组或者对象的属性（对数组或者对象的属性进行循环操作）。 |
|   function   |                         定义一个函数                         |
| if ... else  |             用于基于不同的条件来执行不同的动作。             |
|    return    |                           退出函数                           |
|    switch    |             用于基于不同的条件来执行不同的动作。             |
|    throw     |                     抛出（生成）错误 。                      |
|     try      |              实现错误处理，与 catch 一同使用。               |
|     var      |                        声明一个变量。                        |
|    while     |              当条件语句为 true 时，执行语句块。              |

### React

React（有时叫React.js或ReactJS），是一个为数据提供渲染为HTML视图的开源JavaScript 库。React视图通常采用包含以自定义HTML标记规定的其他组件的组件渲染。React为程序员提供了一种子组件不能直接影响外层组件（"data flows down"）的模型，数据改变时对HTML文档的有效更新，和现代单页应用中组件之间干净的分离。

React 的核心思想是：封装组件。各个组件维护自己的状态和 UI，当状态变更，自动重新渲染整个组件。基于这种方式的一个直观感受就是我们不再需要不厌其烦地来回查找某个 DOM 元素，然后操作 DOM 去更改 UI。

所以React的本质还是Javascript语言，但其应用都是构建在组件之上。所以有必要再了解其组件以及相关语法JSX。

将 HTML 直接嵌入了 JS 代码里面，这个就是 React 提出的一种叫 *JSX* 的语法，这应该是最开始接触 React 最不能接受的设定之一，因为前端被“表现和逻辑层分离”这种思想“洗脑”太久了。但实际上组件的 HTML 是组成一个组件不可分割的一部分，能够将 HTML 封装起来才是组件的完全体，React 发明了 JSX 让 JS 支持嵌入 HTML 不得不说是一种非常聪明的做法，让前端实现真正意义上的组件化成为了可能。

## React五子棋的实现细节

本章开始介绍五子棋的实现细节。

### 界面设计

首先设定界面的大小——15x15的正方形棋盘，下面的VALUE_TEXT用于将逻辑判断标准0、1、2，对应显示为“”、“O”、“X”，即将棋盘上可能出现的三种图标与数字逻辑0、1、2分别对应起来，用于之后的判断。

```jsx
const /**
   * 五子棋行数
   */
  ROW_COUNT = 15,
  /**
   * 五子棋列数
   */
  COL_COUNT = 15,
  /**
   * 值对应的显示文本
   */
  VALUE_TEXT = {
    0: "",
    1: "O",
    2: "X"
  };
```

创建棋盘之后，对棋盘默认的填充为空值，以此显示一个空棋盘作为初始界面。下面的棋子单元格将15x15的大棋盘划分成225个1x1的单元。

```jsx
/**
 * 创建原始数据
 */
function crateGridArr(row, col) {
  let outData = [],
    rowData = [];

  for (let i = 0; i < col; i++) {
    rowData.push(0);
  }
  for (let i = 0; i < row; i++) {
    outData.push(rowData.concat());
  }

  return outData;
}
/**
 * 棋子单元格
 */
function Square(props) {
  return (
    <label
      className={`square ${props.active ? "active" : ""}`}
      datarow={props.row}
      datacol={props.col}
    >
      {VALUE_TEXT[props.value]}
    </label>
  );
}
```

![棋盘界面图示](/images/web结课论文/image-20201028170623674.png)

### 数据处理

利用数据结构栈，将棋盘上的行为次数记录下来，如果栈的长度超过规定的最大长度，就将数据右移存入栈尾。

```jsx
// 栈，只存放设定长度的数据
class StepStack {
  constructor(maxLength) {
    this.maxLength = maxLength;
    this.stack = [];
  }

  push(item) {
    if (this.stack.length > this.maxLength) {
      this.shift();
    }
    this.stack.push(item);
  }

  shift() {
    if (this.stack.length > 0) {
      this.stack.shift();
    }
  }

  rollback(index) {
    let outData = this.stack.splice(index);
    return outData;
  }

  stacks() {
    return this.stack.concat();
  }

  reset() {
    this.stack = [];
  }
}
```

为了分别记录游戏双方的数据，通过三个参数，分别记录选手，以及其下子的横纵坐标。

```jsx
/**
   * 添加记录
   */
  addStack(x, y, user) {
    this.stepStack.push({
      x,
      y,
      user
    });
  }
```

除了记录添加的数据，本文还进行了悔棋和重玩两种功能设计，悔棋时只需将之前存入的数据，按照后进先出的规则依次出栈即可；考虑到游戏的可玩性与项目的设计性，只需保留20步记录，即最多悔棋20步。

重玩则是将栈清空。

```jsx
class Gomoku extends React.Component {
  constructor() {
    super();
    // 生成15X15的网格数据，O:1，X:2
    this.state = {
      grid: crateGridArr(ROW_COUNT, COL_COUNT),
      steps: []
    };
    this.curUser = 1;
    this.gameOver = false;
    this.result = [];
    // 只保留最近20步的记录
    this.stepStack = new StepStack(20);
    this.reSet = this.reSet.bind(this);
  }  
//悔棋  
  rollback(e) {
    if (e.target.className !== "step") {
      return;
    }

    let target = e.target,
      index = +target.getAttribute("dataindex");

    let rollData = this.stepStack.rollback(index + 1);
    if (rollData.length === 0) {
      return;
    }

    let data = this.state.grid.concat();
    rollData.forEach(item => {
      data[item.x][item.y] = 0;
    });

    this.setStaticState([], rollData[0].user);

    this.setState({
      grid: data,
      steps: this.stepStack.stacks()
    });
  }
  //重玩
  reSet() {
    this.setStaticState([], 1);
    this.stepStack.reset();
    this.setState({
      grid: crateGridArr(ROW_COUNT, COL_COUNT),
      steps: []
    });
  }

```

### 功能设计

落子功能的设计很简单，作为一个鼠标点击的游戏，只需要将其设置为button按钮，然后按照“X”、“O”玩家的依次点击，对button设置相应的事件，轮流返回“X”、“O”对应的1或2数值即可判断。

```jsx
/**
 * 每一步的button
 */
function Step(props) {
  return (
    <li className="step" dataindex={props.index}>{`[${
      VALUE_TEXT[props.user]
    }] Moves To [${props.coordinate}]`}</li>
  );
}
```

接着是落子的逻辑判断，如果落子处的VALUE_TEXT不为0，即该处不为空，则不允许落子；如果游戏结束，也不允许落子。

```jsx
/**
   * 下棋
   */
  handleClick(e) {
    let target = e.target;
    if (this.gameOver || !target.getAttribute("datarow")) {
      return;
    }

    let row = +target.getAttribute("datarow"),
      col = +target.getAttribute("datacol");
    if (this.state.grid[row][col] !== 0) {
      console.log("当前单元格已被使用.");
      return;
    }

    let data = this.state.grid.concat();
    data[row][col] = this.curUser;
    this.addStack(row, col, this.curUser);

    let result = checkWin(data, row, col);

    this.setStaticState(result);

    this.setState({
      grid: data,
      steps: this.stepStack.stacks()
    });
  }

  setCurUser(user) {
    if (user) {
      this.curUser = user;
      return;
    }
    this.curUser = this.curUser === 1 ? 2 : 1;
  }

  setStaticState(result, user) {
    this.result = [];
    if (result && result.length === 5) {
      this.gameOver = true;
      result.forEach(item => {
        this.result.push(`${item.x}-${item.y}`);
      });
    } else {
      this.gameOver = false;
    }
    this.setCurUser(user);
  }
```

游戏结束的标志有两种：一种是有一方胜利，另一种是棋盘已经下满，即“和棋”。

![一方胜利图示](/images/web结课论文/image-20201028170531403.png)

![棋盘下满清理图示](/images/web结课论文/image-20201028170428568.png)

其中棋盘下满的情况容易判断，这里只实现一方胜利的逻辑判断。

对棋面情况的判断有四种，即横向、纵向、左斜线方向、右斜线方向，只要在某一方向上的棋子达到5个，即为游戏胜利。代码实现如下：

```jsx
const direction = {
  horizontal: 1,
  vertical: 2,
  leftOblique: 3,
  rightOblique: 4
};

function checkWin(arr, x, y) {
  let target = arr[x][y],
    rowLen = arr.length,
    colLen = arr[0].length,
    startNode = { x, y },
    nodeList;

  function check(node) {
    if (node.x >= rowLen || node.x < 0 || node.y >= colLen || node.y < 0) {
      return false;
    }
    if (arr[node.x][node.y] === target) {
      return true;
    }
    return false;
  }

  for (let i = 1; i <= 4; i++) {
    nodeList = [startNode];
    let left = startNode,
      right = startNode,
      leftVal = true,
      rightVal = true;

    // 从当前节点出发，左右或者上下同时检测
    while (leftVal || rightVal) {
      if (leftVal) {
        left = getCoordinate(i, left, -1);
        leftVal = check(left) && nodeList.push(left);
      }
      if (rightVal) {
        right = getCoordinate(i, right, 1);
        rightVal = check(right) && nodeList.push(right);
      }

      if (nodeList.length === 5) {
        return nodeList;
      }
    }
  }
  return nodeList;
}

function getCoordinate(direct, node, tag) {
  let newNode;
  switch (direct) {
    case direction.horizontal:
      newNode = {
        x: node.x,
        y: node.y + tag
      };
      break;
    case direction.vertical:
      newNode = {
        x: node.x + tag,
        y: node.y
      };
      break;
    case direction.leftOblique:
      newNode = {
        x: node.x + tag,
        y: node.y + tag
      };
      break;
    case direction.rightOblique:
      newNode = {
        x: node.x - tag,
        y: node.y + tag
      };
      break;
    default:
      newNode = {
        x: -1,
        y: -1
      };
  }
  return newNode;
}
```

## 总结与展望

本次设计，更加了解前端工程的奇妙之处，一个小游戏的运行到部署只需要写几百行代码，React的实时渲染也着实令人感到惊叹，简单的CSS代码即可让一个网页有如此美感，性能高的让人称赞。

此次五子棋的设计所涉及到的难点就在于父子组件通信，在不同的函数中传递不同的返回值，而onClick事件也有更高明的写法，其思想在各方面的编程中都有所影响。

## 参考文章

[0][React 官网示例实现 + 五子棋 + 简单文章发表 demo](https://segmentfault.com/a/1190000018946570)——其中代码实现来源于此，我只是将必要代码筛选出来，成一个单独的项目

[1][入门教程: 认识 React ](https://react-1251415695.cos-website.ap-chengdu.myqcloud.com/tutorial/tutorial.html#what-is-react)

[2][创建新的 React 应用](https://react-1251415695.cos-website.ap-chengdu.myqcloud.com/docs/create-a-new-react-app.html#create-react-app)

[3][重新介绍 JavaScript（JS 教程）](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/A_re-introduction_to_JavaScript)

[4][react中的state和props](https://www.jianshu.com/p/2f6d81a15d81)

[5][聊一聊我对 React Context 的理解以及应用](https://www.jianshu.com/p/eba2b76b290b)

[6][react优缺点](https://www.cnblogs.com/qiqi715/p/10513195.html)](https://www.cnblogs.com/qiqi715/p/10513195.html)

[7][DOM、DOM树](https://www.jianshu.com/p/0ec77136ec48)

[8][React](https://zh.wikipedia.org/wiki/React)

## 附录

### index.js

```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import './index.scss';

const /**
   * 五子棋行数
   */
  ROW_COUNT = 15,
  /**
   * 五子棋列数
   */
  COL_COUNT = 15,
  /**
   * 值对应的显示文本
   */
  VALUE_TEXT = {
    0: "",
    1: "O",
    2: "X"
  };

/**
 * 创建原始数据
 */
function crateGridArr(row, col) {
  let outData = [],
    rowData = [];

  for (let i = 0; i < col; i++) {
    rowData.push(0);
  }
  for (let i = 0; i < row; i++) {
    outData.push(rowData.concat());
  }

  return outData;
}

// 栈，只存放设定长度的数据
class StepStack {
  constructor(maxLength) {
    this.maxLength = maxLength;
    this.stack = [];
  }

  push(item) {
    if (this.stack.length > this.maxLength) {
      this.shift();
    }
    this.stack.push(item);
  }

  shift() {
    if (this.stack.length > 0) {
      this.stack.shift();
    }
  }

  rollback(index) {
    let outData = this.stack.splice(index);
    return outData;
  }

  stacks() {
    return this.stack.concat();
  }

  reset() {
    this.stack = [];
  }
}

/**
 * 棋子单元格
 */
function Square(props) {
  return (
    <label
      className={`square ${props.active ? "active" : ""}`}
      datarow={props.row}
      datacol={props.col}
    >
      {VALUE_TEXT[props.value]}
    </label>
  );
}
/**
 * 每一步的button
 */
function Step(props) {
  return (
    <li className="step" dataindex={props.index}>{`[${
      VALUE_TEXT[props.user]
    }] Moves To [${props.coordinate}]`}</li>
  );
}
/**
 * 五子棋
 */
class Gomoku extends React.Component {
  constructor() {
    super();

    // 生成15X15的网格数据，O:1，X:2
    this.state = {
      grid: crateGridArr(ROW_COUNT, COL_COUNT),
      steps: []
    };

    this.curUser = 1;
    this.gameOver = false;
    this.result = [];
    // 只保留最近20步的记录
    this.stepStack = new StepStack(20);
    this.reSet = this.reSet.bind(this);
  }

  /**
   * 下棋
   */
  handleClick(e) {
    let target = e.target;
    if (this.gameOver || !target.getAttribute("datarow")) {
      return;
    }

    let row = +target.getAttribute("datarow"),
      col = +target.getAttribute("datacol");
    if (this.state.grid[row][col] !== 0) {
      console.log("当前单元格已被使用.");
      return;
    }

    let data = this.state.grid.concat();
    data[row][col] = this.curUser;
    this.addStack(row, col, this.curUser);

    let result = checkWin(data, row, col);

    this.setStaticState(result);

    this.setState({
      grid: data,
      steps: this.stepStack.stacks()
    });
  }

  setCurUser(user) {
    if (user) {
      this.curUser = user;
      return;
    }
    this.curUser = this.curUser === 1 ? 2 : 1;
  }

  setStaticState(result, user) {
    this.result = [];
    if (result && result.length === 5) {
      this.gameOver = true;
      result.forEach(item => {
        this.result.push(`${item.x}-${item.y}`);
      });
    } else {
      this.gameOver = false;
    }
    this.setCurUser(user);
  }

  /**
   * 添加记录
   */
  addStack(x, y, user) {
    this.stepStack.push({
      x,
      y,
      user
    });
  }

  /**
   * 悔棋
   */
  rollback(e) {
    if (e.target.className !== "step") {
      return;
    }

    let target = e.target,
      index = +target.getAttribute("dataindex");

    let rollData = this.stepStack.rollback(index + 1);
    if (rollData.length === 0) {
      return;
    }

    let data = this.state.grid.concat();
    rollData.forEach(item => {
      data[item.x][item.y] = 0;
    });

    this.setStaticState([], rollData[0].user);

    this.setState({
      grid: data,
      steps: this.stepStack.stacks()
    });
  }

  reSet() {
    this.setStaticState([], 1);
    this.stepStack.reset();
    this.setState({
      grid: crateGridArr(ROW_COUNT, COL_COUNT),
      steps: []
    });
  }

  render() {
    let text = this.gameOver
      ? `Winner: ${VALUE_TEXT[this.curUser === 1 ? 2 : 1]}`
      : `Next Player: ${VALUE_TEXT[this.curUser]}`;

    return (
      <div className="gomoku-box" onClick={e => this.handleClick(e)}>
        <div className="gomoku-bar">
          <button onClick={this.reSet}>Restart</button>
          <label>{text}</label>
        </div>

        <div className="game-box">
          <div className="square-box">
            {this.state.grid.map((row, i) => {
              return (
                <div key={i} className="square-row">
                  {row.map((cell, j) => {
                    let key = `${i}-${j}`;
                    return (
                      <Square
                        key={key}
                        active={this.gameOver && this.result.includes(key)}
                        value={cell}
                        row={i}
                        col={j}
                      />
                    );
                  })}
                </div>
              );
            })}
          </div>
          <ul className="step-box" onClick={e => this.rollback(e)}>
            {this.state.steps.map((step, i) => {
              let coordinate = `${step.x},${step.y}`;
              return (
                <Step
                  key={coordinate}
                  index={i}
                  coordinate={coordinate}
                  user={step.user}
                />
              );
            })}
          </ul>
        </div>
      </div>
    );
  }
}


function Game(props) {
  return (
    <div className="game-box">
      <div className="game-left">
        <Gomoku />
      </div>
    </div>
  );
}


const direction = {
  horizontal: 1,
  vertical: 2,
  leftOblique: 3,
  rightOblique: 4
};

/**
 * 判断当前游戏是否结束
 * @param {Array} arr
 * @param {Number} x 当前棋子的横坐标
 * @param {Number} y 当前棋子的纵坐标
 * 赢的情况
 * 连续的五个棋子相同
 * 横线，竖线，左斜线，右斜线四种情况
 */
function checkWin(arr, x, y) {
  let target = arr[x][y],
    rowLen = arr.length,
    colLen = arr[0].length,
    startNode = { x, y },
    nodeList;

  function check(node) {
    if (node.x >= rowLen || node.x < 0 || node.y >= colLen || node.y < 0) {
      return false;
    }
    if (arr[node.x][node.y] === target) {
      return true;
    }
    return false;
  }

  for (let i = 1; i <= 4; i++) {
    nodeList = [startNode];
    let left = startNode,
      right = startNode,
      leftVal = true,
      rightVal = true;

    // 从当前节点出发，左右或者上下同时检测
    while (leftVal || rightVal) {
      if (leftVal) {
        left = getCoordinate(i, left, -1);
        leftVal = check(left) && nodeList.push(left);
      }
      if (rightVal) {
        right = getCoordinate(i, right, 1);
        rightVal = check(right) && nodeList.push(right);
      }

      if (nodeList.length === 5) {
        return nodeList;
      }
    }
  }
  return nodeList;
}

function getCoordinate(direct, node, tag) {
  let newNode;
  switch (direct) {
    case direction.horizontal:
      newNode = {
        x: node.x,
        y: node.y + tag
      };
      break;
    case direction.vertical:
      newNode = {
        x: node.x + tag,
        y: node.y
      };
      break;
    case direction.leftOblique:
      newNode = {
        x: node.x + tag,
        y: node.y + tag
      };
      break;
    case direction.rightOblique:
      newNode = {
        x: node.x - tag,
        y: node.y + tag
      };
      break;
    default:
      newNode = {
        x: -1,
        y: -1
      };
  }
  return newNode;
}


// ========================================

ReactDOM.render(
  <Game />,
  document.getElementById('root')
);
```

### index.scss

```scss
.game-box {
    display: flex;

    .game-left {
        width: 750px;
        padding-right: 20px;
        box-sizing: border-box;
    }

}

.step {
    color: #0084ff;
    background-color: #e5f2ff;
    border: 1px solid #add6ff;
    display: block;
    margin-bottom: 6px;
    padding: 2px 1em;
    cursor: pointer;
}

.square-box {
    display: inline-block;

    .square-row {
        display: flex;
        width: 102px;
    }


    .red {
        color: #4ab3ff;
    }

    .square:focus {
        outline: none;
    }
}

.square {
    background: #fff;
    border: 1px solid #999;
    font-size: 24px;
    font-weight: bold;
    line-height: 34px;
    height: 34px;
    margin-right: -1px;
    margin-top: -1px;
    padding: 0;
    text-align: center;
    width: 34px;
    cursor: pointer;

    &.active {
        color: #4ab3ff;
    }
}

.gomoku-box {
    display: block;

    .square-row {
        display: flex;
        flex-wrap: nowrap;
        width: 100%;
    }

    .gomoku-bar {
        padding: 12px 0;

        button,
        label {
            width: 100px;
            color: #0084ff;
            background-color: #e5f2ff;
            border: 1px solid #add6ff;
            font-size: 14px;
            padding: 8px;
            align-self: flex-end;
            cursor: pointer;
        }

        label {
            border: 1px solid #fff;
            background-color: #fff;
            width: 180px;
            padding: 8px 0;
            box-sizing: border-box;
            float: right;
            cursor: default;
        }
    }

    .game-box {
        width: 100%;
        display: flex;
    }

    .square-box {
        flex: 1;
    }

    .step-box {
        width: 180px;
        margin: 0;
        padding: 0;
    }
}
```

### index.html

```html
<div id="errors" style="
  background: #c00;
  color: #fff;
  display: none;
  margin: -20px -20px 20px;
  padding: 20px;
  white-space: pre-wrap;
"></div>
<div id="root"></div>
<script>
window.addEventListener('mousedown', function(e) {
  document.body.classList.add('mouse-navigation');
  document.body.classList.remove('kbd-navigation');
});
window.addEventListener('keydown', function(e) {
  if (e.keyCode === 9) {
    document.body.classList.add('kbd-navigation');
    document.body.classList.remove('mouse-navigation');
  }
});
window.addEventListener('click', function(e) {
  if (e.target.tagName === 'A' && e.target.getAttribute('href') === '#') {
    e.preventDefault();
  }
});
window.onerror = function(message, source, line, col, error) {
  var text = error ? error.stack || error : message + ' (at ' + source + ':' + line + ':' + col + ')';
  errors.textContent += text + '\n';
  errors.style.display = '';
};
console.error = (function(old) {
  return function error() {
    errors.textContent += Array.prototype.slice.call(arguments).join(' ') + '\n';
    errors.style.display = '';
    old.apply(this, arguments);
  }
})(console.error);
</script>

```

