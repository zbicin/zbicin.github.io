---
title: Reactor pattern, libuv and Node.js
subtitle: The magic behind the non-blocking nature of Node.js.
date: 2018-12-07 13:16:47
tags:
  - JavaScript
  - Node.js
cover: cover-70.jpg
cover_color: D5A59D
description: The magic behind the non-blocking nature of Node.js.
---

Being able to _perform non-blocking I/O operations_ was one of the most vibrant _selling points_ of Node.js back in the days. This article provides an introduction to the inner mechanisms of this environment that allow it to deal with multitasking pretty much as cool as Xabi Alonso does:

{% asset_img center xabi.gif Xabi Alonso playing it cool %}

But first we need to talk about the _reactor pattern_.

## What is the reactor pattern?
The reactor pattern is one of the most commonly used patterns in web development. There is a pretty good chance that you are very familiar with it without even realizing it. Simply speaking, the application starts listening for an I/O event of a specified type, providing a function that should be launched as a 'reaction' to this event. Sounds exactly like JavaScript callbacks, isn't it? ;)

Thanks to this pattern we can use non-blocking I/O operations, which usually can take some time when being done in a classical, synchronous way (e.g. a database query, an HTTP request, reading a file).

In reactor pattern, when some part of code requests an I/O operation, the request is put in an _Event Queue_ within the _Event Demultiplexer_. Then the control is immediatley returned back to the developer's code. Thanks to this the application doesn't freeze and can immediately continue with other operations (e.g. performing calculations, listening for UI events and responding to user's input, etc.). 

In the meantime, the so-called _Event Loop_ processes the events stored in the _Event Queue_. It iterates through them and invokes the associated functions (_callbacks_ or _handlers_) when ready.

Let's see the example pseudocode implementation of en event loop taken from the book [_An Introduction to libuv_](https://nikhilm.github.io/uvbook/) by Nikhil Marathe:
```
while there are still events to process:
    e = get the next event
    if there is a callback associated with e:
        call the callback
```

Each of the operating systems (Linux, Mac OSX, Windows) has its own implementation of an _Event Demultiplexer_. Therefore an abstraction layer above those implementations had to be introduced.

## libuv to the rescue
In the early days of Node.js a library called _libev_ was used to handle abstraction above various _Event Demultiplexer_ implementations. Unfortunately it only supported Unix operating systems (_kqueue_ and _(e)poll_) and as the Node.js grew in popularity, this library became insufficient, because it demanded support for Windows as well. 

Then the famous _libuv_ was introduced, which is an abstraction above all of the implementations of _Event Demultiplexers_ (including Windows implementation: _IOCP_). It takes the responsibility for collecting events from the operating system or monitoring other sources of events. While being initially developed mostly with Node.js in mind, the _libuv_ library is now widely used by different projects, including Mozilla's _Rust_ programming language.

## How it all fits together?

I think that the best idea is to show it on a diagram. The architecture of a Node.js application can be presented as follows:

{% asset_img center NodejsArchitecture.png Node.js application's architecture %}

 - **Application code:** self explanatory ;),
 - **Node.js core:** (also called _node-core_) is a JavaScript implementation of Node.js APIs,
 - **Bindings:** wrap and expose _libuv_ and other low level functionality to JavaScript,
 - **V8:** execution engine developed initially for Google Chrome,
 - **libuv:** abstraction over _Event Demultiplexer_ of a hosting OS.

## Final thoughts

I hope this short introduction is a good starting point of learning about the inner mechanisms that make Node.js environment work. We've only scratched the surface, so if you're interested in more detailed information, I can suggest going through the references as the next step. 

## References
 - [_An Introduction to libuv_](https://nikhilm.github.io/uvbook/) by Nikhil Marathe
 - _Node.js Design Patterns Second Edition_ by Mario Casciaro, Luciano Mammino
 - [_The Node.js System_](https://hackernoon.com/the-node-js-system-51090c35dddc) by Aman Mittal
 
{% unsplash p LWnD8U2OReU "Frédéric Paulussen" %} 