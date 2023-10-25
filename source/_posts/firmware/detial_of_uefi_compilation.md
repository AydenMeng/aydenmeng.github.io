---
title: UEFI的编译细节
date:  2022-04-19 22:58:16
categories: [嵌入式, UEFI]
tags: [UEFI, BIOS, BootLoader]
---

# UEFI的编译细节

## UEFI编译

uefi的常规编译方式为：build -t CompilerName -A Arch -p PkgName -j logfile


## UEFI的编译细节展开
通常UEFI的编译包括以下三个步骤：

```
. edksetup.sh
make -C BaseTools
build -t CompilerName -A Arch -p PkgName -j logfile
```

## edksetup.sh
上述准备过程中,edksetup.sh的工作是准备工作的核心,具体来看一下:

```
SCRIPTNAME="edksetup.sh"
RECONFIG=FALSE

#使用帮助
function HelpMsg()
{
  echo "Usage: $SCRIPTNAME [Options]"
  echo
  echo "The system environment variable, WORKSPACE, is always set to the current"
  echo "working directory."
  echo
  echo "Options: "
  echo "  --help, -h, -?        Print this help screen and exit."
  echo
  echo "  --reconfig            Overwrite the WORKSPACE/Conf/*.txt files with the"
  echo "                        template files from the BaseTools/Conf directory."
  echo
  echo Please note: This script must be \'sourced\' so the environment can be changed.
  echo ". $SCRIPTNAME"
  echo "source $SCRIPTNAME"
}
# 设定工作目录
function SetWorkspace()
{
  #
  # If WORKSPACE is already set, then we can return right now
  #
  if [ -n "$WORKSPACE" ]
  then
    return 0
  fi

  if [ ! ${BASH_SOURCE[0]} -ef ./edksetup.sh ] && [ -z "$PACKAGES_PATH" ]
  then
    echo Run this script from the base of your tree.  For example:
    echo "  cd /Path/To/Edk/Root"
    echo "  . edksetup.sh"
    return 1
  fi

  #
  # Check for BaseTools/BuildEnv before dirtying the user's environment.
  #
  if [ ! -f BaseTools/BuildEnv ] && [ -z "$EDK_TOOLS_PATH" ]
  then
    echo BaseTools not found in your tree, and EDK_TOOLS_PATH is not set.
    echo Please point EDK_TOOLS_PATH at the directory that contains
    echo the EDK2 BuildEnv script.
    return 1
  fi

  #
  # Set $WORKSPACE
  #
  export WORKSPACE=`pwd`

  return 0
}

# 设定环境变量
function SetupEnv()
{
  # !!环境变量的重要内容在BuildEnv里面!!
  if [ -n "$EDK_TOOLS_PATH" ]
  then
    . $EDK_TOOLS_PATH/BuildEnv
  elif [ -f "$WORKSPACE/BaseTools/BuildEnv" ]
  then
    . $WORKSPACE/BaseTools/BuildEnv
  elif [ -n "$PACKAGES_PATH" ]
  then 
    PATH_LIST=$PACKAGES_PATH
    PATH_LIST=${PATH_LIST//:/ }
    for DIR in $PATH_LIST
    do
      if [ -f "$DIR/BaseTools/BuildEnv" ]
      then
        export EDK_TOOLS_PATH=$DIR/BaseTools
        . $DIR/BaseTools/BuildEnv
        break
      fi
    done
  else
    echo BaseTools not found in your tree, and EDK_TOOLS_PATH is not set.
    echo Please check that WORKSPACE or PACKAGES_PATH is not set incorrectly
    echo in your shell, or point EDK_TOOLS_PATH at the directory that contains
    echo the EDK2 BuildEnv script.
    return 1
  fi
}

# 设定环境变量和工作目录的入口
function SourceEnv()
{
  SetWorkspace &&
  SetupEnv
}

# 文件运行的入口,获取运行参数并按需执行
I=$#
while [ $I -gt 0 ]
do
  case "$1" in
    BaseTools)
      # Ignore argument for backwards compatibility
      shift
    ;;
    --reconfig)
      RECONFIG=TRUE
      shift
    ;;
    -?|-h|--help|*)
      HelpMsg
      break
    ;;
  esac
  I=$(($I - 1))
done

if [ $I -gt 0 ]
then
  return 1
fi

SourceEnv

unset SCRIPTNAME RECONFIG

return $?
```

