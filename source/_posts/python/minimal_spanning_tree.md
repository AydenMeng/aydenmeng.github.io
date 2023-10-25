---
title: Python实现最小生成树--Prim算法和Kruskal算法
date:  2020-12-09 22:58:16
categories: [软件编程, Python]
tags: [算法, 图形化, 生成树]
cover: 
---

# Python实现最小生成树--Prim算法和Kruskal算法

## 前言
>最小生成树涉及到在互联网中网游设计者和网络收音机所面临的问题：信息传播问题。其中最简单的解法是由广播源维护一个收听者的列表，将每条信息向每个收听者发送一次，即单播解法。而单播解法的问题也很明显：路由器网络中，有一些路由器会发送相同的信息，给互联网络增加负担，产生额外流量。另一种方法是洪水解法，每条消息只发送一次，给所有的路由器，每个路由器再尽可能的发送给相连的主机或路由器。洪水解法如果没有限制的话，许多路由器和主机将不停的接收到重复的消息，所以洪水解法一般会给每条消息设置TTL值，以此对信息传播进行限制。
>
>> 而通过分析和研究，信息广播问题的最优解法，依赖于路由器关系图上选取具有最小权重的生成树。沿着最小生成树的路径层次传播，达到每个路由器只需要处理1次消息，同时总费用最小。

<!--more-->

解决最小生成树问题常用的有**Prim算法**和**Kruskal算法**，二者均基于贪心算法。**Prim算法**思想很简单，即每步都沿着最小权重的边向前搜索，找到一条权重最小的可以安全添加的边，将边添加到树中。**Kruskal算法**是对所有的权重进行排序，再次体现贪心算法的思想。通过对权重排序，将权重最小的边开始遍历，直至图中的所有节点都连在同一个树上，此时即为最小生成树。

## 设计
### 需求分析
  使用`python`，通过`Prim算法`和`Kruskal算法`实现图的`最小生成树`，输入数据以存放二维数组形式的逗号分隔值文件进行输入，比如`txt`文件或者`csv`文件，输出时按照`Prim算法`和`Kruskal算法`分别输出最小生成树的二维数组。同时使用`networkx`模块，绘制出相应的有权图。
![图1  程序执行流程图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS83NGMzNDFhZC01NjQzLTRjODYtOTA2NC1hOTkwODBiYmUwNzMucG5n)
具体运行逻辑为：

首先输入存放图数据的txt文件路径，然后系统显示菜单：

请选择相应功能模块：
- 1: 显示原始关系图及数据
- 2：查看prim算法演示
- 3：查看kruskal算法演示
- 4: 更改源文件
- 0：退出此次运行

