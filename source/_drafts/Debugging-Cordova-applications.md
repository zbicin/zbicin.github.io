---
title: Debugging Cordova applications
tags: 
 - Apache Cordova
 - Adobe PhoneGap
 - Android
---

<center>

_Photo by [Lilly Rum](https://unsplash.com/photos/15YTRXKuJ14?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)_

</center>

#### TODO
 - make sure you refer to appropriate cordova/phoegap

# Debugging Cordova applications

Cordova gives us a great opportunity to build mobile applications using the web development stack. It does so by embeding an HTML document into a special instance of a web browser and  exhibiting several additional APIs in JavaScript.

<center>
{% asset_img cordova_bot.png Apache Cordova Logo %}
</center>

It all sounds great until the first obstacles appear in our sight. Sooner or ~~later~~ sooner we need to test the application and debug all of the unexpected behaviours. There are several ways of doing so, depending on the version of the device we want to test.

_Disclaimer:_ I have very little experience when it comes to the Apple products, therefore I will focus on Android devices only.

## Serving application as a webpage using cordova serve

That's the easy one. You can simply type `cordova serve` in your terminal and it will launch a web server which makes your application accessible via a regular web browser either on your PC or on your mobile device. In the first case you can simply use Chrome/Firefox Dev Tools in order to debug.

```bash
$ phonegap serve
[phonegap] starting app server...
[phonegap] listening on 10.7.206.254:3000
[phonegap] 
[phonegap] ctrl-c to stop the server
[phonegap] 
```

<center>
{% asset_img devtools.jpg Debugging in using Chrome Dev Tools %}
</center>

However, there are two catches in that approach.

First of all, some of the additional JavaScript interfaces provided by Cordova or its plugins will not be available. For instance, when using the served webpage I was not able to get the version using the [cordova-plugin-app-version](https://github.com/whiteoctober/cordova-plugin-app-version). 

In addition to that, if your application makes HTTP requests to another service, you will have to deal with [cross origin requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS). It is not the problem when launching the actual application on a device, because there is no origin in such case. A solution to this is using mock data or (even better) setting up a proxy.

## Remote debugging on a target device

Some time ago, Google introduced the Remote Debugging functionality in Chrome and [it is just awesome](https://developers.google.com/web/tools/chrome-devtools/remote-debugging/). It allows you to comfortably use regular, desktop Chrome Dev Tools to remotely debug the application running on your mobile device. In order to use it you have to:

1. Install Android SDK on your desktop.
1. [Enable Developer Mode and allow USB debugging in your mobile device](https://developer.android.com/studio/command-line/adb.html#Enabling).
1. Plug-in your mobile device to the PC using the USB cable.
1. Launch the app in your mobile device.
1. Go to `chrome://inspect` in your desktop Chrome and enable discovering USB devices.
1. Open remote dev tools by clicking inspect right next to your device listed under 'Remote Target' section.

<center>
{% asset_img remote.jpg Nexus 5 device listed in the Remote Targets section %}
</center>

Unfortunately, it doesn't work with PhoneGap application running under Android 4. The reason behind that is that Chrome was not a default Android browser back then. Therefore, Cordova applications are hosted by a WebView which bases on the so-called Android Browser, not Chrome.

## Weinre

## adb logcat

`adb logcat browser:V *:S`

`adb logcat | grep Web`
