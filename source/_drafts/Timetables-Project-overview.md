---
title: Timetables - Project overview
subtitle: Conclusions from developing an Apache Cordova app.
tags:
 - Apache Cordova
 - Adobe PhoneGap
 - Android
---

Recently I've been developing an Apache Cordova app showing timetables from bus/tram stops located nearby. It used the API served by the local public transport company and showed the results in a readable way. 

There were two main reasons to create this app:

 - unfulfilled need of being able to **quickly** check public transport nearby,
 - desire to create a mobile app using Cordova and evaluate this technology.

I'd like to share my thoughts and conclusions that I drew while working with this technology.

## The application overview

You can download the app in the [Google Play store](https://play.google.com/store/apps/details?id=in.zbic.timetables) and check it by yourself. If you feel adventorous, you can see the [source code in GitHub](https://github.com/zbicin/timetables-mobile).

The application has a single view, which contains all of the necessary information. Some of the blocks creating the app (e.g. single bus stop representation, debug console) are divided into components.

{% asset_img center app.png 360 %}

All of the lifecycle logic is handled by the `App` class which acts as a kind of a VM. Despite how heavy it may sound, it has only 130 lines of code so not so bad for the main file in the project. HTTP calls, API communication as well as data structures are extracted into separate files so the SRP can hold true.



## What was good

 - **Apache Cordova works** and it does it **pretty well**.  There were (almost) no unexplainable bugs and the task of providing a web view with an additional JavaScript API was fullfilled. 

 - This technology suits applications with **simple, custom UI**. There are no predefined components that are styled natively, so you'd have to design the whole *feeling* of the UI by yourself.

 - **There is no JavaScript framework** that you are forced to use, however you can always include one if you want. Unless you attempt to perform complex calculations, the app remains responsive and there is unnoticeable overhead caused by the web view. 

 - I've successfully configured **Webpack and TypeScript** to work with the Adobe PhoneGap CLI without much of a hassle. I only lost some time making [bluebird](http://bluebirdjs.com/) typing work as expected (and eventually failed to be honest).


## What was bad

 - **I've overengineered the UI class inheritance**. The attempt of creating dummy UI classes for components that would be used for testing was not beneficial enough to justify the time wasted on this task. I've totally separated the app logic from handling the UI and obtained over-complicated code instead.

 - The related tech looks a bit forgotten. I couldn't make Windows Phone build work on the Adobe PhoneGap Build platform and received no response from the support. Sometimes the plugins provided by community are outdated or incomplete (e.g. support only one or two platforms).

## Last word

Apache Cordova is a great way of creating simple applications and games using the web development stack. However, its limitations prevent it to become a 
sustainable tool for making complex, native-like software. In my opinion it's definately worth trying and playing around, but not mature enough to become a first-class framework.