## 上面核心的内容在BuildEnv里

```
# 同样在设置环境变量
SetWorkspace() {

  #
  # If WORKSPACE is already set, then we can return right now
  #
  if [ -n "$WORKSPACE" ]
  then
    return 0
  fi

  #
  # Set $WORKSPACE
  #
  export WORKSPACE=`pwd`

  return 0

}

# 恢复配置
RestorePreviousConfiguration() {
  #
  # Restore previous configuration
  #
  if [ -z "$CONF_PATH" ]
  then
    export CONF_PATH=$WORKSPACE/Conf
    if [ ! -d $WORKSPACE/Conf ] && [ -n "$PACKAGES_PATH" ]
    then
      PATH_LIST=${PACKAGES_PATH//:/ }
      for DIR in $PATH_LIST
      do
        if [ -d $DIR/Conf ]
        then
          export CONF_PATH=$DIR/Conf
          break
        fi
      done
    fi
  fi
  
  PREVIOUS_CONF_FILE=$CONF_PATH/BuildEnv.sh
  if [ -e $PREVIOUS_CONF_FILE ]
  then
    echo Loading previous configuration from $PREVIOUS_CONF_FILE
    . $PREVIOUS_CONF_FILE
  fi
}

# 生成Shell脚本去设置变量
GenerateShellCodeToSetVariable() {
  VARIABLE=$1
  OUTPUT_FILE=$2
  VAR_VALUE="echo \${${VARIABLE}}"
  VAR_VALUE=`eval $VAR_VALUE`
  echo "if [ -z \"\$${VARIABLE}\" ]"             >> $OUTPUT_FILE
  echo "then"                                    >> $OUTPUT_FILE
  echo "  export ${VARIABLE}=${VAR_VALUE}"       >> $OUTPUT_FILE
  echo "fi"                                      >> $OUTPUT_FILE
}

# 生成shell脚本去更新环境变量
GenerateShellCodeToUpdatePath() {
  OUTPUT_FILE=$1
  echo "if [ -e $EDK_TOOLS_PATH_BIN ]"                        >> $OUTPUT_FILE
  echo "then"                                                 >> $OUTPUT_FILE
  echo "  if [ "\${PATH/$EDK_TOOLS_PATH_BIN/}" == "\$PATH" ]" >> $OUTPUT_FILE
  echo "  then"                                               >> $OUTPUT_FILE
  echo "    export PATH=$EDK_TOOLS_PATH_BIN:\$PATH"           >> $OUTPUT_FILE
  echo "  fi"                                                 >> $OUTPUT_FILE
  echo "fi"                                                   >> $OUTPUT_FILE
}

# 存储当前配置信息
StoreCurrentConfiguration() {
  #
  # Write configuration to a shell script to allow for configuration to be
  # easily reloaded.
  #
  OUTPUT_FILE=$CONF_PATH/BuildEnv.sh
  #echo Storing current configuration into $OUTPUT_FILE
  echo "# Auto-generated by ${BASH_SOURCE[0]}" >| $OUTPUT_FILE
  GenerateShellCodeToSetVariable WORKSPACE $OUTPUT_FILE
  GenerateShellCodeToSetVariable EDK_TOOLS_PATH $OUTPUT_FILE
  GenerateShellCodeToUpdatePath $OUTPUT_FILE
}

# 设定配置信息的目录
SetEdkToolsPath() {

  #
  # If EDK_TOOLS_PATH is already set, then we can return right now
  #
  if [ -n "$EDK_TOOLS_PATH" ]
  then
    return 0
  fi

  #
  # Try $CONF_PATH/EdkTools
  #
  if [ -e $CONF_PATH/EdkTools ]
  then
    export EDK_TOOLS_PATH=$CONF_PATH/EdkTools
    return 0
  fi

  #
  # Try $CONF_PATH/BaseToolsSource
  #
  if [ -e $CONF_PATH/BaseToolsSource ]
  then
    export EDK_TOOLS_PATH=$CONF_PATH/BaseToolsSource
    return 0
  fi

  #
  # Try $WORKSPACE/BaseTools
  #
  if [ -e $WORKSPACE/BaseTools ]
  then
    export EDK_TOOLS_PATH=$WORKSPACE/BaseTools
    return 0
  fi

  #
  # Try $PACKAGES_PATH
  #
  if [ -n "$PACKAGES_PATH"]
  then
    PATH_LIST=${PACKAGES_PATH//:/ }
    for DIR in $PATH_LIST
    do
      if [ -d $DIR/BaseTools ]
      then
        export EDK_TOOLS_PATH=$DIR/BaseTools
        return 0
      fi
    done
  fi

  echo "Unable to determine EDK_TOOLS_PATH"
  echo
  echo "You may need to download the 'BaseTools' from buildtools.tianocore.org."
  echo "After downloading, either create a symbolic link to the source at"
  echo "\$WORKSPACE/Conf/BaseToolsSource, or set the EDK_TOOLS_PATH environment"
  echo "variable."

}

# 由系统类型,获取相关的子文件夹名称
GetBaseToolsBinSubDir() {
  #
  # Figure out a uniq directory name from the uname command
  #
  UNAME_DIRNAME=`uname -sm`
  UNAME_DIRNAME=${UNAME_DIRNAME// /-}
  UNAME_DIRNAME=${UNAME_DIRNAME//\//-}
  echo $UNAME_DIRNAME
}

# 结合上一个函数,得到edk下二进制存放目录
GetEdkToolsPathBinDirectory() {
  #
  # Figure out a uniq directory name from the uname command
  #
  BIN_SUB_DIR=`GetBaseToolsBinSubDir`

  if [ -e $EDK_TOOLS_PATH/BinWrappers/$BIN_SUB_DIR ]
  then
    EDK_TOOLS_PATH_BIN=$EDK_TOOLS_PATH/BinWrappers/$BIN_SUB_DIR
  else
    EDK_TOOLS_PATH_BIN=$EDK_TOOLS_PATH/Bin/$BIN_SUB_DIR
  fi

  echo $EDK_TOOLS_PATH_BIN
}

# 还是环境变量
AddDirToStartOfPath() {
  DIRNAME=$1
  PATH=$DIRNAME:$DIRNAME:$DIRNAME:$PATH
  PATH=${PATH//$DIRNAME:/}
  PATH=$DIRNAME:$PATH
  export PATH
}

AddEdkToolsToPath() {

  #
  # If EDK_TOOLS_PATH is not set, then we cannot update PATH
  #
  if [ -z "$EDK_TOOLS_PATH" ]
  then
    return 1
  fi

  EDK_TOOLS_PATH_BIN=`GetEdkToolsPathBinDirectory`

  AddDirToStartOfPath $EDK_TOOLS_PATH/BinWrappers/PosixLike
  AddDirToStartOfPath $EDK_TOOLS_PATH_BIN

}

# !!拷贝配置文件模板!!
# 把BaseTools/Conf下的模板文件,拷贝到Conf下
# 拷贝的模板文件为:build_rule, tools_def, target
CopySingleTemplateFile() {

  SRC_FILENAME=Conf/$1.template
  DST_FILENAME=$CONF_PATH/$1.txt

  if [ -e $DST_FILENAME ]
  then
    [ $RECONFIG != TRUE ] && return
  fi

  echo "Copying \$EDK_TOOLS_PATH/$SRC_FILENAME"
  echo "     to $DST_FILENAME"
  SRC_FILENAME=$EDK_TOOLS_PATH/$SRC_FILENAME
  cp $SRC_FILENAME $DST_FILENAME

}

CopyTemplateFiles() {

  CopySingleTemplateFile build_rule
  CopySingleTemplateFile tools_def
  CopySingleTemplateFile target

}

# 脚本入口
ScriptMain() {

  SetWorkspace
  if [ -z $WORKSPACE ]
  then
    echo "Failure setting WORKSPACE"
    return 1
  fi

  RestorePreviousConfiguration

  SetEdkToolsPath
  if [ -z $EDK_TOOLS_PATH ]
  then
    return 1
  fi

  AddEdkToolsToPath
  if [ $? -ne 0 ]
  then
    echo "Failure adding EDK Tools into PATH!"
    return 1
  fi

  StoreCurrentConfiguration

  echo WORKSPACE: $WORKSPACE
  echo EDK_TOOLS_PATH: $EDK_TOOLS_PATH
  echo CONF_PATH: $CONF_PATH

  CopyTemplateFiles

}

#
# Run the main function
#
ScriptMain
```

