---
title: JavaScript设计模式（一）
date: 2017-06-13 08:58:29
tags:
- JavaScript
- 设计模式
categories:
- 笔记
---

## 创建对象的基本模式

JavaScript中创建对象的基本模式有3种。第一种是门户大开型，它只能提供公用成员；第二种是使用下划线来表示方法或属性的私用性；第三种做法使用闭包来创建真正私用的成员，这些成员只能通过一些特权方法来访问。

不能简单地说这些定义类的模式中哪种是‘正确的’。它们各有利弊。

<!-- more -->

### 门户大开型对象

创建一个类，用一个函数来做其构造器。我们称其为门户大开型对象，因为它的所有属性和方法都是公开的、可访问的。这些公用属性要使用this关键字来创建：

```javascript
var Book = function (isbn, title, author) {
    if (isbn == undefined) throw new Error('Book constructor requires an isbn.');

    this.isbn = isbn;
    this.title = title || 'No title specified';
    this.author = author || 'No author specified';
}

Book.prototype.display = function () {
    ...
};
```

乍一看这个类似乎符合一切需求。但是最大的问题是你无法检验ISBN数据的完整性，而不完整的ISBN数据有可能导致display方法失灵。这破坏了你与其他程序员之间的契约。如果Book对象在创建的时候没有抛出任何错误，那么display方法应该能够正常工作才是，但是由于没有进行完整性检查，这就不一定了。因此需要强化一下：

```javascript
var Book = function (isbn, title, author) {
    if (!this.checkIsbn(isbn) throw new Error('Book: Invalid ISBN.'));

    this.isbn = isbn;
    this.title = title || 'No title specified';
    this.author = author || 'No author specified';
}

Book.prototype = {
    checkIsbn: function (isbn) {
        if (isbn == undefined || typeof isbn != 'string') {
            return false;
        }
    }

    isbn = isbn.replace(/-/, '');
    if (isbn.length != 10 && isbn.length != 13) {
        return false;
    }

    var sum = 0;
    if (isbn.length === 10) {
        if (!isbn.match(/^\d{9}/)) {
            return false;
        }

        for (var i = 0; i < 9; i++) {
            sum += isbn.charAt(i) * (10 - i);
        }

        var checksum = sum % 11;
        if (checksum === 10) checksum = 'X';
        if (isbn.charAt(9) != checksum) {
            return false;
        }
    } else {
        if (!isbn.match(/^\d{12}/)) {
            return false;
        }

        for (var i = 0; i < 12; i++) {
            sum += isbn.charAt(i) * ((i % 2 === 0) ? 1 : 3);
        }

        var checksum = sum % 10;
        if (isbn.charAt(12) != checksum) {
            return false;
        }
    },

    display: function () {
        ...
    }
}
```
现在看起来情况有所改善。在创建对象的时候可以对ISBN的有效性进行检查，这可以确保display方法能正常工作。但是现在又出现另一个问题。假设另一个程序员认识到一本书可能会有很多个版本，每个版本都有自己的ISBN。他设计了一个用来在这些不同版本之中进行选择的算法，并在实例化书籍对象之后直接用它修改isbn属性：

```javascript
theHobbit.isbn = '978-0261103283';
theHobbit.display();
```
即使能在构造器中对数据的完整性进行检验，你对其他程序员会把什么样的值直接赋给isbn属性还是毫无控制。为了保护内部数据，你为每个属性都提供了取值器和赋值器方法。取值器方法用于获取属性值，而赋值器方法则用于设置属性值。通过使用赋值器，你可以把一个新值真正赋给属性之前进行各种检验。下面是加了取值器和赋值器方法之后的新版Book对象：

