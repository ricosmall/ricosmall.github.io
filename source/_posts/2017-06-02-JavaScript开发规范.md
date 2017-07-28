---
title: JavaScript开发规范
date: 2017-06-02 22:41:28
tags:
- JavaScript
- 开发规范
categories:
- 规范
---

## 1. 命名规范

### 驼峰式命名法：

驼峰式命名法由大（小）写字母开始，后续每个单词首字母都大写。
按照第一个字母是否大写，分为：

- Pascal Case 大驼峰式命名法：首字母大写。如：StudentInfo
- Camel Case 小驼峰式命名法：首字母小写。如：studentInfo

<!-- more -->

### 1.1 变量

命名方法： 小驼峰式命名法
命名规范： 前缀应当是名词。（函数的名字前缀为动词，以此区分变量和函数）
命名建议：尽量在变量名字中体现所属类型，如：length、count等表示数字类型；而包含name、title表示为字符串类型。

示例：

```javascript
// good
var maxCount = 10;
var tableTitle = 'LoginTable';

// bad
var setCount = 10;
var getTitle = 'LoginTable';
```

### 1.2 函数

命名方法：小驼峰式命名法
命名规范：前缀应当为动词
命名建议：可以使用常见动词约定

| 动词 | 含义 | 返回值 |
| :------------- | :------------- | :------------- |
| can      | 判断是否可执行某个动作（权限）     | Boolean    |
| has      | 判断是否含有某个值     | Boolean    |
| is      | 判断是否为某个值     | Boolean    |
| get      | 获取某个值     | NOT Boolean    |
| set      | 设置某个值     | 无返回值、Boolean或者返回链式对象    |
| load      | 加载某些数据     | 无返回值或加载状态    |

示例：

```javascript
// 判断是否可读
function canRead() {
    return true;
}

// 获取名字
function getName() {
    return this.name;
}
```

### 1.3 常量

命名方法：名称全部大写
命名规范：使用大写字母和下划线组合命名，下划线用以分割单词
命名建议：参照1.1

示例：

```javascript
var MAX_COUNT = 10;
var URL = 'http://www.lrts.me';
```

### 1.4 构造函数

命名方法：大驼峰式命名法
命名规范：前缀为名称
命名建议：无

示例：

```javascript
function Student(name) {
    this.name = name;
}

var student1 = new Student('Tom');
```

### 1.5 类的成员

命名建议：

- 公共属性和方法：跟变量和函数的命名一样
- 私有属性和方法：前缀为_（下划线），后面跟公共属性和方法一样的命名方式

示例：

```javascript
function Student(name) {

    // 私有属性
    var _name = name;

    // 公共方法
    this.getName = function () {
        return _name;
    }

    this.setName = function (value) {
        _name = value;
    }
}

var student1 = new Student('Tom');
student1.setName('John');
console.log(student1.getName()); // => John
```

## 2. 注释规范

JavaScript支持两种不同类型的注释：单行注释和多行注释。

### 2.1 单行注释

说明：单行注释以两个斜杠开始，以行尾结束
语法：`//` 这是单行注释
使用方式：

- 单独一行：`// comments` 双斜杠与文字之间保留一个空格
- 在代码后面添加注释：`var MAX_COUNT = 10; // comments` 双斜杠与代码结尾之间保留一个空格，与注释文字之间保留一个空格。
- 注释代码：`// var MAX_COUNT = 10;` 双斜杠与代码之间保留一个空格。

示例：

```javascript
// 单独一行
setCount();

var MAX_COUNT = 10; // 在代码后面添加注释

// 注释代码
// setName();
```

### 2.2 多行注释

说明：以`/*`开头，以`*/`结尾
语法：`/* comments */`
使用方法：

- 若`/*`和`*/`在同一行，推荐采用单行注释
- 若至少三行注释，第一行为`/*`，最后一行为`*/`，其他行以`*`开始，与注释文字之间保留一个空格，并且所有的`*`保持竖向对齐

示例：

```javascript
/*
 * comments line one
 * comments line two
 */
setName();
```

### 2.3 函数（方法）注释

说明：函数（方法）注释也是多行注释的一种，但是包含了特殊的注释要求。
语法：
```javascript
/**
 * 函数说明
 * @关键字
 */
```

常用注释关键字：（只列出一部分）