## make -C BaseTools
上面所述编译前的准备中,Basetools会在edksetup.sh没有生效时执行,也稍作分析吧

来看一眼其中的的Makefile

```
!IFNDEF BASE_TOOLS_PATH
!ERROR "BASE_TOOLS_PATH is not set! Please run toolsetup.bat first!"
!ENDIF

SUBDIRS = $(BASE_TOOLS_PATH)\Source\C $(BASE_TOOLS_PATH)\Source\Python

//#编译依赖项是c和python
all: c python

c :
  @$(BASE_TOOLS_PATH)\Source\C\Makefiles\NmakeSubdirs.bat all $(BASE_TOOLS_PATH)\Source\C

python:
  @$(BASE_TOOLS_PATH)\Source\C\Makefiles\NmakeSubdirs.bat all $(BASE_TOOLS_PATH)\Source\Python

subdirs: $(SUBDIRS)
  @$(BASE_TOOLS_PATH)\Source\C\Makefiles\NmakeSubdirs.bat all $**

.PHONY: clean
clean:
  @$(BASE_TOOLS_PATH)\Source\C\Makefiles\NmakeSubdirs.bat clean $(SUBDIRS)

.PHONY: cleanall
cleanall:
  @$(BASE_TOOLS_PATH)\Source\C\Makefiles\NmakeSubdirs.bat cleanall $(SUBDIRS)
```