```javascript
// Interface类的源码见文章末尾
var Publication = new Interface('Publication', ['getIsbn', 'setIsbn', 'getTitle', 'setTitle', 'getAuthor', 'setAuthor', 'display']);

var Book = function (isbn, title, author) {
    this.setIsbn(isbn);
    this.setTitle(title);
    this.setAuthor(author);
};

Book.prototype = {
    checkIsbn: function (isbn) {
        ...
    },
    getIsbn: function () {
        return this.isbn;
    },
    setIsbn: function (isbn) {
        if (!this.checkIsbn(isbn)) throw new Error('Book: Invalid ISBN.');
        this.isbn = isbn;
    },

    getTitle: function () {
        return this.title;
    },
    setTitle: function (title) {
        this.title = title || 'No title specified';
    },
    getAuthor: function () {
        return this.author;
    },
    setAuthor: function (author) {
        this.author = author || 'No author specified';
    },

    display: function () {
        ...
    }
};
```
虽然我们为设置属性提供了赋值器方法，但是那些属性仍然是公开的，可以被设置。

### 用命名规范区别私用成员

下划线是一个众所周知的命名规范，它表明一个属性（或方法）仅提供对象内部使用，直接访问它或者设置它可能会导致意想不到的后果。

```javascript
var Book = function (isbn, title, author) {
    this.setIsbn(isbn);
    this.setTitle(title);
    this.setAuthor(author);
};

Book.prototype = {
    _checkIsbn: function (isbn) {
        ...
    },
    getIsbn: function () {
        return this._isbn;
    },
    setIsbn: function (isbn) {
        if (!this._checkIsbn(isbn)) throw new Error('Book: Invalid ISBN.');
        this._isbn = isbn;
    },

    getTitle: function () {
        return this._title;
    },
    setTitle: function (title) {
        this._title = title || 'No title specified';
    },
    getAuthor: function () {
        return this._author;
    },
    setAuthor: function (author) {
        this._author = author || 'No author specified';
    },

    display: function () {
        ...
    }
};
```
这有助于程序员对它的无意使用，但是不能防止对它的有意使用。

### 用闭包实现私用成员

```javascript
var Book = function (newIsbn, newTitle, newAuthor) {

    var isbn, title, author;

    function checkIsbn(isbn) {
        ...
    }

    this.getIsbn = function () {
        return isbn;
    };
    this.setIsbn = function (newIsbn) {
        if (!checkIsbn(newIsbn)) throw new Error('Book: Invalid ISBN.');
        isbn = newIsbn;
    };

    this.getTitle = function () {
        return title;
    };
    this.setTitle = function (newTitle) {
        title = newTitle || 'No title specified';
    };

    this.getAuthor = function () {
        return author;
    };
    this.setAuthor = function (newAuthor) {
        author = newAuthor || 'No author specified';
    };

    this.setIsbn(newIsbn);
    this.setTitle(newTitle);
    this.setAuthor(newAuthor);
};

Book.prototype = {
    display: function () {
        ...
    }
};
```

Interface类的源码如下：
```javascript
var Interface = function (name, methods) {
    if (arguments.length != 2) {
        throw new Error('Interface constructor called with ' + arguments.length
        + 'arguments, but expected exactly 2.');
    }

    this.name = name;
    this.methods = [];
    for (var i = 0, len = methods.length; i < len; i++) {
        if (typeof methods[i] !== 'string') {
            throw new Error('Interface constructor expects method names to be '
            + 'passed in as a string.');
        }
        this.methods.push(methods[i]);
    }
};

Interface.ensureImplements = function (object) {
    if (arguments.length < 2) {
        throw new Error('Function Interface.ensureImplements called with '
        + arguments.length + 'arguments, but expected at least 2.');
    }

    for (var i = 1, len = arguments.length; i < len; i++) {
        var interface = arguments[i];
        if (interface.constructor !== Interface) {
            throw new Error('Function Interface.ensureImplements expects '
            + 'arguments two and above to be instances of Interface.');
        }

        for (var j = 0, methodsLen = interface.methods.length; j < methodsLen; j++) {
            var method =  interface.methods[j];
            if (!object[method] || typeof object[method] !== 'function') {
                throw new Error('Function Interface.ensureImplements: object '
                + 'does not implement the ' + interface.name
                + 'interface. Method ' + method + 'was not found.');
            }
        }
    }
};
```
