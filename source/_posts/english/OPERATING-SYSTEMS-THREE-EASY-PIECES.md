---
title: OPERATING SYSTEMS THREE EASY PIECES
date: 2019-10-31 15:35:33
categories: [翻译]
tags: [操作系统]
---

# 操作系统

## 三个简单的部分

<!--more-->

## 威斯康辛大学麦迪逊分校

2014年由Arpaci-Dusseau Books，Inc.

版权所有

致Vedat S. Arpaci，一生的灵感

# 前言

致读者：

欢迎阅读本书！我们希望诸位能够像我们写这本书一般享受地阅读这本书。这本书叫做《操作系统：三个简单的部分》，这个名字显然是为了致敬有史以来最伟大的演讲笔记集之一的，由理查德·费曼（Richard Feynman）撰写，主题为物理学[F96]。然而当这本书也将毫无疑问是达不到那位著名的物理学家设定的高标准，也许在您所寻求的范围内，了解什么是操作系统（更广泛地说，系统）就足够了。

三个简单的部分指的是这本书有组织围绕的三个主要主题元素：虚拟化、并发性、持久性。在讨论这些概念时，我们将讨论操作系统要做的大多数重要事情，希望您也能够在旅途当中有些乐趣。学习新事物是很有趣的，是吧？至少说，应该是。

每个主要概念会被分成一组章节，其中大多数是提出一个特定的问题，然后说明如何解决。这些章节很简短，请尝试（尽可能地）去参考想法真正来源的原始材料。我们写这本书的目的之一就是让历史的轨迹尽可能地清晰，因为我们认为这会帮助一个学生更清晰地理解这是什么，这曾是什么，这将是什么。在这种情况下，了解如何制作香肠与了解香肠的益处几乎同样重要。

我们在书中使用的一些设备应该在这里介绍一下。第一个是问题的关键。当我们试图解决一个问题时，我们首先要说明最重要的问题是什么;本书问题的关键在文中被明确地指出，并希望通过本文其余部分提供的技术、算法和思想来解决。

还有许多旁白和提示贯穿全文，增加了一点颜色的主线表示。题外话倾向于讨论与正文相关(但可能不是必需的)的内容;提示往往是可以应用于您构建的系统的一般经验。本书末尾的索引列出了所有这些技巧和旁白(还有cruces, crux的复数形式)，供您参考。

我们使用最古老的教学方法之一，对话，贯穿全书，作为一种以不同的角度呈现材料的方式。这些是用来介绍主要的主题概念(我们将会看到，以一种非常好的方式)，以及不时地复习材料。他们也有机会以更幽默的风格写作。不管你觉得它们是有用的还是幽默的，那完全是另一回事了。

在每个主要部分的开头，我们将首先介绍操作系统提供的抽象，然后在后续章节中讨论提供抽象所需的机制、策略和其他支持。抽象对于计算机科学的所有方面都是基础，所以它们在操作系统中也是必不可少的，这也许并不奇怪。

在整个章节中，我们尝试在可能的地方使用真正的代码(而不是伪代码)，因此对于几乎所有的示例，您应该能够自己键入并运行它们。在真实的系统上运行真实的代码是学习操作系统的最好方法，所以我们鼓励您在可能的时候这样做。

在课文的不同部分，我们已经穿插了一些作业，以确保你理解了正在发生的事情。很多作业都是对操作系统的模拟;你应该下载家庭作业，并运行它们来测试你自己。家庭作业模拟器有如下特点:通过给它们一个不同的随机种子，你可以产生一个几乎无限的问题集;模拟器也可以为你解决问题。因此，你可以反复测试你自己，直到你达到了一个很好的理解水平。

