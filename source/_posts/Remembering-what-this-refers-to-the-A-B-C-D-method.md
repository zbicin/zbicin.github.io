---
title: 'Remembering what ''this'' refers to - the A, B, C, D method'
date: 2016-09-04
tags: JavaScript
cover: diomari-madulara-110583.jpg
---

The `this` reference and how it can dynamically change in a runtime is one of the characteristic features of JavaScript. As far as I know, there is no analogy of this behavior in any other popular programming language.

Because of its uniqueness, it's no surprise that people are often confused by this mechanism and are not quite sure what `this` is going to refer to in a particular case.

<center>
{% asset_img tweet.png Just another happy JavaScript developer. %}
Just another happy JavaScript developer.
</center>

However, there are only four rules that compiler follows when resolving the `this` reference. For easier remembering, I put them in a sequence of A, B, C, D. The earlier the rule, the bigger importance and priority it has.

## A - A new object is being constructed

If the function was called with the `new` keyword, then `this` refers to an object constructed using this function.

```javascript
function whatIsThis() {
    console.log(this);
}

new whatIsThis(); // logs out whatIsThis{}
```

## B - context was BOUND using bind, call or apply

If the function was bound to a context using the `bind` method or was executed using `call` or `apply` methods, then `this` refers to an object passed as an argument to these functions.

```javascript
whatIsThis.bind(2)(); // 2
whatIsThis.call(2); // 2
whatIsThis.apply(2); // 2

// but:
var temp = whatIsThis.bind(2);
new temp(); // whatIsThis{} - the A rule has precedence
```

## C - CONTAINING object

If the function called was conatined within an object, then `this` refers to the containing object.

```javascript
var foo = {whatIsThis: whatIsThis};
foo.whatIsThis(); // foo

// but:
foo.whatIsThis.apply(2); // 2 - the B rule has precendence
```

## D - fallback to the DEFAULT behavior

If answers to all of the rules above are negative, then `this` refers to the global object or to `undefined` if [strict mode](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode) is enabled.

```javascript
whatIsThis(); // window, process or undefined
```

And that's pretty much it. :) You can check this behavior by yourself, using
[a fiddle I've created](https://jsfiddle.net/zbicin/owa92sa5/). It contains example code which shows how the `this` reference changes according to the mentioned rules.

{% unsplash p FFZjSpUwc_I "Diomari Madulara" %}