**需要编译相应的C和Python库,但是使用的是bat脚本,真正make输出的log确是正常的shell输出,这点还不知道怎么处理的,先分析到这,之后继续吧TODO**

## Build

build才是真正编译的开始!

```
build -a ARM64 -p /home/mxdon/clone/UEFI/uefi-arm/ArmCodePkg/SampleCode/Desktop/Script/Arm.dsc -t GCC83 -b DEBUG -j log.txt
```

显然,执行者是build,所以看看build的实质

先找到build在哪

```
[mxdon@5 uefi-arm]$ cat `which build`
#!/usr/bin/env bash
#python `dirname $0`/RunToolFromSource.py `basename $0` $*

# If a python2 command is available, use it in preference to python
if command -v python2 >/dev/null 2>&1; then
    python_exe=python2
fi

full_cmd=${BASH_SOURCE:-$0} # see http://mywiki.wooledge.org/BashFAQ/028 for a discussion of why $0 is not a good choice here
dir=$(dirname "$full_cmd")
cmd=${full_cmd##*/}

export PYTHONPATH="$dir/../../Source/Python"
exec "${python_exe:-python}" "$dir/../../Source/Python/$cmd/$cmd.py" "$@"
```

可以看到，先是设置了环境，然后执行`$cmd.py $@`来执行build