本书最重要的附录是一组项目，在这些项目中，您可以通过设计、实现和测试自己的代码来了解实际的系统是如何工作的。所有项目(以及上面提到的代码示例)都使用C编程语言[KR88];C是一种简单而强大的语言，它是大多数操作系统的基础，因此值得添加到您的语言工具箱中。有两种类型的项目(见在线附录中的想法)。第一类是系统编程项目;对于那些刚接触C和UNIX并希望学习如何进行低级C编程的人来说，这些项目是非常好的。第二类是基于在麻省理工学院开发的一个真正的操作系统内核xv6 [CK+08];这些项目对于那些已经有一些C并且想要在操作系统中动手的学生来说是非常棒的。在威斯康星州，我们以三种不同的方式运行这门课程:要么所有的系统编程，要么所有的xv6编程，要么两者兼而有之。

致教育工作者：

如果你是一位教师或教授，希望使用这本书，请随意这样做。你可能已经注意到，它们是免费的，可从以下网页下载:`http://www.ostep.org`

你也可以从lulu.com网站上购买一本印刷本。在上面的网页上寻找它。

本书(目前)的正确引用如下:

> Operating Systems: Three Easy Pieces
> Remzi H. Arpaci-Dusseau and Andrea C. Arpaci-Dusseau Arpaci-Dusseau Books, Inc.
> May, 2014 (Version 0.8)
> http://www.ostep.org

本课程分为15周的学期，你可以在一个合理的深度范围内涵盖大部分的主题。将课程压缩到一个10周的季度中，可能需要从每个部分删除一些细节。还有几章是关于虚拟机监视器的，我们通常会在学期的某个时候挤进去，要么是在虚拟化这一大节的最后，要么是在临近尾声的时候。

这本书的一个稍微不寻常的方面是并发性，这是许多操作系统书籍前面的一个主题，在这里被推迟，直到学生已经理解了CPU和内存的虚拟化。在我们的经验在教学这门课程近15年来,学生很难理解并发问题,或者为什么他们试图解决它,如果他们还不理解一个地址空间是什么,什么是一个过程,或者为什么上下文切换可能发生在任意时间点上。一旦他们理解了这些概念，然而，引入线程的概念以及由此产生的问题就变得相当容易了，或者至少更容易了。

你可能已经注意到，书里没有幻灯片。这种遗漏的主要原因是我们相信最古老的教学方法:粉笔和黑板。因此，当我们教这门课的时候，我们带着一些主要的想法和例子来上课，并用黑板来展示它们;讲义和现场代码演示也很有用。根据我们的经验，使用太多的幻灯片会鼓励学生“检查”课堂内容(并登录facebook.com)，因为他们知道这些内容是供他们稍后消化的;使用黑板使讲课成为一种“现场”观摩体验，因此(希望如此)课堂上的学生更有互动性、动态性和趣味性。

如果你想要一份我们上课准备的笔记，请给我们发邮件。我们已经与世界各地的许多人分享了它们。

最后一个请求:如果你使用免费的在线章节，请链接到它们，而不是在本地复制。这有助于我们跟踪使用情况(过去几年下载了超过100万章!)，并确保学生得到最新和最好的版本。

致学生：

如果你是在读这本书的学生，谢谢你!我们很荣幸能够提供一些材料来帮助您学习操作系统方面的知识。我们都深情地回忆起我们大学时代的一些教科书(例如，Hennessy和Patterson [HP90]，计算机建筑学的经典著作)，希望这本书能成为你积极的回忆之一。

你可能已经注意到这本书是免费的，可以在网上找到。有一个主要的原因:教科书通常太贵了。我们希望，这本书是新一波免费材料的第一波，帮助那些追求教育的人，不管他们来自世界的哪个地方，也不管他们愿意为一本书花多少钱。如果做不到这一点，那就是一本免费的书，这总比没有好。

如果可能的话，我们还希望向您指出书中大部分材料的原始来源:多年来影响操作系统领域的伟大论文和人物。思想不是凭空而来的;他们来自聪明、勤奋的人(包括许多图灵奖获得者)，因此我们应该尽可能地赞美这些思想和人。在这样做的过程中，我们希望能够更好地理解已经发生的革命，而不是把这些思想当作始终存在的文本来写[K62]。此外，也许这样的推荐会鼓励你自己深入挖掘;阅读我们这个领域的著名论文无疑是最好的学习方法之一。

