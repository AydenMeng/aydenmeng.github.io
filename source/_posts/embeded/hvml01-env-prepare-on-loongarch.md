---
title: hvml01-在龙芯平台搭建hvml运行环境
date: 2022-09-25 21:08:55
categories: [编程语言, Hvml]
tags: [教程, Loongarch, Hvml, 图形化]
---
# hvml01-在龙芯平台搭建hvml运行环境

## 1. 准备环境

根据Hvml社区介绍:

PurC 的目标是用 C 语言实现HVML 规范 V1.0定义的所有特性和HVML 预定义变量 V1.0 定义的所有预定义动态对象。

To build PurC, make sure that the following tools or libraries are available on your Linux or macOS system:

1. cmake
2. A C11 and CXX17 compliant complier: GCC 8+ or Clang 6+
3. glib 2.44.0 or later
4. Python 3
5. BISON 3.0 or later
6. FLEX 2.6.4 or later

我使用的是龙芯发布的Loongnix系统:

```shell
mxdon@mxdon-la:~/hvml$ cat /etc/os-release
PRETTY_NAME="Loongnix GNU/Linux 20 (DaoXiangHu)"
NAME="Loongnix GNU/Linux"
VERSION_ID="20"
VERSION="20 (DaoXiangHu)"
VERSION_CODENAME=DaoXiangHu
ID=Loongnix
HOME_URL="https://www.loongnix.cn/"
SUPPORT_URL="https://www.loongnix.cn/"
BUG_REPORT_URL="http://www.loongnix.cn/"
```

其中系统自带的gcc, glibc, python3是满足需求的, 需要手动安装的bison, flex默认版本也都是满足需求的, 安装命令如下:

```shell
sudo apt install bison flex -y
```

其中只有cmake的环境有一点问题, 但也很好解决.

系统默认不带有cmake, `sudo apt install cmake`所安装的cmake版本是3.13.4, 编译PurC时提示需要3.15以上的cmake:

```shell
mxdon@mxdon-la:~/hvml/PurC$ cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPORT=Linux -B build && cmake --build build && sudo cmake --install build
CMake Error at CMakeLists.txt:11 (cmake_minimum_required):
  CMake 3.15 or higher is required.  You are running version 3.13.4


-- Configuring incomplete, errors occurred!
See also "/home/mxdon/hvml/PurC/build/CMakeFiles/CMakeOutput.log".
See also "/home/mxdon/hvml/PurC/build/CMakeFiles/CMakeError.log".
```

所以手动编译一个cmake3.15.3, 其他版本应该是类似的:

```shell
mxdon@mxdon-la:~/hvml/cmake-3.15.3$ ./bootstrap --prefix=/home/mxdon/hvml/cmake-3.15.3/build/
---------------------------------------------
CMake 3.15.3, Copyright 2000-2019 Kitware, Inc. and Contributors
Found GNU toolchain
C compiler on this system is: gcc
C++ compiler on this system is: g++
Makefile processor on this system is: make
g++ has setenv
g++ has unsetenv
g++ does not have environ in stdlib.h
g++ has stl wstring
g++ has <ext/stdio_filebuf.h>
---------------------------------------------
g++              -I/home/mxdon/hvml/cmake-3.15.3/Bootstrap.cmk   -I/home/mxdon/hvml/cmake-3.15.3/Source   -I/home/mxdon/hvml/cmake-3.15.3/Source/LexerParser   -I/home/mxdon/hvml/cmake-3.15.3/Utilities  -c /home/mxdon/hvml/cmake-3.15.3/Source/cmAddCustomCommandCommand.cxx -o cmAddCustomCommandCommand.o
In file included from /home/mxdon/hvml/cmake-3.15.3/Utilities/cm_kwiml.h:12,
                 from /home/mxdon/hvml/cmake-3.15.3/Source/cmAlgorithms.h:10,
                 from /home/mxdon/hvml/cmake-3.15.3/Source/cmGlobalGenerator.h:16,
                 from /home/mxdon/hvml/cmake-3.15.3/Source/cmAddCustomCommandCommand.cxx:11:
/home/mxdon/hvml/cmake-3.15.3/Utilities/KWIML/include/kwiml/abi.h:476:3: error: #error "Byte order of target CPU unknown."
 # error "Byte order of target CPU unknown."
   ^~~~~
make: *** [Makefile:4：cmAddCustomCommandCommand.o] 错误 1
---------------------------------------------
Error when bootstrapping CMake:
Problem while running make
---------------------------------------------
Log of errors: /home/mxdon/hvml/cmake-3.15.3/Bootstrap.cmk/cmake_bootstrap.log
---------------------------------------------
```

这个问题很好解决, 只是在`Utilities/KWIML/include/kwiml/abi.h`缺少一个大小端的定义, 所以就直接加个小端定义好了.

```patch
 /* Unknown CPU */
 #elif !defined(KWIML_ABI_NO_ERROR_ENDIAN)
-# error "Byte order of target CPU unknown."
+//# error "Byte order of target CPU unknown."
+# define KWIML_ABI_ENDIAN_ID KWIML_ABI_ENDIAN_ID_LITTLE
 #endif
```

将cmake-3.15.3添加至环境变量中, 然后就可以编译PurC了:
```shell
root@mxdon-la:/home/mxdon/hvml/PurC# export PATH=/home/mxdon/hvml/cmake-3.15.3/build/bin/:$PATH                       
root@mxdon-la:/home/mxdon/hvml/PurC# cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPORT=Linux -B build && cmake --build build && sudo /home/mxdon/hvml/cmake-3.15.3/build/bin/cmake --install build
-- The CMake build type is: RelWithDebInfo
-- Enabling ccache: Couldn't find ccache program. Not enabling it.
-- Performing Test C_COMPILER_SUPPORTS_-fmax-errors=10
-- Performing Test C_COMPILER_SUPPORTS_-fmax-errors=10 - Success
-- Performing Test CXX_COMPILER_SUPPORTS_-fmax-errors=10
-- Performing Test CXX_COMPILER_SUPPORTS_-fmax-errors=10 - Success
......
-- Installing: /usr/local/include/purc/purc.h
-- Installing: /usr/local/lib/purc-0.8/libpurc-dvobj-FS.so
-- Set runtime path of "/usr/local/lib/purc-0.8/libpurc-dvobj-FS.so" to ""
-- Installing: /usr/local/lib/purc-0.8/libpurc-dvobj-MATH.so
-- Set runtime path of "/usr/local/lib/purc-0.8/libpurc-dvobj-MATH.so" to ""
-- Installing: /usr/local/bin/purc
-- Set runtime path of "/usr/local/bin/purc" to ""
```

之后需要将PurC用到的链接库增加至系统链接路径, 修改`/etc/ld.so.conf`:
```shell
mxdon@mxdon-la:~/hvml$ cat /etc/ld.so.conf
include /etc/ld.so.conf.d/*.conf
/usr/local/lib/

mxdon@mxdon-la:~/hvml$ sudo ldconfig
```

然后执行demo程序:
```shell
mxdon@mxdon-la:~/hvml/PurC$ cat demo.hvml
<!DOCTYPE hvml>
<hvml target="void">

    $STREAM.stdout.writelines('Hello, world!')

</hvml>
mxdon@mxdon-la:~/hvml/PurC$ purc demo.hvml
Hello, world!
```