正确的输入范围为0-3，并实现菜单中的相应功能，其输出形式以相应的关系图和二维数组的形式进行输出。
当输入内容不符合规范或致使程序运行出现错误时，会有相应提示并重新显示系统菜单。![图2  错误格式文件输入演示及纠正示例](https://gitee.com/mxdon/img/raw/master/2020/20200622214219711.png)

### 系统设计
本程序所用数据为存储在逗号分隔值文件中的二维数组，格式为：“首节点，尾节点，权重”。与一般的图结构程序相比，本程序采用的数据格式只取到程序的必要属性，即“首节点，尾节点，权重”，相比于通常的邻接矩阵或稀疏矩阵，三列元素的优势十分明显：易于分析，直观方便，输入便捷，纠错直接。
![图3  程序功能模块结构图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS83Y2Y3M2Y0Zi0wMzgzLTQ0NmUtYWM0ZC1mNmVhOTIyNzY5MGIucG5n)
其中main函数代码如下：
![图4  main函数截图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9jNTI5ZjYxMy1jYWRlLTRjMDktODk0Zi01ZmMyODNjYzRhNDYucG5n)
其中明显可以看出：输入文件名称时，是以调用函数的方式运行，显示菜单也是以函数的方式运行，加上结果必要进行的函数调用，这些都是为了节省代码的复用，使逻辑更加清晰。

此外在`main`函数中添加`try……except`语句，就在确认函数无逻辑错误的情况下，节省了在对各个函数的异常判断，提高了代码的简洁性。
### 系统实现
解决最小生成树问题常用的有Prim算法和Kruskal算法，二者均基于贪心算法。
#### Prim算法
Prim算法思想很简单，即每步都沿着最小权重的边向前搜索，找到一条权重最小的可以安全添加的边，将边添加到树中。

如以下图例（如图5）：
![图5  prim算法原始有权图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS80YTBlYTQ0Ni1hZWJjLTQ4MGUtYWNlYi1iMGNjMTUwYjhiMTMucG5n)

- Step1：首先从图中选取一个顶点，这一步是随机的，本程序中仍帮助用户做出了选择。
![图6  step1：选取顶点](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS8xNGM3MGYxZS1iNzY4LTQ0NzEtOWEzZC0xNmM0NzI1MmZiNjMucG5n)
- Step2：由当前顶点向未选节点进行遍历，找出最小的边，图中选取D作顶点，加入至已选节点，剩下的全部为未选节点，从顶点开始遍历到的边有DA、DB、DE、DF，最小边为DA无异，将A添加至已选节点中，并从未选节点中删去，进入下一步循环。
![图7  step2：选取最小边](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9lNGY0ZGQwZC1iODczLTQ4OTYtODkwYy02M2YzMGI4YTczYTkucG5n)
- Step3：遍历到相连的边有DB、DE、DF、AB，最小边为AB，将B添加至已选节点中，并从未选节点中删去，进入下一步循环。
![图8  step3：同step2](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS8wMGE5OTY5Ni05NjFjLTQ4YzMtOGI0ZC0zMmQ0MjhiNWZiYWMucG5n)

- Step4：遍历到相连的边有DE、DF、BC、BE，最小边为DF，将F添加至已选节点中，并从未选节点中删去，进入下一步循环。
![图9  step4：同step2](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9kMjAxZjZhYS1hYTY5LTQxZDQtOWY3MS0wZWNlNDQ1ZWI1NzUucG5n)

- Step5：遍历到相连的边有DE、BC、BE、FG，最小边为BE，将E添加至已选节点中，并从未选节点中删去，进入下一步循环。
![图10 step5：同step2](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9lMDA3NTFkMC02OTc1LTQ1MzItODFkYy01ZjBmNWU3M2M4ZjgucG5n)

- Step6：遍历到相连的边有BC、EC、FG、EG，最小边为EC，将C添加至已选节点中，并从未选节点中删去，进入下一步循环。
![图11  step6：同step2](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS80MjgxNDU5MC0xYjM3LTQ1MGMtYTgzOC05Njc4YmI2ZTYxOTYucG5n)

- Step7：遍历到相连的边有FG、EG，最小边为EG，将G添加至已选节点中，并从未选节点中删去，此时未选节点列表为空，符合结束条件，程序结束。
![图12 step7：当没有未选节点时结束](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS85MjBjYjUxOS03NzkwLTRkMGYtYTM3Mi00ZmE5MzlmOTJhNjcucG5n)
使用代码实现时，由于`prim算法`是沿着节点去找边，所以以未选取的节点的数量为限制条件进行搜索，在一个最小生成树结构中，如果有某一个节点与其他任一节点都不存在联系，这个数据就是无效数据，当发现不再有这种数据时，也就是得到了一个完整的最小生成树。程序中，我将`i`定义为`首节点`，`j`定义为`尾节点`，在已经选取的节点中遍历i，遍历i的同时在预选取节点中遍历j，这样就可以将所有的节点情况一一遍历。而寻找最小的边时，首先通过“`if (li[0] == i and li[1] == j) or (li[0] == j and li[1] == i) :`”进行判断，如果`i`节点和`j`节点相连，就将‘`ij`’作为`key`，权值作为`value`，加入字典`edge_weight`中，这里巧妙的运用了字典的`key`是一个字符串的不会乱序的特征，通过`lambda`表达式进行排序，很容易按照`key`的索引和权重大小，找到符合条件的——最短的边，以及与之相对应的ij首位节点。这里已选节点和预选节点都使用了列表的格式，所以只要再依次把符合条件的尾节点从预选节点中`remove`掉，再`append`至已选节点列表中即可。代码截图如（图13）。
![图13  prim算法实现代码截图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9lMWI1NzY2My0zYTNkLTQ4YjctODUyMy03NTAxNWI2NWRkZDEucG5n)
#### Kruskal算法
`Kruskal算法`是对所有的权重进行排序，再次体现贪心算法的思想。通过对权重排序，将权重最小的边开始遍历，直至图中的所有节点都连在同一个树上，此时即为最小生成树。

如以下图例（如图14，同图5）：
![图14  kruskal算法原始有权图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS80YTBlYTQ0Ni1hZWJjLTQ4MGUtYWNlYi1iMGNjMTUwYjhiMTMucG5n))

