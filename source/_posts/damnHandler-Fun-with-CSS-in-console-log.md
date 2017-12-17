---
title: damnHandler - having fun with CSS in console
tags:
  - JavaScript
subtitle: Embedding a GIF image into a console.log output.
cover: cover.jpg
date: 2017-12-12 20:01:18
---


Recently I wanted to check out the state of CSS implementation in `console.log` method. After few minutes of fiddling with the code I've came up with an error handler* that displays [a popular reaction GIF](https://gph.is/QFXhvE) from the [Friday](http://www.imdb.com/title/tt0113118/) movie:

{% gfycat AdventurousWhisperedHorseshoebat fixed 640 302 %}

## But, how does it work?

The code behind the `damnHandler` function was eventually something like this:

{% gist 6125746c20d4d7d795fcdae42304c3a1 %}

According to the spec, there are [plenty of formatters](https://console.spec.whatwg.org/#formatting-specifiers) that can be used to improve the look of `console.log`'s output. One of them is `%c` which applies CSS styling to the given text. The formatter has to appear before the formatted text.

So what we actually do is printing a 1px large dot, which uses `line-height` and `padding` properties in order to create a box with desired dimensions (the size of the image is 250px by 140px). We cannot simply use `height` and `width` altogether with `display: block` because these properties seem to be ignored. Eventually we set the `background` to point to the [GIF image hosted at Giphy](https://gph.is/QFXhvE).

Sadly it seems to work on Chrome only. Firefox, Internet Explorer 11 and Edge ignore the `background` property and interpret `line-height` and `padding` combination differently than Chrome while used in `console.log`.

_ \* Technically speaking, it's not even a proper handler since it simply rethrows the error given. But you know, it's **for the science**... ;) _

## Further reading
 - [Styling console output with CSS at Google Developers](https://developers.google.com/web/tools/chrome-devtools/console/console-write#styling_console_output_with_css)
 - [Friday ad IMDB](http://www.imdb.com/title/tt0113118/)