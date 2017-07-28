---
title: JavaScript创建对象的方式汇总
date: 2017-05-27 10:15:01
tags:
- JavaScript
- 构造函数
- JavaScript对象
categories:
- 笔记
---

JavaScript中创建对象的方式有很多种，每一种方式都有相应的优缺点，总结如下。

<!-- more -->

## 工厂模式

```javascript
function createPerson( name ) {
    var obj = new Object();

    obj.name = name;
    obj.getName = function () {
        console.log( this.name );
    };

    return obj;
}

var person = createPerson('John');
```

- 优点：简单直观
- 缺点：所有实例都指向同一个原型，无法辨识

## 构造函数模式

```javascript
function Person( name ) {
    this.name = name;

    this.getName = function () {
        console.log( this.name );
    };
}

var person1 = new Person( 'John' );
```

- 优点：实例可以识别一个特定的原型
- 缺点：每次实例化都会重新创建所有的方法

## 构造函数模式优化

```javascript
function Person( name ) {
    this.name = name;
    this.getName = getName;
}

function getName() {
    console.log( this.name );
}
```

- 优点：解决了每次实例化都要创建所有方法的问题
- 缺点：没有封装性可言

## 原型模式

```javascript
function Person( name ) {

}

Person.prototype.name = 'John';

Person.prototype.getName= function () {
    console.log( this.name );
};

var person1 = new Person();
```

- 优点：方法共享，不会被重建
- 缺点：所有属性都是共享的；不能初始化参数

## 原型模式优化

```javascript
function Person( name ) {

}

Person.prototype = {
    name: 'John',
    getName: function () {
        console.log( this.name );
    }
};

var person1 = new Person();
```

- 优点：有一定的封装性
- 缺点：重写了原型，丢失了constructor属性

## 原型模式再优化

```javascript
function Person( name ) {

}

Person.prototype = {
    constructor: Person,
    name: 'John',
    getName: function () {
        console.log( this.name );
    }
};

var person1 = new Person();
```

- 优点：可以通过constructor找到对应的构造函数
- 缺点：原型模式的公共缺点

## 组合模式

```javascript
function Person( name ) {
    this.name = name;
}

Person.prototype = {
    constructor: Person,
    getName: function () {
        console.log( this.name );
    }
};

var person1 = new Person( 'John' );
```

- 优点：使用广泛的模式，没有明显的毛病
- 缺点：需要更好的封装性

## 动态原型模式

```javascript
function Person( name ) {
    this.name = name;

    if (typeof this.getName !== 'function') {

        Person.prototype.getName = function () {
            console.log( this.name );
        };
    }
}

var person1 = new Person( 'John' );
```

- 优点：按需创建方法
- 缺点：没有明显的缺点

## 寄生构造函数模式

```javascript
function Person( name ) {

    var obj = new Object();

    obj.name = name;
    obj.getName = function () {
        console.log( this.name );
    };
}

var person1 = new Person( 'John' );

console.log( person1 instanceof Person ); // false
console.log( person1 instanceof Object ); // true
```

寄生构造函数和工厂模式的区别就是实例化的时候需要new。

- 优点：可以在不影响原生对象基础上扩展原生对象的方法、属性，形成新的构造函数
- 缺点：instanceof无法指向构造函数

## 稳妥构造函数模式

```javascript
function person( name ) {

    var obj = new Object();

    obj.getName = function () {
        console.log( name );
    }
}

var person1 = person( 'John' );
```

稳妥对象，指的是没有公共属性，方法中也不引用this的对象。

与寄生构造函数模式有两点不同：

1. 方法中不引用this
2. 实例化不用new

- 优点：适合用在比较安全的环境
- 缺点：和工厂模式一样，无法识别对象类型