- Step1：遍历所有边，最小边是AD或CE，排序中除权重外还会以ASCII码排序，选AD为最小边，加入到最小生成树中，A、D添加至已选节点，剩下的为未选节点。
![图15  step1：选取最小边](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS8xOWE0ZjdiMy1jYTZhLTRkZDMtOTNkYy03ZGU3NDE0NjdmODEucG5n)

- Step2：继续遍历剩下的边，CE为最小边，加入到最小生成树中，C、E添加至已选节点，剩下的为未选节点。
![图16  step2：同step1](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9lYzg4OTRmMy00ZDJlLTQ1ZjYtYjRkZi1jODkyMzljOTViMWEucG5n)

- Step3：继续遍历剩下的边，符合条件的最小边依次为：DF、AB、BE，加入到最小生成树中，将B、F添加至已选节点，剩下的为未选节点。
![图17  step3：同step1](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9hM2M1MzQzYy0xM2QyLTRmNmEtYjhiMS1iZmRkODRhYTNkMmYucG5n)

- Step4：同上，虽然BC比EG更小，但点BC已经通过E点连通，所以添加第二最小边EG，此时所有节点在同一个树中，程序结束。
![图18  step4：当边的数量达到节点数-1时结束](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9lZDcwYmZlMS1jNmNjLTQwZGQtYjY3Mi1kNmNlOWNhZmQ0NzEucG5n)
使用代码实现时，由于kruskal算法是依次遍历最小边，所以以最小生成树的边与总节点数的关系作为约束条件。一开始程序沿用`prim算法`中将未添加节点作为限制条件，但是很快发现逻辑的疏漏：倘若有`A`、`B`、`C`、`D`四个节点，按最小边`AB`和`CD`添加至最小生成树之后，`ABCD`四个点并不连通，属于两个树，模型如下图（图19）：
![图19  节点全部已选时图不连通的情况](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS84MmYyNTE2Ny1lYjg0LTQyODItOWJjNy0zODUzOWQxMjFjM2IucG5n)
经过观察，最小生成树的边和节点的数目关系符合“`边数 = 节点数 – 1`”， 所以以最小生成树的边与总节点数的关系作为约束条件，判断下一条最小边的首尾节点与已选节点的关系。这里由于每次涉及到两个节点、重复节点的添加和去除，所以已选节点和未选节点以集合的形式进行运算，解决了添加节点的重复问题，在从预选节点中去除时，也只需选择在全部节点集合中，而不在已选节点集合中的集合，即“`candidate_node = candidate - selected_node`”。

