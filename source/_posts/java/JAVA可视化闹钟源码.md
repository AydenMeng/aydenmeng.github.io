---
title: JAVA可视化闹钟源码
date: 2019-07-14 13:23:04
categories: [软件编程, Java]
tags: [Java, Swing, 图形化]
covers: 
---

# 概述

一些同学的Java课设有这样一个问题，比较感兴趣就做了一下

<!--more-->

## 功能介绍：

1、可增加闹钟

2、可删除闹钟

3、时间到了响铃

4、关闭闹钟不会丢失闹钟（因为闹钟存储在txt文件中，不会因程序关闭就终止）

## 缺点

1、没有使用多线程，闹钟响起时只能等待1分钟或者关闭程序

2、界面设计不够美观，后期有时间会进行修改，重新设计

3、没有闹钟修改的功能，虽然可以通过增删来达到修改的目的，但功能仍然属于空缺范围

```
package Clock;

import sun.audio.AudioPlayer;
import sun.audio.AudioStream;

import javax.swing.*;               //awt和swing是做界面用的类
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.*;                   //io流用于读写文件，包括增删闹钟、打开铃声等等
import java.util.Calendar;          //用于获取当前时间的类
import java.util.GregorianCalendar;//标准阳历
import java.util.StringTokenizer;  //读取文件转换成计算机语言用的类
/*
1 计时器
要求1：一个带有可视化界面的钟表。
要求2：可以添加若干个闹钟。
要求3：具备持久化功能，关闭程序不能丢失闹钟。
要求4：闹钟是可编辑，可删除的。

实现：先创建一个面板显示闹钟，面板内创建按钮增加闹钟，按钮查看闹钟，按钮删除闹钟
     线程间隔1s读取时间和闹钟比较

 */
public class ClockTry extends JFrame implements Runnable {
    /* 成员变量 */
    private JPanel xx;      //总的面板
    private JComboBox ho;   //hour选择时间的下拉框
    private JComboBox mi;  //min选择分钟的下拉框
    private JButton tjnz;   //添加闹钟的按钮
    private JButton schour;    //删除闹钟的按钮
    private String filename = "D://homework//java//Gui//src//Clock//0.wav";     //所有的路径改这两个地方就可以了
    private String pathname = "D://homework//java//Gui//src//Clock//nz.txt"; // 绝对路径或相对路径都可以，写入文件时演示相对路径,读取以上路径的input.txt文件

    private int HOUR;       //定义HOUR用于接收按钮按下从下拉框中获取的数据
    private int MIN;        //同上

    int x = 100, y = 100, r = 100; // （x,y）为(0,0)点，表示原点
    int h, m, s; // 时,分,秒
    double rad = Math.PI / 180; //  1°

    private String[][] str= new String[100][2];     //定义二维数组，用于存储以及对小时和分针的操作，暂定为100个闹钟于是定义为【100】【2】
    /**
    *读取文件，每次的增删都需要对数据进行读取，将数据写在面板上也需要读取数据
     */
    public void readFile() {
        try (FileReader reader = new FileReader(pathname);      //创建一个FilReader对象，将文件读出来，相当于请教一个当地人，当地人了解本地文化，但是语言不通听不懂
             BufferedReader br = new BufferedReader(reader) // 建立一个对象，它把文件内容转成计算机能读懂的语言，相当于请一个翻译，把当地人读取的东西转换成计算机能懂的东西
        ) {
            String line;

            int i =0;
            while ((line = br.readLine()) != null) {        //翻译理解的东西存到line里面
                int j =0;
                StringTokenizer st = new StringTokenizer(line, ":");        //重点：由于存储数据时都是时间，道理来说都是数字，无法区分小时部分和分钟部分
                while (st.hasMoreTokens()){               //每读取一次读到的内容     //所以这里用分割符“：”来分割，相应的，后面的写入文件也应该已“：”分割进行写入
                    str[i][j]=st.nextToken();               //把读到的内容存储在数组里面便于后面的操做——增删
                    j++;                                    //包括上面的j=0，是将for循环拆分放进while循环中，要不然循环写起来也很麻烦
                }
                //System.out.print(str[i][0]+":"+str[i][1]);       写的时候用来在控制台打印查看效果
                //System.out.println();
                i++;
                j = 0;
            }
        } catch (IOException e) {
            e.printStackTrace();                    //try……catch抛出异常
        }
    }


    /**
     * 写入TXT文件
     */
    public void writeFile() {
        HOUR = Integer.valueOf(ho.getSelectedIndex());                          //获取下拉框中的值，存储到HOUR中
        MIN = Integer.valueOf(mi.getSelectedIndex());
        String x = HOUR + ":" + MIN;
        try (FileWriter writer = new FileWriter(pathname,true);         //同上面的读取，本地人写入，注意：后面的append：true是表示不是重新写，而是在后面追加
             BufferedWriter out = new BufferedWriter(writer)                    //翻译一下再写入
        ) {

            out.write(HOUR + ":" + MIN + "\r\n");                           //这里写入的时候把:写进去了！
            out.flush();                                                        // 把缓存区内容压入文件，计算机的存储过程，存在缓存区再写入文件
            JOptionPane.showMessageDialog(null,"闹钟添加成功！","添加闹钟提醒",JOptionPane.INFORMATION_MESSAGE); //提示框：添加闹钟成功
        } catch (IOException e) {
            e.printStackTrace();

        }

    }


    /**
     * 删除闹钟，实际上是先将要删除的数据找到移除数组，再将数组重新写入，所以要先读取文件，再重新写入
     */
    public void shanchuFile() {
        HOUR = Integer.valueOf(ho.getSelectedIndex());
        MIN = Integer.valueOf(mi.getSelectedIndex());
        try (FileWriter writer = new FileWriter(pathname);              //没有append：true，表示重新写！
             BufferedWriter out = new BufferedWriter(writer)
        ) {
            readFile();
            for (int i = 0; i < 100; i++) {
                if (Integer.valueOf(str[i][0])==HOUR && Integer.valueOf(str[i][1])==MIN){
                    continue;
                }
                else{
                    out.write(str[i][0]+":"+str[i][1]+"\r\n"); // \r\n即为换行
                }
            }

            //out.write("1"+"1"+"\r\n"); // \r\n即为换行
            out.flush(); // 把缓存区内容压入文件
        } catch (IOException e) {
            e.printStackTrace();
        }catch (NumberFormatException e){
            System.out.println("this isn't exist!");
            JOptionPane.showMessageDialog(null,"该闹钟已删除！","删除闹钟提醒",JOptionPane.INFORMATION_MESSAGE); //弹窗提示
        }
    }

    /* 初始化函数 */
    public void init() {

        Calendar now = new GregorianCalendar();     //获取当前时间
        /*
         * GregorianCalendar（标准阳历）
         * 是Calendar（日历）【国际环境下都能运行的程序】
         * 的子类
         */
        s = now.get(Calendar.SECOND) * 6; // 秒针转换成角度：1秒，秒针动一次，转动6°
        m = now.get(Calendar.MINUTE) * 6; // 分针转换为角度：1分，分针动一次，转动6°
        h = now.get(Calendar.HOUR) * 30 + now.get(Calendar.MINUTE) / 12 * 6; // 先把分化为小时，再乘以6°，因为分针转12°，时针才会转1°，一小时中间有5格，数学问题
        /*
         * Calendar.HOUR 显示范围：1-12（无论AM还是PM） Calendar.HOUR_OF_DAY 显示范围：1-24（包括PM
         */

        Thread t = new Thread(this);        //添加线程，线程目标是整个程序，this
        t.start();                                  //线程就绪
    }

    public void paint(Graphics g) {                 //awt中的方法，因为要时时显示闹钟，所以不得不使用绘画的方式，不断重绘
        super.paint(g);
        /*
         * paint(g)函数会重绘图像，要加上super.paint(g)，表示在原来图像的基础上，再画图。
         * 如果不加super.paint(g)，重绘时，会将原有的绘制清空，再根据paing(g)函数绘制。
         */

        g.setColor(Color.BLACK);                    //设置画笔颜色——黑色
        g.drawOval(x, y, r * 2, r * 2);// 画表
        /* drawOval(x,y,width,height)以矩形恰好框住椭圆，矩形左上角的顶点坐标为(x,y) */

        // 秒针
        int x1 = (int) (90 * Math.sin(rad * s));
        int y1 = (int) (90 * Math.cos(rad * s));
        g.drawLine(r+x, r+y, r+x + x1, r +y- y1);
        /* drawLine(a,b,c,d) (a,b)为起始坐标 (c,d)为终点坐标 */

        // 分针
        x1 = (int) (80 * Math.sin(rad * m));
        y1 = (int) (80 * Math.cos(rad * m));
        g.drawLine(r+x, r+y, r +x+ x1, r+y - y1);

        // 时针
        x1 = (int) (60 * Math.sin(rad * h));
        y1 = (int) (60 * Math.cos(rad * h));
        g.drawLine(r+x, r+y, r+x + x1, r +y- y1);

        // 画数字
        int d = 30;
        for (int i = 1; i <= 12; i++) {
            x1 = (int) ((r - 10) * Math.sin(rad * d));
            y1 = (int) ((r - 10) * Math.cos(rad * d));
            g.drawString(String.valueOf(i), r+x + x1, r+y - y1);    //字符型的数据才能画
            d += 30;
        }

        // 画刻度
        d = 0;
        for (int i = 1; i <= 60; i++) {
            x1 = (int) ((r - 2) * Math.sin(rad * d));
            y1 = (int) ((r - 2) * Math.cos(rad * d));
            g.drawString(".", r+x + x1, r +y- y1);      //画的是点，表示刻度
            d += 6;
        }
        // 显示时间
        Calendar now1 = new GregorianCalendar();
        int a, b, c;
        a = now1.get(Calendar.HOUR_OF_DAY);     //获取当前的小时
        b = now1.get(Calendar.MINUTE);          //获取当前的分钟
        c = now1.get(Calendar.SECOND);           //获取当前的秒钟
        g.drawString(a + ":" + b + ":" + c, 175, 330);      //将时间也画到面板上
        g.drawString("全部闹钟：",100,350);                  //全部闹钟

        try (FileReader reader = new FileReader(pathname);
             BufferedReader br = new BufferedReader(reader) // 建立一个对象，它把文件内容转成计算机能读懂的语言
        ) {
            String line;

            int i =0;
            while ((line = br.readLine()) != null) {
                int j =0;
                StringTokenizer st = new StringTokenizer(line, ":");
                while (st.hasMoreTokens()){
                    str[i][j]=st.nextToken();
                    j++;
                }
                g.drawString(str[i][0]+":"+str[i][1]+"\n",180+(i/10)*70,350+15*(i-(i/10)*10));  //貌似重新写了一下readfile的方法，其实是有区别的，这里是读取以后画出来
                //qbnz.setText(str[i][0]+":"+str[i][1]+"\n");
                //System.out.print(str[i][0]+":"+str[i][1]);
                //System.out.println();
                i++;
                j = 0;
            }
        } catch (IOException z) {
            z.printStackTrace();
        }
    }


    // 实现Runnable，实现implement Runnable就务必实现run方法，使线程运行
    public void run() {
        while (true) {
            try {
                Thread.sleep(1000);// 间隔一秒
            } catch (Exception ex) {
            }
            s += 6;				// 秒针每次走6°
            if (s >= 360) {
                s = 0;            // 秒针归零
                m += 6;
            if (m == 72 || m == 144 || m == 288) {
                h += 6;                // 分针走72°，时针走6° 分针的12倍，时针走一次
                }

            if (m >= 360) {
                m = 0;                // 分针归零
                h += 6;
            	}
            if (h >= 360) {
                h = 0;                // 时针归零
                }
            }


            this.repaint();     // 重新绘制
            //this.readFile();
            this.alert();       //将闹钟加入到线程当中
        }}

    public void alert(){
        Calendar now1 = new GregorianCalendar();
        int a, b;
        a = now1.get(Calendar.HOUR_OF_DAY);
        b = now1.get(Calendar.MINUTE);      //这里没有获取秒针是因为闹钟不看秒针。。。。。
        try (FileReader reader = new FileReader(pathname);
             BufferedReader br = new BufferedReader(reader) // 建立一个对象，它把文件内容转成计算机能读懂的语言
        ) {
            String line;
            String[][] str= new String[100][2];
            int i =0;
            while ((line = br.readLine()) != null) {
                int j =0;
                StringTokenizer st = new StringTokenizer(line, ":");
                while (st.hasMoreTokens()){
                    str[i][j]=st.nextToken();
                    j++;
                }
                if (a==Integer.valueOf(str[i][0]) && b==Integer.valueOf(str[i][1])){        //读取后与获得的时间比较，如果闹钟存在，就响
                    try{
                        InputStream in = new FileInputStream("D://homework//java//Gui//src//Clock//0.wav");//FIlename 是你加载的声音文件如(“game.wav”)
                        AudioStream as = new AudioStream(in);           //和读取文件类似的原理，经翻译之后才播放出来
                        AudioPlayer.player.start(as);       //用静态成员player.start播放音乐
                        } catch(FileNotFoundException e){
                        System.out.print("FileNotFoundException ");
                    } catch(IOException e){
                        System.out.print("有错误!");
                    }
                }
                i++;
                j = 0;
            }
        } catch (IOException z) {
            z.printStackTrace();
        }
    }

    //初始化界面
    public  void  launchFrame(){
        xx = new JPanel();      //插入一个面板
        String[] hours = new String[24];        //长度为24的数组用于存储小时
        for (int i = 0; i < hours.length; i++) {
            hours[i]=i+"";              //循环对hour进行赋值
        }
        ho = new JComboBox(hours);      //将hour加入到下拉框中
        ho.setSize(50,40);  //设置大小好像没用
        String[] mins = new String[60];     //同理，这是分钟的地方
        for (int i = 0; i < mins.length; i++) {
            mins[i]=i+"";                   //分钟赋值
        }
        mi = new JComboBox(mins);           //分钟下拉框
        mi.setSize(50,40);
        tjnz = new JButton();               //添加闹钟的按钮，拼音首字母
        tjnz.setText("添加到闹钟");             //按钮上显示的文字
        tjnz.setSize(100,40);
        schour = new JButton();                 //删除闹钟的按钮
        schour.setText("从闹钟中删除");           //按钮上显示的文字
        schour.setSize(100,40);

        /**
         * 将按钮下拉框啥的加入到面板中
         */
        xx.add(ho);
        xx.add(mi);
        xx.add(tjnz);
        xx.add(schour);
        this.add(xx);       //将面板加入到this对象中，要不然面板就不显示
        tjnz.addActionListener(new ActionListener() {       //添加按钮的功能
                @Override                                   //重写的标识，务必要会
                public void actionPerformed(ActionEvent e) {
                    // TODO Auto-generated method stub
                    HOUR = Integer.valueOf(ho.getSelectedIndex());
                    MIN = Integer.valueOf(mi.getSelectedIndex());      //获取到时分后
                    writeFile();                                       //写入txt文件保存为闹钟
                    readFile();                                        //再读取，这样才能时时更新面板上的全部闹钟
        }});

        schour.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    // TODO Auto-generated method stub
                    HOUR = Integer.valueOf(ho.getSelectedIndex());
                    MIN = Integer.valueOf(mi.getSelectedIndex());
                    shanchuFile();                                      //这里是删除闹钟的按钮功能
                    readFile();
                }});

        this.setTitle("小闹钟");                                     //设置窗口标题
        this.setVisible(true);                                      //设置窗口不隐身
        this.setSize(700,500);                        //设置窗口大小
        this.setLocation(500, 250);                           //设置窗口位置，相对于桌面左上角
        this.init();                                                //调用初始化函数进行初始化
        this.alert();
        //this.run();       //重复调用run（）方法结果是秒针一次走12°
        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });     //设置窗口叉号的功能，点击就关闭程序
    }



    public static void main(String[] args) {
        ClockTry c = new ClockTry();        //main方法，必有的成分，创建主类对象，
        c.launchFrame();                    //调用初始化面板的方法，简化了本该在main方法中写的代码

}}
```

## 运行效果

![1](./imgs/JAVA可视化闹钟源码/1.png)

![2](./imgs/JAVA可视化闹钟源码/2.png)

![3](./imgs/JAVA可视化闹钟源码/3.png)

此版本为第一次尝试，后续有时间会继续更新版本
