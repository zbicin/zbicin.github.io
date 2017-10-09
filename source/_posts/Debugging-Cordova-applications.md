---
title: Debugging Cordova applications
tags:
  - Apache Cordova
  - Adobe PhoneGap
  - Android
date: 2017-10-08 17:14:11
cover: ./lilly-rum-342740.jpg
---

Cordova gives us a great opportunity to build mobile applications using the web development stack. It does so by embeding an HTML document into a special instance of a web browser and  exhibiting several additional APIs in JavaScript.

{% asset_img center cordovaBot.png 150 150 "Apache Cordova Logo" %}

It all sounds great until the first obstacles appear in our sight. Sooner or ~~later~~ sooner we need to test the application and debug all of the unexpected behaviours. There are several ways of doing so, depending on the version of the device we want to test.

This article covers debugging in desktop web browsers and Android devices.

## Serving application as a webpage using cordova serve

That's the easy one. You can simply type `cordova serve` in your terminal and it will launch a web server which makes your application accessible via a regular web browser either on your PC or on your mobile device. In the first case you can simply use Chrome/Firefox Dev Tools in order to debug.

```bash
$ cordova serve
[cordova] starting app server...
[cordova] listening on 10.7.206.254:3000
[cordova] 
[cordova] ctrl-c to stop the server
[cordova] 
```

{% asset_img center devtools.png 570 "Debugging using Chrome Dev Tools" %}

However, there are two catches in that approach.

First of all, some of the additional JavaScript interfaces provided by Cordova or its plugins will not be available. For instance, when using the served webpage I was not able to get the version using the [cordova-plugin-app-version](https://github.com/whiteoctober/cordova-plugin-app-version). 

In addition to that, if your application makes HTTP requests to another service, you will have to deal with [cross origin requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS). It is not the problem when launching the actual application on a device, because there is no origin in such case. A solution to this is using mock data or (even better) setting up a proxy. I plan on writing a separate blog post on that topic.

## Remote debugging on a target device

Some time ago, Google introduced the Remote Debugging functionality in Chrome and [it is just awesome](https://developers.google.com/web/tools/chrome-devtools/remote-debugging/). It allows you to comfortably use regular, desktop Chrome Dev Tools to remotely debug the application running on your mobile device. In order to use it you have to:

1. Install Android SDK on your desktop.
1. [Enable Developer Mode and allow USB debugging in your mobile device](https://developer.android.com/studio/command-line/adb.html#Enabling).
1. Plug-in your mobile device to the PC using a USB cable.
1. Launch the app in your mobile device.
1. Go to `chrome://inspect` in your desktop Chrome and enable discovering USB devices.
1. Open remote dev tools by clicking inspect right next to your device listed under 'Remote Target' section.

{% asset_img center remote.png Nexus 5 device listed in the Remote Targets section %}

<a name="android4"></a>Unfortunately, it doesn't work with Cordova applications running under Android 4. The reason behind that is that Chrome was not a default Android browser back then. Therefore, Cordova applications are hosted by a WebView which bases on the so-called Android Browser, not Chrome.

## Weinre

[Weinre](https://people.apache.org/~pmuellr/weinre/docs/latest/) is very similar to Chrome Dev Tools, since they both share large parts of code. Nevertheless, they work a little bit different.

{% asset_img center weinre.png 577 Weinre Dev Tools %}

While Chrome Remote Debugging establishes connection with the target device via USB, weinre sets up a regular HTTP connection via the network. It makes the configuration a little bit more complicated, however we are not restricted to Chrome browser anymore which might be useful [when debugging older devices](#android4).

## adb logcat

It may happen that the application crashes right after it starts e.g. because of some little syntax error that is unsupported by the target browser. Therefore neither Chrome Remote Debugging or Weinre may be able to attach themselves to the app soon enough to catch and display the error.

In such a case we can still grab some error output by attaching our device via a USB cable and using the `adb logcat` command. It dumps logs produced by the device, including ones coming from the embeded WebView and/or the native Android Browser.

1. Plug-in your mobile device to the PC using a USB cable.
1. Run `adb logcat | grep Web` (Android 5.0.0 and newer) or `adb logcat browser:V *:S` (Android 4) in the terminal.
1. Launch the app in your mobile device. Console output from the app should appear in the terminal.


```bash
$ adb logcat | grep Web
(...)
10-08 16:53:02.629 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : device.ready
10-08 16:53:02.632 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : app.refresh
10-08 16:53:02.639 22657 22657 D CordovaWebViewImpl: onPageFinished(file:///android_asset/www/index.html)
10-08 16:53:02.654 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : 0.25
10-08 16:53:02.761 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : 0.5
10-08 16:53:03.005 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : 0.75
10-08 16:53:03.006 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : 1
10-08 16:53:03.098 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : app.setupRefreshInteval
10-08 16:53:03.401 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : splash.transitionend
10-08 16:53:25.627 22657 22657 D SystemWebChromeClient: file:///android_asset/www/app.js: Line 3303 : device.pause
(...)
```

## Console emulator in the app

It may sound crazy, but it's very useful to dump all of the log messages into a hidden container within the HTML. [In one of my apps](https://play.google.com/store/apps/details?id=in.zbic.timetables) I've implemented a secret debug console, that appears after using the [Konami Code](https://en.wikipedia.org/wiki/Konami_Code) (not so secret anymore).

{% asset_img center debugConsole.png 270   Output provided by the adb %}

Thanks to this I am able to see what is going on in the application during the testing phase in the field or after the release. It also allowed me to track some of the bugs that were foreseen during the devlopment phase (mostly related to the app's lifecycle).

## Summary

In the majority of cases, debugging Cordova applications do not differ very much from debugging regular web pages. Thanks to `cordova serve` command and Chrome Remote Debugging it is much less painful that it used to be. Weinre provides very similar functionality, however its configuration may be a bit challenging at the first time.

However, there are some rare situations when those three are not sufficient for the task, especially when running on a real device. If that happens, we can always use non-typical aproaches, such as hidden debug console in the app or processing raw log output from the adb.

Happy debugging! 🐛 

_Photo by _[_Lilly Rum_](https://unsplash.com/photos/15YTRXKuJ14?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)_ on _[_Unsplash_](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)