致谢：

这一节将包含对那些帮助我们整理这本书的人的感谢。现在最重要的是:你的名字可以出现在这里!但是，你必须帮助他们。所以请给我们一些反馈并帮助我们调试这本书。你可能会出名!或者,

至少，把你的名字写在某本书里。

到目前为止，帮助过他们的人包括:Abhirami Senthilkumaran*， Adam Drescher, Adam Eggum, Ahmed Fikri*， Ajaykrishna Raghavan, Alex Wyler, Anand Mundada, B. Brahmananda Reddy, Bala Subrahmanyam Kambala, Benita Bose, Biswajit Mazumder (Clemson)， Bobby Jack, Bj¨orn Lindberg, breni -nan Payne, Brian Kroth, Cara Lauritzen, Charlotte Kissinger, Shen Chien-Chung

(特拉华州)*,科迪汉森,丹Soendergaard(美国奥尔胡斯),大卫Hanle (Grin-nell),迪Muthukumar,多里安人阿诺德(新墨西哥州)、达斯汀·麦茨勒,达斯汀Passofaro,艾米丽·雅各布森,艾美特Witchel(德州),恩斯特Biersack(法国),芬恩Kuusisto *, Guilherme巴普蒂斯塔哈米德Reza Ghasemi,亨利修道院,Hrishikesh黑龙江,嘉定区环城路张*,杰克Gillberg,詹姆斯•佩里(美国Michigan-Dearborn) *杰Lim杰洛德Weinman(格林奈尔),乔尔·索莫斯(高露洁),乔纳森·佩里(麻省理工学院),小君

他,卡尔·沃林Kaushik Kannan,凯文刘*,Lei田布拉斯加-林肯(美国),莱斯利·舒尔茨Lihao Wang玛莎摩天,Masashi Kishikawa(索尼)、马特•Rei-choff马蒂·威廉姆斯,孟黄,Mike Griepentrog明陈(石溪),穆罕默德Alali(特拉华州),基于Kandaswamy,娜塔莎Eilbert, Nathan Dipiazza,内森·沙利文Neeraj Badlani说(北卡罗来纳州状态),纳尔逊•戈麦斯Nghia黄齐(德州)会长Patricio hara雷德福史密斯Ripudaman辛格,罗斯•艾肯Rus -

局域网Kiselev阮兰德赫里克,沉着的Al-Kiswany Sandeep Ummadi(明尼苏达州)Satish Chebrolu (NetApp) Satyanarayana Shanmugam *,赛斯花粉、Sharad Punuganti Shreevatsa R, Sivaraman Sivaraman *, Srinivasan Thirunarayanan *, Suriyhaprakhas巴拉罗姆珊,Sy金却,托马斯•Griebel郑同心,托尼Adkins,通润Rudeen(普林斯顿大学),陀王Varun大桶,徐Di,悦翔Peng卓

(德州农工大学)，任玉飞，Zef RosnBrick, Zuyu Zhang。特别感谢那些在上面加了星号的人，他们提出了许多改进的建议。

特别感谢Joe Meehean教授(Lynchburg饰演)对每一章的详细注释，感谢Jerod Weinman教授(Grinnell饰演)和他的全班同学制作了令人难以置信的小册子，感谢Shen Chien-Chung教授(Delaware饰演)对这本书的阅读和评论。这三位作者对本文材料的完善都给予了不可估量的帮助。

同时，非常感谢这些年来参加537课程的数百名学生。特别是08年秋季班的学生，他们鼓励第一次写这些笔记(他们厌倦了没有任何课本可读——有进取心的学生!)你真的应该写一本教科书!在那一年的课程评估中)。

我们也非常感谢那些参与xv6项目的勇敢的少数人

