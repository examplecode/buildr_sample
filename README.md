
# 使用Apache Buildr 构建你的 java 程序 #

Gradle 和 Buildr  都是java 构建系统工具类似于Ant ,Maven . 而且作为后起之秀更加优秀简洁，这两种构建工具都是基于脚本语言，Gradle 使用Groovy 而Build则使用ruby. 目前Buildr是Apache基金会孵化的第一个ruby项目。作为ruby fans 这里介绍一下 Buildr基本使用方法。


## 安装 Buildr ##

官方已经提供了非常详细的[安装Buildr](http://buildr.apache.org/installing.html) 文档，这里就不再叙述。在MacOsX下直接[下载](http://buildr.apache.org/scripts/install-osx.sh)运行使用官方提供的安装脚本即可。


##  创建buildfile文件,编译打包 ##

进入的项目的根目录，创建一个名字叫做"buildfile" 的文件. 文件内容如下：

	define 'buildr_sample'
	
执行 buildr compile 方法buildr将自动分析代码的依赖关系进行编译
	
	cd buildr-sample	
	buildr compile

输出如下:
```
Compiling buildr-sample
Completed in 0.017s

``` 

我们看到除了终端有输出信息外没有任何变化 “buildr-sample/src/com/examplecode/buildr_sample/HelloBuildr.java ”  并没有被编译. 原来按照buildr的规范只会搜索" src/main/java/ " 目录下面的源码 。 我们可以通过增加下面的声明告诉buildr到src目录下搜索java源码

```ruby 
project_layout = Layout.new
project_layout[:source,:main,:java] = 'src'

define 'buildr-sample', :layout => project_layout do
          project.version = '0.1.0'
          package :jar
end

```



执行下面的命令可以生成 .jar 文件

```
 buildr package

```


编译和打包会在当前项目的根目录生成 target目录存放编译打包的结果,执行 buildr clean 命令会删除target用于清除编译结果

```

buildr clean

```


## 遇到的问题 ##

由于buildr在编译的时候会调用ant 所以在第一次编译的时候会安装依赖的ant包(buildr 使用Rake实现Task依赖管理,但是ruby Rake不知道如何构建java. 但我们也没有必要重新实现所有的Task，只要调用ant现成的接口即可"）。在我第一次编译java文件的时候出现下面的错误信息.

```
RuntimeError : Unable to download org.apache.ant:ant:jar:1.8.3. No remote repositories defined. 

```

这时候我们需要手工指定在构建文件中手工指定依赖仓库的地址。


```ruby 
repositories.remote << 'http://repo1.maven.org/maven2'
project_layout = Layout.new
project_layout[:source,:main,:java] = 'src'

define 'buildr-sample', :layout => project_layout do
          project.version = '0.1.0'
          package :jar
end

```







## 参考资料 ##

http://buildr.apache.org/quick_start.html
http://stackoverflow.com/questions/13781123/buildr-failing-with-unable-to-download-ant/13791000#13791000
