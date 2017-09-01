---
title: Parsing URL parameters - the easy way
date: 2015-10-15
tags:
 - JavaScript
 - Gist
---

# Parsing URL parameters - the easy way

I can't believe that I couldn't find a jQuery plugin or a vanilla-JS snippet that would parse the URL parameters infallibly. All of the solutions I stumbled upon were inconvenient to use or, probably surprisingly for their authors, failed when a parameter's value contained the equal sign.

It felt like a right time to save the world myself, therefore I came up with the following code:

{% gist 72aa8fc4c3e97f7321bc %}

The snippet transforms this:

```
http://example.com/lorem?foo=bar&foo2=baz&foo3=
```

into this (mind the missing `foo3` parameter):

```javascript
{
    foo: "bar",
    foo2: "baz"
}
```


The code has been tested on major browsers and seems to work flawlessly. However if anything goes wrong (naah, it won't happen), [let me know about it](https://twitter.com/zbicin).