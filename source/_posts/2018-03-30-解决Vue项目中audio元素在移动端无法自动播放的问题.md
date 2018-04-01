---
title: 解决Vue项目中audio元素在移动端无法自动播放的问题
date: 2018-03-30 10:15:12
tags:
- Vue
- audio
- HTML5
- mobile
categories:
- 笔记
---

## 问题描述

用 Vue 开发一个 HTML5 活动页面，活动页面需要一个循环播放的背景音乐，一进入页面就自动播放。按照正常思维，直接插入 `audio` 元素，设置好属性就算完了。就像下面这样：

```html
<audio src="path/to/music" loop autoplay></audio>
```

这样多简单啊，在 PC 浏览器上也表现正常。拿到手机上测试一下，才发现根本不出声音。问题就来了，为啥在手机上不能自动播放呢。

<!-- more -->

## 探索过程

使用 google 大法了解到，移动设备为了节省流量，禁用了 `audio` 元素的自动播放的功能。必须要有用户交互才能播放音频，比如说 `touchstart` 事件。

了解到这个重要信息，马上也就可以找到相应的解决办法，那就是模拟 `touchstart` 事件啦，然后把这个事件的触发放到 Vue 的生命周期方法中，比如 `mounted`。

因此马上就做一个音频播放器的组件 `AudioPlayer.vue` 的组件，具体代码如下：

```html
<template>
  <div class="player">
    <div
      class="player-cd"
      id="trigger"
    >
      <audio
        :src="src"
        id="audio"
        loop
      ></audio>
  </div>
  </div>
</template>
<script>
export default {
  data () {
    return {
      src: 'http://o9o8lcfa3.bkt.clouddn.com/%E5%88%9A%E5%A5%BD%E9%81%87%E8%A7%81%E4%BD%A0.m4a'
    }
  },
  mounted () {
    let trigger = document.getElementById('trigger')
    let audio = document.getElementById('audio')
    trigger.addEventListener('touchstart', () => {
      audio.play()
    })

    // 模拟触发 「touchstart」 事件
    this.createTouchstartEventAndDispatch(trigger)
  },
  methods: {
    createTouchstartEventAndDispatch (el) {
      let event = document.createEvent('Events')
      event.initEvent('touchstart', true, true)
      el.dispatchEvent(event)
    }
  }
}
</script>
<style lang="less" scoped>
// var
@cdWidth: 50vmin;

// mixins
// 水平垂直居中的 flex 布局
.flex-align-justify-center {
  display: flex;
  align-items: center;
  justify-content: center;
}

// 直径为 width 的圆
.circle (@width) {
  width: @width;
  height: @width;
  border-radius: 50%;
}

// block 伪类
.absolute-block {
  content: '';
  display: block;
  position: absolute;
}

.player {
  .flex-align-justify-center;

  width: 100vw;
  height: 100vh;

  &-cd {
    .flex-align-justify-center;
    .circle(@cdWidth);
    background: linear-gradient(#666, #000);

    .absolute-circle-block (@color, @width) {
      .absolute-block;
      .circle(@width);
      background: @color;
    }

    &::before {
      .absolute-circle-block(darken(#f00, 5%), 20vmin);
    }

    &::after {
      .absolute-circle-block(#222, 5vmin);
    }
  }
}
</style>
```

去浏览器预览的时候发现，上面的代码在 PC 和 Android 手机上和预期一样，可以自动播放。但是在 iOS 上依然不行。通过更进一步的了解，发现在微信内置浏览器内有一种解决办法，利用的是微信内置浏览器的事件 `WeixinJSBridgeReady`。具体实现见下一小节。

## 解决方法（不彻底）

目前自动播放功能实现情况如下：

| 平台 | 系统自带浏览器 | 微信内置浏览器 |
| --- | --- | --- |
| PC | ✔️ | ✔️ |
| Android | ✔️ | ✔️ |
| iOS | ✔️ | ✔️ |

在实现上述功能的基础上，增加播放旋转，点击切换播放、暂停功能。最终组件代码如下：

```html
<template>
  <div class="player">
    <div
      class="player-cd"
      id="trigger"
      :style="{transform: 'rotate(' + transformValue + 'deg)'}"
    >
      <audio
        :src="src"
        id="audio"
        loop
      ></audio>
  </div>
  </div>
</template>
<script>
export default {
  data () {
    return {
      src: 'http://o9o8lcfa3.bkt.clouddn.com/%E5%88%9A%E5%A5%BD%E9%81%87%E8%A7%81%E4%BD%A0.m4a',
      playing: false,
      transformValue: 10,
      transformInterval: null
    }
  },
  mounted () {
    let trigger = document.getElementById('trigger')
    let audio = document.getElementById('audio')
    trigger.addEventListener('touchstart', () => {
      audio.play()
      this.togglePlay()
    })

    // 单独处理微信内置浏览器自动播放
    document.addEventListener('WeixinJSBridgeReady', () => {
      audio.play()
    }, false)

    // 模拟触发 「touchstart」 事件
    this.createTouchstartEventAndDispatch(trigger)
  },
  methods: {
    createTouchstartEventAndDispatch (el) {
      let event = document.createEvent('Events')
      event.initEvent('touchstart', true, true)
      el.dispatchEvent(event)
    },
    togglePlay () {
      this.playing = !this.playing
      if (this.playing) {
        this.transformInterval = setInterval(
          () => this.changeTransformValue(),
          100
        )
      } else {
        clearInterval(this.transformInterval)
        this.transformInterval = null
      }
    },
    changeTransformValue () {
      this.transformValue += 10
    }
  },
  watch: {
    playing (playing) {
      let audio = document.getElementById('audio')
      if (playing) {
        audio.play()
      } else {
        audio.pause()
      }
    }
  }
}
</script>
<style lang="less" scoped>
// var
@cdWidth: 50vmin;

// mixins
// 水平垂直居中的 flex 布局
.flex-align-justify-center {
  display: flex;
  align-items: center;
  justify-content: center;
}

// 直径为 width 的圆
.circle (@width) {
  width: @width;
  height: @width;
  border-radius: 50%;
}

// block 伪类
.absolute-block {
  content: '';
  display: block;
  position: absolute;
}

.player {
  .flex-align-justify-center;

  width: 100vw;
  height: 100vh;

  &-cd {
    .flex-align-justify-center;
    .circle(@cdWidth);
    background: linear-gradient(#666, #000);
    transition: all .2s linear;

    .absolute-circle-block (@color, @width) {
      .absolute-block;
      .circle(@width);
      background: @color;
    }

    &::before {
      .absolute-circle-block(darken(#f00, 5%), 20vmin);
    }

    &::after {
      .absolute-circle-block(#222, 5vmin);
    }
  }
}
</style>
```

附上线上[预览地址](https://codepen.io/ricosmall/pen/qoYjOP)