实验课程，其中大部分现在被纳入主要的537课程。从09年春开始:贾斯汀·切尼克，帕特里克·迪林，马特·捷克，托尼·格雷戈森，迈克尔·格里普特洛格，泰勒·哈特，瑞恩·克罗斯，埃里克·拉济科夫斯基，韦斯利·里尔丹，拉吉夫·瓦迪亚纳坦，克里斯托弗·瓦克拉维克。从09年秋季开始:Nick Bearson, Aaron Brown, Alex Bird, David Capel, Keith Gould, Tom Gould, Jeffrey Hugo, Brandon Johnson, John Kjell, Boyan Li, James Loethen, Will McCardell, Ryan Szaroletta，Simon Tso和Ben Yule。从10年春季开始:帕特里克·布莱西、艾丹·丹尼斯-欧林、帕拉斯·多西、杰克·弗里德曼、本杰明·弗里施、埃文·汉森、皮克奇利·赫曼斯、迈克尔·琼、亚历克斯·兰根菲尔德、斯科特·里克、迈克·特雷费特、加瑞特·斯托斯、布伦南·沃尔、汉斯·维尔纳、苏扬和卡洛斯·格里芬(几乎)。

虽然他们没有直接帮助我们写这本书，但是我们的研究生已经教会了我们很多关于系统的知识。他们在威斯康辛的时候，我们定期与他们交谈，但他们做所有真正的工作——通过告诉我们他们在做什么，我们每周都能学到新东西。这份名单包括以下我们与之合作发表论文的在读学生和以前的学生;一个星号表示在我们指导下获得博士学位的人:阿布Rajimwale, Ao妈,布莱恩·福尼克里斯•Dragga Deepak Ramamurthi Florentina Popovici *, Haryadi Gunawi *,詹姆斯·纽金特,约翰*弯曲,Lanyue Lu Lakshmi Bairavasundaram *, Laxman Visampalli, Leo Arulraj Meenali Rungta, Muthian Si-vathanu *,内森·伯内特* Nitin Agrawal *,斯萨勃拉曼尼亚*,斯蒂芬•托德•琼斯* Swaminathan兰*,Swetha Krishnan, Thanh, Thanumalayan s Pillai Timothy Denehy *泰勒哈特,Venkat Venkataramani,维贾伊奇丹巴拉姆,Vijayan普拉巴卡兰*,张一英*，张玉普*，蔡夫·韦斯。

最后还要感谢艾伦·布朗，他在许多年前(2009年春季)第一次上了这门课，然后又上了xv6的实验课(2009年秋季)，最后当了两年左右的研究生助教(2010年秋季到次年春季)。他孜孜不倦的工作极大地改善了项目的状态(特别是那些在xv6地区的项目)，从而帮助威斯康星州无数的本科生和研究生获得更好的学习体验。就像艾伦会说的那样(用他一贯简洁的方式):“谢谢。”

作者寄语：

叶芝有句名言:“教育不是灌满一桶水，而是点燃一团火。”他是对的，但同时也是错的。你确实需要“把桶装满”一点，这些笔记对你的这部分教育是有帮助的;毕竟，当你去谷歌面试时，他们会问你一个关于如何使用信号量的难题，知道信号量是什么可能更好，对吧?

但叶芝更大的观点显然是切中要害的:教育的真正意义在于让你对某件事感兴趣，让你自己对这个主题有更多的了解，而不仅仅是为了在某门课上取得好成绩而必须消化的东西。正如我们的一位父亲(雷姆齐的父亲，Vedat Arpaci)常说的那样，“在课堂之外学习”。

我们做这些笔记是为了激发你对操作系统的兴趣，让你自己阅读更多关于这个主题的内容，和你的教授谈论这个领域里正在进行的所有令人兴奋的重新搜索，甚至是参与到那个研究中去。这是一个伟大的领域(!)，充满了令人兴奋和精彩的想法，这些想法深刻而重要地塑造了计算的历史。虽然我们知道这火焰不会照亮你们所有人，但我们希望它照亮许多人，甚至少数人。因为一旦那把火点燃，那就是你真正有能力做一些伟大的事情的时候。因此，教育过程的真正意义在于:继续前进，学习许多新奇而有趣的话题，去学习，去成熟，最重要的是，去发现能点燃你热情的东西。