所以再找到$cmd.py,同时可以发现，$cmd在Source/Python下面，所以执行什么命令，就是在运行该命令名称下的以该命令命名的py文件。

所以执行build的时候是执行的build.py，AutoGen执行AutoGen.py以此类推，由于python文件较长，此后选择性展开。


如果查看打印log的话，也可以发现入口是build.py

ok,继续看，在编译的log中,首先打印的是:

```
Build environment: Linux-4.18.0-305.10.2.el8_4.x86_64-x86_64-with-centos-8.4.2105
Build start time: 15:00:53, Jan.04 2022
```

对应于build.py中:
```
EdkLogger.quiet("Build environment: %s" % platform.platform())
EdkLogger.quiet(time.strftime("Build start time: %H:%M:%S, %b.%d %Y\n", time.localtime()));
```

相关变量在之前获取.

类似的分析,log中设定环境变量:

```
WORKSPACE        = /home/mxdon/clone/UEFI/uefi-arm
ECP_SOURCE       = /home/mxdon/clone/UEFI/uefi-arm/EdkCompatibilityPkg
EDK_SOURCE       = /home/mxdon/clone/UEFI/uefi-arm/EdkCompatibilityPkg
EFI_SOURCE       = /home/mxdon/clone/UEFI/uefi-arm/EdkCompatibilityPkg
EDK_TOOLS_PATH   = /home/mxdon/clone/UEFI/uefi-arm/BaseTools/
CONF_PATH        = /home/mxdon/clone/UEFI/uefi-arm/Conf
Architecture(s)  = ARM64
Build target     = DEBUG
Toolchain        = GCC83
Active Platform          = /home/mxdon/clone/UEFI/uefi-arm/ArmCodePkg/SampleCode/Desktop/Script/Arm.dsc
Flash Image Definition   = /home/mxdon/clone/UEFI/uefi-arm/ArmCodePkg/SampleCode/Desktop/Script/Arm.fdf
```

对应build.py中的则是:

```
CheckEnvVariable()  ->
    MyBuild = Build(Target, Workspace, Option)  ->
            __init__()  ->
                EdkLogger.quiet(...)

```

类似的分析不再赘述,简要说明如下:

```
main->MyBuild->Build->__init__->...                                        #设定及检验用于build的环境,包括加载target.txt中的编译器,dsc文件中的描述等,用于生成最终的编译规则.
                    ->_BuildPlatform->WorkspaceAutoGen->PlatformAutoGen #通过解析FDF文件和INF文件,生成相应的C代码(宏变量)和Makefile(编译规则)
                                    ->_BuildPa->_GenFfsCmd                #编译模块
                                    ->_CollectModuleMapBuffer            #根据PCD修改EFI的内存分布,并获取modules的内存分布,用于重定位modules,链接生成最终的FD文件
                                    ->_Build                            #编译模块
                                    ->_CollectFvMapBuffer                #获取重定位FV的信息

```

大概流程如上,其中重定位相关的内容调用_RebaseModule->LaunchCommand[GenFw...],其中LaunchCommand也是在Build中执行make的途径.

从前面知道,执行的命令与其文件名相同,GenFw所用到的文件不是Python,而是C/GenFw/GenFw.c,其中具体细节暂不展开.

## 重定位

### TODO


## 总结

UEFI是像一个魔改的Kernel,图形化,文字功能,网络功能都具备,在一定条件下可以变成内核,具有学习的价值和意义.

尤其,UEFI比内核简单许多,作为一个嵌入式C的大型项目来说是非常不错的,基于此,再看上述分析过程,整个UEFI的核心也无非就是C,Python,Shell(Makefile)这三种语言.也竟然有这三种语言.

我的意思是,项目开发中,只会一种语言可能越来越不够了,技多不压身,多学吧~

## 最后，点个关注不迷路

> 公众号：[孟游先生的旅游笔记](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8a089ae12bfb4ca9a9e5d9ac82f58d43~tplv-k3u1fbpfcp-zoom-1.image)