| 注释名 | 语法 | 含义 | 示例 |
| :------------- | :------------- | :------------- | :------------- |
| @param | @param 参数名 {参数类型} 描述信息 | 描述参数的信息 | @param name {String} 名称 |
| @return | @return {返回类型} 描述信息 | 描述返回值的信息 | @return {String} 名称 |
| @author | @author 作者名字 附属信息 | 描述此函数或者模块的作者信息 | @author Tom 2016-10-10 |
| @version | @version xx.xx.xx | 描述此函数或者模块的版本号 | @version 1.0.1 |
| @example | @example 示例代码 | 示例函数使用方法 | @example setName('John') |

示例：

```javascript
/**
 * 合并Grid的行
 * @param grid {Ext.Grid.Panel} 需要合并的Grid
 * @param cols {Array} 需要合并的Index（序号）数组；从0开始计数，序号也包含
 * @param isAllSome {Boolean} 是否2个tr的cols必须完全一样才能进行合并。true: 完全一样；false(默认): 不完全一样
 * @return void
 * @author polk6 2015/07/21
 * @example
 * ______________                                  ______________
 * | 年龄 | 姓名 |                                   | 年龄 | 姓名 |
 * --------------       mergeCells(grid, [0])      --------------
 * | 18  | 张三 |               =>                  |     | 张三 |
 * --------------                                  |  18 |-------
 * | 18  | 王五 |                                   |     | 王五 |
 * --------------                                  --------------
 */
function mergeCells(grid, cols, isAllSome) {
    // do something
}
```

## 3. 框架开发

在团队开发或者引入第三方JS的时候，有时候会造成全局对象的命名冲突，比如a.js有个全局函数sendMsg()，b.js也有个全局函数sendMsg()，引入a.js和b.js文件时，会造成sendMsg()函数冲突。

示例：

```
全局变量冲突：b.js会覆盖a.js的同名函数                                // a.js
                                                                 ------------------------
                                                          +----> | function sendMsg() { |
<script src="/js/b.js" type="text/javascript"></script>---+      |     alert('a');      |
<script src="/js/a.js" type="text/javascript"></script>---+      | }                    |
<script type="text/javascript">                           |      ------------------------
                                                          |      // b.js
    sendMsg(); // => ‘b’                                  |      -------------------------
                                                          |      | function sendMsg() {  |
</script>                                                 +----> |     alert('b');       |
                                                                 | }                     |
                                                                 -------------------------
```

### 3.2 单全局变量

所创建的全局对象名称是独一无二的，并将所有的功能代码添加到这个全局对象上。调用自己所写的代码时，以这个全局对象为入口。

如：
- jQuery的全局对象：$和jQuery
- ExtJS的全局对象：Ext

示例：

```
全局变量冲突：b.js和a.js都有各自的主对象。                             // a.js
                                                                 -----------------------------
                                                                 | var A = A || {};          |
                                                          +----> | A.sendMsg = function () { |
<script src="/js/b.js" type="text/javascript"></script>---+      |     alert('a');           |
<script src="/js/a.js" type="text/javascript"></script>---+      | }                         |
<script type="text/javascript">                           |      -----------------------------
                                                          |      // b.js
    A.sendMsg(); // => ‘a’                                |      ------------------------------
                                                          |      | var B = B || {};           |
                                                          |      | B.sendMsg = function () {  |
    B.sendMsg(); // => 'b'                                +----> |     alert('b');            |
                                                                 | }                          |
                                                                 ------------------------------
</script>
```

### 3.3 命名空间

在项目规模日益壮大时，可采用命名空间的方式对JS代码进行规范：即将代码按照功能进行分组，以组的形式附加到单全局对象上。

以Ext的chart模块为例：

```
                                                       ------------
                                                 +---> |   Axis   |
                                                 |     ------------
                                                 |     ------------
                                                 +---> | Category |
                                    子模块名称     |     ------------
                                    ----------   |     ------------
                              +---> |  axis  | --+---> |    ...   |
                  模块名称     |      ----------         ------------
                  ---------   |     ----------         ------------
            +---> | chart | --+---> | series | --+---> |   Area   |
单全局对象    |     ---------   |     ----------   |     ------------
---------   |                 |     ----------   |     ------------
|  Ext  | --+                 +---> |  ...   |   +---> |   Bar    |
---------   |                       ----------   |     ------------
            |     ---------                      |     ------------
            +---> |  ...  |                      +---> |   ...    |
                  ---------                            ------------
```