Andrea and Remzi
Married couple
Professors of Computer Science at the University of Wisconsin
Chief Lighters of Fires, hopefully4

# 参考文献

[CK+08] “The xv6 Operating System”
Russ Cox, Frans Kaashoek, Robert Morris, Nickolai Zeldovich
From: http://pdos.csail.mit.edu/6.828/2008/index.html
xv6 was developed as a port of the original UNIX version 6 and represents a beautiful, clean, and simple way to understand a modern operating system.
[F96] “Six Easy Pieces: Essentials Of Physics Explained By Its Most Brilliant Teacher” Richard P. Feynman
Basic Books, 1996
This book reprints the six easiest chapters of Feynman’s Lectures on Physics, from 1963. If you like Physics, it is a fantastic read.
[HP90] “Computer Architecture a Quantitative Approach” (1st ed.)
David A. Patterson and John L. Hennessy
Morgan-Kaufman, 1990
A book that encouraged each of us at our undergraduate institutions to pursue graduate studies; we later both had the pleasure of working with Patterson, who greatly shaped the foundations of our research careers.
[KR88] “The C Programming Language”
Brian Kernighan and Dennis Ritchie
Prentice-Hall, April 1988
The C programming reference that everyone should have, by the people who invented the language.
[K62] “The Structure of Scientiﬁc Revolutions”
Thomas S. Kuhn
University of Chicago Press, 1962
A great and famous read about the fundamentals of the scientiﬁc process. Mop-up work, anomaly, crisis, and revolution. We are mostly destined to do mop-up work, alas.

# 目录

@[toc]

# 一段对话

教授:欢迎来到这本书!它被称为“操作系统——三个简单的部分”，我在这里要教你们关于操作系统需要知道的事情。我被称为“教授”;你是谁?

教授你好!我被称为“学生”，你可能已经猜到了。我在这里，准备学习!

教授:听起来不错。有什么问题吗?

学生:当然!为什么叫“三个简单的部分”?

教授:这很简单。嗯，你看，理查德·费曼有很多精彩的物理讲座……

学生:哦!那个写"你肯定是在开玩笑，费曼先生"的家伙，对吧?伟大的书!这会像那本书一样搞笑吗?

教授:嗯…嗯,没有。那本书很好，我很高兴你读了它。希望这本书更像他的物理笔记。其中一些基础知识被总结在一本名为《六个简单的部分》的书中。他在讲物理;关于操作系统这个话题，我们将做三个简单的部分。这是适当的，因为操作系统的难度大约是物理的一半。

学生:嗯，我喜欢物理，所以这可能很好。那些是什么?

教授:它们是我们将要学习的三个关键思想:虚拟化、并发性和持久性。在学习这些想法,我们将了解所有操作系统是如何工作的,包括如何决定什么程序在一个CPU上运行下,如何处理内存过载在虚拟内存制度,虚拟机监视器是如何工作的,如何管理磁盘信息,甚至对如何构建一个分布式系统,当部分已经失败。诸如此类。

学生:我不知道你在说什么，真的。

教授:好!这意味着你在正确的班级。

学生:我还有一个问题:学习这些东西的最好方法是什么?

教授:问得好!当然，每个人都需要自己找出答案，但我的做法是:去上课，听教授介绍材料。然后，在每个周末，读一读这些笔记，帮助你更好地理解这些想法。当然，一段时间后(提示:考试前!)，再次阅读笔记来巩固你的知识。当然，你的教授肯定会布置一些作业和项目，所以你应该去做;特别是，在项目中编写真正的代码来解决真正的问题是将这些想法付诸实践的最佳方式。孔子说过……

学生:哦，我知道!“我听见了，却忘了。我看见，我记得。我知道，我理解。”“或者诸如此类的话。

教授:(惊讶地)你怎么知道我要说什么?

学生：似乎是这样。而且，我是孔子的超级粉丝。

教授:嗯，我想我们会相处得很好的!真棒。