判断逻辑如上述，首先选取最小边，判断最小边的首尾节点是否已经被选，如果目标最小边的首尾节点任有一个节点不在已选节点当中，或者都不在已选节点当中，那么可以直接添加该最小边，并将首尾节点去重添加到已选节点集合当中；如果目标最小边的首尾节点均在已选节点当中，并且此时已连接的最小生成树的边数小于已选节点数减一，那么由于首尾节点均在已选节点集合当中，此时只需要将该最小边添加到最小生成树当中即可。代码截图如（图20）。
![图20  kruskal算法实现代码截图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9iMWNmMjc1Ni0xM2U0LTQxMTYtYjIwMy0xYTAyZTY0YTFhNzYucG5n)

### 功能介绍
本程序使用python3.7.3版本进行编程，如有运行报错，请更换python版本为3.7.3或其他适配版本进行测试。

运行程序后会显示系统名称及作者信息。
![图21  最小生成树系统运行截图](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS81NTQwMDAxZi0yMzBhLTRjYjItYjM0Yi1hYWQwMWJhNDk4ODMucG5n)
使用示例如下：
![图24  功能1终端输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9hNTRiNzgzOC0xMzRmLTRiNGQtODM3OC1kNzc3NTA4MTkxYTIucG5n)

![图25  功能2图像输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9hN2EwMGQ5Ni0xY2Y1LTQ3MGYtOTdjYS1jMjVkOGFjOThjMjYucG5n)

![图26  功能2终端输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9mOTU0YTY2ZC00OTI0LTRjODUtYThkNC1jMTFhMjk1MWUwNjYucG5n)

![图27  功能2图像输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS82M2IxNjc4NC02NDg0LTQ0ZGEtYjI5Mi04OGYxYzEzZThiODUucG5n)

![图28  功能3终端输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS9lNGE5YjIzZC00NDhlLTQ5ODgtYjYwYi0wMGNjYjEzYTBjYWQucG5n)

![图29  功能3图像输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS84N2ExNzJlNC03ODIwLTRiNzgtOGRhMS1kNDFmYmM4ZTg5ZmIucG5n)


![图30  功能4终端输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS85Y2ZlYjcyZC0xMDIxLTQyOTQtODgwOS01NmUxZThmNzQ2MWMucG5n)

![图31  功能0终端输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS8xYzZmMTQ5My00MDYyLTRiM2ItYjc5My0yZjMwZjE3Yzk2YjMucG5n)

