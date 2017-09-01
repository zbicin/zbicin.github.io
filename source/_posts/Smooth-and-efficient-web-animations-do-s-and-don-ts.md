---
title: Smooth and efficient web animations - do's and don'ts
date: 2015-09-21
tags:
 - CSS
 - JavaScript
---

# Smooth and efficient web animations - do's and don'ts

Back in 2012, CSS3 was a novelty and only few heard and used modern JavaScript frameworks such as heroic AngularJS. It was still a _jQuery era_ in web development which, as we know now, was soon to collapse.

By that time, jQuery was used for many purposes and one of them was animating objects on webpages. It worked quite well (and still do), however with CSS3 being supported by every modern browser, we would be foulish not to use it.

I'll make the point concise and simple: *using jQuery's `.animation()` is a huge no-go*. You move the responsibility of controlling animation to your JavaScript code and prevent the browser from optimizing it. Do it only if you have no other option (or time/project budget to spare).

Instead one should *use CSS [transition](https://css-tricks.com/almanac/properties/t/transition/) and [animation](https://css-tricks.com/almanac/properties/a/animation/) properties*. Besides being more appropriate for this task from the logical point of view (we're modifying the way how things look) it allows the browser to optimize it on its own and delegate part of processing to the GPU.
 
[According to the csstriggers.com](http://csstriggers.com/), properties that can be transformed with as little effort for the browser as possible are: 

 - `backface-visibility`, 
 - `perspective`
 
and most imporantly

 - `opacity` and 
 - `transform`. 

Using `top`, `left`, `margin`, `height` or `width` triggers the paint event which causes additional work to be performed by the CPU. *Therefore, i.e. modifying `transform: translate(x,y)` instead of `top: y; left: x;` pair will result in slightly smoother animation*.

I don't want to elaborate much on that topic. However if you don't trust my word, [Paul Irish made a great blogpost](http://www.paulirish.com/2012/why-moving-elements-with-translate-is-better-than-posabs-topleft/) where he digs into it in great detail. I can highly reccomend reading it if you want to know what happens under the hood.

If you've been reading this far, I'm sorry to disappoint you. In majority of cases, your animations will look almost the same as long as you avoid jQuery and use CSS to perform them...

...along with a desktop browser. Your CPU will manage to calculate everything on time and reach the magical 60FPS.

The thing is, avoiding unnecessary paint events can make a difference while using mobile devices such as smartphones, which have limited processing capabilities. A computer with a little over 1MHz was enough [to get Apollo 11 to the moon](https://en.wikipedia.org/wiki/Apollo_Guidance_Computer#Timing). I don't want to see my mobile stumble over a dropdown menu.