学生:教授，请允许我再问一个问题。这些对话是做什么用的?我是说，这不应该是一本书吗?为什么不直接展示材料呢?

教授:啊，好问题，好问题!嗯，我认为有时候把自己从叙述中拉出来思考一下是有用的;这些对话就是那个时代。所以你和我将一起努力理解所有这些非常复杂的想法。你准备好了吗?

学生：所以我们必须思考?我准备好了。我是说，我还需要做什么?除了这本书，我并没有什么经验。

教授:我也是，很遗憾。让我们开始工作吧!

# 操作系统简介

如果你正在上一门操作系统的本科课程，你应该已经对计算机程序在运行时的功能有了一些了解。如果没有，这本书(以及相应的课程)将会很难——所以你可能应该停止阅读这本书，或者跑到最近的书店，在继续阅读之前快速地阅读必要的背景材料(Patt/Patel [PP03]和特别是Bryant/O’hallaron [BOH10]都是非常棒的书)。

那么当程序运行时会发生什么呢?

一个正在运行的程序做一件非常简单的事情:它执行指令。每秒钟有数百万次(现在甚至数十亿次)，处理器从内存中取出一条指令，并对其进行解码。，找出这是哪条指令)，并执行它(即，它做它应该做的事情，比如把两个数字相加，访问内存，检查一个条件，跳转到一个函数，等等)。处理完这条指令后，处理器继续处理下一条指令，

以此类推，直到程序最终完成。

因此，我们刚刚描述了冯·诺依曼模型的基础

computing2。听起来很简单,对吧?但是在这门课上，我们将会学到，当一个程序运行的时候，许多其他的疯狂的事情正在发生，它们的主要目标是使系统易于使用。

实际上，有一个软件系统负责使程序的运行变得容易(甚至允许您同时运行许多程序)，允许程序共享内存，允许程序与设备交互，以及诸如此类的其他有趣的事情。软件的主体被称为操作系统(OS)3，因为它负责确保系统以一种易于使用的方式正确和有效地运行。

操作系统实现这一点的主要方式是通过一种我们称为虚拟化的通用技术。也就是说，操作系统获取物理资源(如处理器、内存或磁盘)并将其转换为更通用、更强大、更易于使用的虚拟形式。因此，我们有时将操作系统称为虚拟机。

当然，为了让用户告诉操作系统要做什么，从而利用虚拟机的特性(如运行程序、分配内存或访问文件)，操作系统还提供了一些可以调用的接口(api)。实际上，一个典型的操作系统会导出几百个对应用程序可用的系统调用。因为OS提供了这些调用来运行程序、访问内存和设备，以及其他相关操作，所以我们有时也会说OS为应用程序提供了一个标准库。

最后，由于虚拟化允许许多程序运行(从而对CPU进行碎片化)，许多程序并发地访问它们自己的指令和数据(因此共享内存)，许多程序访问设备(因此共享磁盘等等)，因此OS有时被称为资源管理器。每个CPU、内存和磁盘都是系统的资源;因此，操作系统的角色是管理这些资源，高效、公平地完成这些工作，或者考虑到许多其他可能的目标。为了更好地理解操作系统的作用，我们来看一些示例。

> 关键问题：如何虚拟化资源
>
> 本书中我们要回答的一个核心问题非常简单:操作系统如何虚拟化资源?这是我们问题的症结所在。为什么操作系统会这样做并不是主要的问题，因为答案应该是显而易见的:它使系统更容易使用。因此，我们关注如何实现:操作系统实现了哪些机制和策略来实现虚拟化?操作系统是如何做到如此高效的呢?需要什么硬件支持?
>
> 我们将使用“问题的关键”，在阴影框中，例如这个，作为一种方法来指出我们试图在构建操作系统中解决的具体问题。因此，在一个特定主题的注释中，您可能会发现一个或多个强调问题的cruces(是的，这是正确的复数形式)。当然，本章中的细节将介绍解决方案，或至少介绍解决方案的基本参数。