![图32  异常处理功能终端输出示例](https://gitee.com/mxdon/img/raw/master/2020/aHR0cHM6Ly9pbWdrci5jbi1iai51ZmlsZW9zLmNvbS83OWE2MDVjOS03NWQ0LTRmMjktOTMzOS04MzkwMGU5Yjg2YWUucG5n)
## 测试数据及代码
### 测试数据
| 首节点 | 尾节点 | 权重 |
| ------ | ------ | ---- |
| A      | B      | 2    |
| A      | C      | 3    |
| B      | C      | 1    |
| B      | D      | 1    |
| B      | E      | 4    |
| E      | F      | 1    |
| C      | F      | 5    |
| F      | G      | 1    |
| D      | E      | 1    |
### 完整代码
```python
import networkx as nx
import matplotlib.pyplot as plt
import sys
import os
G = nx.Graph()  #原始有权图
P = nx.Graph()  #画prim生成的最小生成树有权图
K = nx.Graph()  #画Kruskal生成的最小生成树有权图


nodedict={}     #节点的字典集，这里选择字典，既保证了数据不会重复，也可以排序，选择初始顶点，对于选择纠结症的人非常实用
edgelist=[]     #边的列表
labels={}       #标签，即所有的节点名称，画节点信息时使用
edges={}
def read_file(fileroute):
    with open(fileroute,"r") as f:
        for line in f:
            l=line.strip().split("\t")
            l[2] = float(l[2])
            edgelist.append(l)
            nodedict[l[0]]=l[0]
            nodedict[l[1]]=l[1]
    # 对字典进行排序，以便选取图的顶点，防止选择纠结症，方便绘制节点信息
    for i in sorted(nodedict):
        labels[i]=nodedict[i]

    return (nodedict,edgelist,labels)

def origin(fileroute):
    # 从存储图数据的文件中读取数据
    # nodedict=read_file(fileroute)[0]
    edgelist=read_file(fileroute)[1]
    labels=read_file(fileroute)[2]

    # print(edgelist)
    G.add_weighted_edges_from(edgelist)
    # 完成图原始数据的读取
    edge_labels = nx.get_edge_attributes(G,'weight')
    # 生成节点位置
    pos = nx.spring_layout(G)
    # 把节点画出来
    nx.draw_networkx_nodes(G, pos, node_color='g', node_size=500, alpha=0.8)
    # 把边画出来
    nx.draw_networkx_edges(G, pos, width=1.0, alpha=0.5)
    # # 把节点的标签画出来
    nx.draw_networkx_labels(G, pos, labels, font_size=16)
    # # 把边权重画出来
    nx.draw_networkx_edge_labels(G, pos, edge_labels)
    plt.title("origin")
    plt.show()


"""
实现prim算法的函数
"""
def prim_tree(fileroute):
    # 从存储图数据的文件中读取数据
    nodedict = read_file(fileroute)[0]
    edgelist = read_file(fileroute)[1]
    labels = read_file(fileroute)[2]

    res=[]                  # 使用prim算法时最小生成树的边列表

    prim_candidate_node=[]       # 预选节点
    prim_selected_node=[]        # 已选节点

    for key in labels:          # 初始时，所有节点均为预选节点
        prim_candidate_node.append(key)

    prim_selected_node.append(prim_candidate_node[0])
    prim_candidate_node.remove(prim_selected_node[0])
    """
        实现prim算法的逻辑代码
    """
    while len(prim_candidate_node) > 0 :       # prim算法是沿着节点去找边，所以已未选取的节点为限制条件进行搜索
        edge_weight={}
        beginnode=''
        endnode=''
        weight=0
        for i in prim_selected_node:        # 将i定义为首节点
            for j in prim_candidate_node:   # 将j定义为尾节点
                for li in edgelist:
                    if (li[0] == i and li[1] == j) or (li[0] == j and li[1] == i) :
                        # 如果i节点和j节点相连，就将‘ij’作为key，权值作为value，加入字典edge_weight中
                        edge_weight[i+j]=li[2]
        for key in sorted(edge_weight.items(),key=lambda kv:(kv[1], kv[0])):
            # 将edge_weight字典从小到大排序，第一个值是最小值，根据key的ij排列顺序，很容易判断出首尾节点
            endnode=key[0][1]
            weight=float(key[1])
            beginnode=key[0][0]
            break
        res.append([beginnode,endnode,weight])  # 然后将选取的最小权值的边加入到最小生成树中即可
        prim_selected_node.append(endnode)
        prim_candidate_node.remove(endnode)
    print(res)
    P.add_weighted_edges_from(res)
    edge_labels = nx.get_edge_attributes(P, 'weight')
    # 生成节点位置
    pos = nx.spring_layout(P)
    # 把节点画出来
    nx.draw_networkx_nodes(P, pos, node_color='g', node_size=500, alpha=0.8)
    # 把边画出来
    nx.draw_networkx_edges(P, pos, width=1.0, alpha=0.5, edge_color='r')
    # 把节点的标签画出来
    nx.draw_networkx_labels(P, pos, labels, font_size=16)
    # 把边权重画出来
    nx.draw_networkx_edge_labels(P, pos, edge_labels)
    plt.title("prim")
    plt.show()

"""
实现kruskal算法的函数
"""
def kruskal_tree(fileroute):
    edgelist = read_file(fileroute)[1]
    labels = read_file(fileroute)[2]

    nodenum = len(labels)       # 节点数

    candidate = set()           # 全部节点
    selected_node = set()       # 已选节点

    for key in labels:
        candidate.add(key)

    candidate_node = set(candidate) # 预选节点，这里设置预选节点，方便之后去重判断

    edgesorted = sorted(edgelist, key=lambda weight: weight[2])     # 按照权值对所有边进行排序，体现贪心算法思想

    """
        实现kruskal算法的逻辑代码
    """
    edge_node = {}
    edgelist_chosed = []

    while len(edgelist_chosed) < nodenum - 1:
        for li in edgesorted:
            if li[0] not in selected_node or li[1] not in selected_node:
                edgelist_chosed.append(li)
                selected_node.add(li[0])
                selected_node.add(li[1])
                candidate_node = candidate - selected_node
            elif li[0] in selected_node and li[1] in selected_node and len(edgelist_chosed) < len(selected_node) - 1:
                edgelist_chosed.append(li)
            else:
                continue

    print(edgelist_chosed)
    K.add_weighted_edges_from(edgelist_chosed)
    edge_labels = nx.get_edge_attributes(K, 'weight')
    # 生成节点位置
    pos = nx.spring_layout(K)

    # 把节点画出来
    nx.draw_networkx_nodes(K, pos, node_color='g', node_size=500, alpha=0.8)

    # 把边画出来
    nx.draw_networkx_edges(K, pos, width=1.0, alpha=0.5, edge_color='r')

    # # 把节点的标签画出来
    nx.draw_networkx_labels(K, pos, labels, font_size=16)

    # # 把边权重画出来
    nx.draw_networkx_edge_labels(K, pos, edge_labels)
    plt.title("kruskal")
    plt.show()

def menu():
    print("""
    请选择相应功能模块：
    1: 生成原始关系图
    2：查看prim算法演示
    3：查看kruskal算法演示
    4: 更改源文件
    0：退出此次运行
    """)
def filein():
    fileroute = ''
    flag = True
    while flag:
        fileroute = input('请输入正确的图数据的完整路径：')
        if os.path.isfile(fileroute):
            flag = False
    return fileroute

def main():
    print("----Python实现最小生成树的两种方式----")
    print("----作者：Mxdon----")
    fileroute=filein()
    menu()
    while True:
        try:
            chose = input("您的输入是数字：")
            if chose=="1":
                print("原始有权图已绘制")
                origin(fileroute)
                menu()
            elif chose=="2":
                print("prim算法时的最小生成树的图已绘制")
                print("---prim算法最小生成树边数据如下：---")
                prim_tree(fileroute)
                menu()
            elif chose=="3":
                print("kruskal算法时的最小生成树的图已绘制")
                print("---kruskal算法最小生成树边数据如下：---")
                kruskal_tree(fileroute)
                menu()
            elif chose=="4":
                fileroute = filein()
                menu()
            elif chose=="0":
                print("---再见---")
                sys.exit(0)
            else:
                print("无此选项")
                menu()
        except Exception as e:
            print("\033[31m请检查文件内容是否符合“节点-节点-权重”的格式!\033[0m")

main()


```
## 参考文章
[数据结构（十）：最小生成树](https://www.jianshu.com/p/cf21443b3838)
[python最小生成树kruskal与prim算法](https://blog.csdn.net/mashijia986/article/details/79100925)
[最小生成树的两种方法（Kruskal算法和Prim算法）](https://blog.csdn.net/a2392008643/article/details/81781766)
[最小生成树-Prim算法和Kruskal算法](https://www.cnblogs.com/biyeymyhjob/archive/2012/07/30/2615542.html)
[数据结构基础概念篇](https://blog.csdn.net/qq_31196849/article/details/78529724)
[数据结构：八大数据结构分类](https://blog.csdn.net/yeyazhishang/article/details/82353846#8%E5%9B%BE)
[数据结构与算法Python版-陈斌](https://www.icourse163.org/learn/PKU-1206307812?tid=1206626211#/learn/content?type=detail&id=1212763078&cid=1216399015&replay=true)
[NetworkX系列教程(10)-算法之二:最小/大生成树问题](https://www.cnblogs.com/wushaogui/p/9239959.html)
[Python 3 教程](https://www.runoob.com/python3/python3-tutorial.html)
