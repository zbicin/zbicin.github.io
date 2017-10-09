---
title: Long variable names and their benefits during debugging
date: 2015-07-11
tags: Other
---

Generally I tended to make jokes on Java and its long class, methods and variable names. The fact that there is a question on StackOverflow asking ["When a Java method name is too long?"](http://stackoverflow.com/questions/2230871/when-is-a-java-method-name-too-long) made it even more ridiculous for me.

However, after reading the [Clean Code by Robert C. Martin](http://www.amazon.com/exec/obidos/ASIN/0132350882/helion-20) my opinion on long names became more liberate. To the extent that now I promote using longer, descriptive names if their usage makes sense. They may come in handy while dubugging as well, which is the clue of this blog post.

Recently I've faced debugging a small piece of code that I found on SO:

```javascript
$('[popover], [popover-html-unsafe]').each(function () {
    var t = $(this);

    if(!(t.is(e.target) || t.has(e.target).length > 0)
        && t.siblings('.popover').length !== 0
        && t.siblings('.popover').has(e.target).length === 0) {
        t.trigger('click');
    }
});
```

It was meant to dismiss Bootstrap's Popvers added with Angular UI's directive on a click beyond their area.

It worked quite well, however it was possible to break things up in one particular case. My task was to figure out how to prevent it from happening which resulted in digging into the code and establishing a friendship with Dev Tools' breakpoints and Step Over button for a couple of minutes.

Dealing with four conditions in a quite complex combination wasn't fun to me at all. Each loop iteration I forgot what the `t.is(e.target) || t.has(e.target).length > 0` exactly is and had to decipher it one more time. The same went for other conditions as well.

But things got way better when I extracted the conditions into separate variables with quite long, descriptive names.

```javascript
$('[popover], [popover-html-unsafe]').each(function () {
    var t = $(this); // t is a considered element
    var consideredElementHasBeenClicked = t.is(e.target) || t.has(e.target).length > 0; 
    var consideredElementHasAVisiblePopover = t.siblings('.popover.in').length !== 0;
    var clickedElementIsNotWithinAPopoverOfTheConsideredElement = t.siblings('.popover').has(e.target).length === 0;

    if (!consideredElementHasBeenClicked && consideredElementHasAVisiblePopover && clickedElementIsNotWithinAPopoverOfTheConsideredElement) {
        t.trigger('click', [true]); // simulate click on the considered element -> hide it; true indicates the click hasn't been performed by the user
    }
});
```

Then after putting a breakpoint in the line where the `if` statement begins *I was able to observe the human-friendly conditions' descriptions with their values in the _Local_ pane of the Dev Tools* each time I pressed _Continue_.

Each time I proceeded to the next considered element, it saved me few seconds wasted on struggling with this unintuitive jQuery methods calls and prevented my brain from exploding.