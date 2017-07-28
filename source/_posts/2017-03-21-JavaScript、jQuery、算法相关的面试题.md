---
title: JavaScript、jQuery、算法相关的面试题
date: 2017-03-21 21:17:28
tags:
- JavaScript
- jQuery
- Promise
- Algorithm
categories:
- 面试
---

这是一次电话面试加远程QQ监督机试。

<!--more-->

## 电话面试

问题：

一些我答对了的简单问题就不列出来了

- 快速排序怎么实现的？算法复杂度？用的什么思想？是稳定排序还是非稳定排序？
- jQuery中自定义事件的实现原理？(bind, trigger)
- 如何处理过多的回调嵌套？Promise的实现原理？
- 请描述三次握手和四次挥手。

### 快速排序怎么实现的？算法复杂度？用的什么思想？是稳定排序还是非稳定排序？

快速排序的的JavaScript实现如下：

```javascript
var quickSort = (arr) => {

    if (arr.length <= 1) return arr;

    let pivotIndex = ~~(arr.length/2),
        pivot = arr.splice(pivotIndex, 1)[0],
        left = [],
        right = [];

    for (let i = 0; i < arr.length; i++) {

        if (arr[i] < pivot) {
            left.push(arr[i]);
        } else {
            right.push(arr[i]);
        }

    }

    return quickSort(left).concat([pivot], quickSort(right));
};

```

快速排序的时间复杂度平均为`O(n*log(n))`，最差的情况为`O(n^2)`。采用的是分治的思想。是非稳定排序。


### jQuery中自定义事件的实现原理？(bind, trigger)


## 机试

问题：

- 写一个函数，实现大整数的加法。
- 每次走1级或者2级阶梯，走到第n级阶梯的方式有多少种？请运用动态规划的思想。

### 写一个函数，实现大整数的加法。

我的答案：

```javascript
var add = (a, b) => {

    if (a.length === 0 || b.length === 0) return;

    if (parseInt(a) < 0 || parseInt(b) < 0) return;

    if (parseInt(a) === 0 && parseInt(b) === 0) return '0';

    var string2Array = (str) => str.split('');

    var arrA = string2Array(a),
        arrB = string2Array(b);

    var lenA = arrA.length,
        lenB = arrB.length;

    if (lenA > lenB) {

        arrB = Array(lenA - lenB + 1).join('0').split('').concat(arrB);

    } else if (lenA < lenB) {

        arrA = Array(lenB - lenA + 1).join('0').split('').concat(arrA);

    }

    var tempArr = arrA.map((item, index) => parseInt(item) + parseInt(arrB[index]));

    var i = tempArr.length - 1;

    while (i >= 0) {

        let currentVal = tempArr[i].toString();

        if (currentVal >= 10) {

            tempArr[i] = currentVal.substr(1);

            if (i === 0) {

                tempArr.unshift(currentVal.substr(0, 1));

                break;
            }

            tempArr[i-1] = parseInt(tempArr[i - 1]) + parseInt(currentVal.substr(0, 1));

        } else {

            tempArr[i] = currentVal.toString();
        }

        i--;
    }

    var result = tempArr.join('').replace(/^0+/, '');

    return result;
};

```

这个答案还是我第二次才写出来的，但是提交之后明显被鄙视了。面试官的回答就是，你既然用了`parseInt`,为什么不直接来个

```javascript
var add = (a, b) => parseInt(a) + parseInt(b);

```

就好了？

我表示很无语，但又无法反驳。面试肯定挂了，但是我还是不放弃追求真理的决心，我去网上找最优解，结果真的吓到我了。请看代码：

```javascript
var sumOfString = (a, b) => {
    
    let result = '',
        tempVal = 0,
        arra = a.split(''),
        arrb = b.split('');

    while (arra.length || arrb.length || tempVal) {

        tempVal += ~~arra.pop() + ~~arrb.pop();

        result = tempVal % 10 + result;

        tempVal = tempVal > 9;
    }

    return result.replace(/^0+/, '');

};

```

简单到不能忍。里面的技巧打死也想不到：

- `arra.length || arrb.length || tempVal`: 巧妙的循环边界条件
- `~~arra.pop()`: 把字符串转换成数字并取整
- `tempVal = tempVal > 9`: 如果`=`右边的判断正确，则`tempVal`的值为`true`，下次循环进入第一步计算的时候又会转换成`1`，从而实现进位。同样可以解释为`false`的情况。


### 每次走1级或者2级阶梯，走到第n级阶梯的方式有多少种？请运用动态规划的思想。

实现方式如下：

```javascript
var methodsToStepN(n) {

    if (n <= 0) return 0;

    if (n === 1) return 1;

    if (n === 2) return 2;

    return methodToStepN(n - 1) + methodToStepN(n - 2);

};

```

