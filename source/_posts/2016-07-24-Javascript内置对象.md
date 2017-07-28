---
title: Javascript内置对象
date: 2016-07-24 12:21:35
tags:
- JavaScript
categories:
- 笔记
---

## 什么是对象  
JavaScript中的所有事物都是对象，如：字符串、数值、数组、函数等，每个对象带有**属性**和**方法**。  
<!-- more -->
- **对象的属性**
	- 定义：反映该对象某些特定的性质的。如：字符串的长度、图像的长宽等
	- 访问对象属性：`objectName.propertyName`  
- **对象的方法**
	- 定义：能够在对象上执行的动作。例如，表单的“提交”(Submit)，时间的“获取”(getYear)等
	- 访问对象的方法：`objectName.methodName()`

## Date对象
Date对象可以储存任意一个日期，并且可以精确到毫秒数（1/1000 秒）。  
- 定义一个时间对象：`var myDate=new Date(); `  
- Date对象中处理时间和日期的常用方法：  

| 方法名称 | 功能|
| --------|--------|
| `get/setDate()` | 返回/设置日期(1 ~ 31)|
| `get/setFullYear()` | 返回/设置年份，用四位数表示|
| `get/setYear()` | 返回/设置年份|
| `get/setMonth()` | 返回/设置月份(0 ~ 11)|
| `get/setDay()` | 返回/设置星期(0 ~ 6)|
| `get/setHours()` | 返回/设置小时(0 ~ 23)|
| `get/setMinutes()` | 返回/设置分钟(0 ~ 59)|
| `get/setSeconds()` | 返回/设置秒钟(0 ~ 59)|
| `get/setMilliSeconds()` | 返回/设置毫秒(0 ~ 999)|
| `get/setTime()` | 返回/设置时间(毫秒)|

## String字符串对象
- **Array数组对象的部分方法**  
	- **返回指定位置的字符**  
		`stringObject.charAt(index)`  
		`index`：*必需*。表示字符串中某个位置的数字(字符在字符串中的下标)。  
	- **返回指定的字符串首次出现的位置**  
		`stringObject.indexOf(substring, startpos)`  
		`substring`：*必需*。需要检索的字符串值。
		`startpos`：*可选*。整数，表示字符开始检索的位置，取值范围为`0`到`stringObject.length-1`。如省略此参数，则从被检索字符串首字符开始检索。  
	- **字符串分割**  
		`stringObject.split(separator,limit)`  
		`separator`：*必需*。表示从该参数指定的位置分割`stringObject`。  
		`limit`：*可选*。表示分割的次数，如设置该参数，返回的子串数量不会多于该参数。  
	- **提取字符串**  
		`stringObject.substring(starPos,stopPos)`  
		`starPos`：*必需*。一个非负的整数，表示开始位置。  
		`stopPos`：*可选*。一个非负的整数，表示结束位置，如省略该参数，返回的子串一直到`stringObject`的结尾。  
	- **提取指定书目字符串**  
		`stringObject.substr(startPos,length)`  
		`starPos`：*必需*。一个非负的整数，表示开始位置。  
		`length`：*可选*。一个非负的整数，表示提取字符串的长度，如省略该参数，返回的子串一直到`stringObject`的结尾。  

## Math对象
Math对象，提供对数据的数学计算。Math 对象是一个固有的对象，无需创建它，直接把 Math 作为对象使用就可以调用其所有属性和方法。这是它与Date,String对象的区别。  
- **Math对象的部分属性**

| 属性 | 说明 |
| ----- | ----- |
| `Math.E` | 返回算术常量e，即自然对数的底数(约2.718) |
| `Math.PI` | 返回圆周率(约3.14159) |

- **Math对象的部分方法**  
	- **向上取整**  
	`Math.ceil(x)`  
	`x`：*必需*。必须是一个数值。  
	- **向下取整**  
	`Math.floor(x)`  
	`x`：*必需*。必须是一个数值。  
	- **四舍五入**  
	`Math.round(x)`  
	`x`：*必需*。必须是一个数值。  
	- **随机数**  
	`Math.random();`  
	返回一个大于或等于0但小于1的符号为正的数字值。  

## Array数组对象
数组对象是一个对象的集合，里边的对象可以是不同类型的。数组的每一个成员对象都有一个“下标”，用来表示它在数组中的位置，是从0开始的。  
- **Array数组对象的部分方法**  
	- **数组连接**  
	`arrayObject.concat(array1,array2,...,arrayN)`  
	该方法用于连接两个或多个数组。此方法返回一个新数组，不改变原来的数组。  
	- **指定分隔符连接数组元素**  
	`arrayObject.join(separator)`  
	`separator`：*可选*。表示要使用的分隔符，如果省略该参数，则使用逗号作为分隔符。  
	- **颠倒数组元素顺序**  
	`arrayObject.reverse()`  
	该方法会改变原来的数组，而不会创建新的数组。  
	- **选定元素**  
	`arrayObject.slice(start,end)`  
	`start`：*必需*。规定从何处开始选取，如果是负数，那么它规定的是从数组尾部开始算起的元素。-1指最后一个元素，-2指倒数第二个元素。   
	`end`：*可选*。规定从何处结束选取，如果这个参数是负数，那么它规定的是从数组尾部开始算起的元素。    
	- **数组排序**  
	`arrayObject.sort(方法函数)`  
	`方法函数`：*可选*。规定排序顺序，必须是函数。如果不指定<方法函数>，则按unicode码顺序排列。    
