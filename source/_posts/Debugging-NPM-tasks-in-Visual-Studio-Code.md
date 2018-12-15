---
title: Debugging NPM tasks in Visual Studio Code
subtitle: How to chase down ambiguous compilation errors. 
date: 2018-12-15 17:48:14
tags:
  - Visual Studio Code
  - Debugging
  - NPM
cover: cover-70.jpg
cover_color: 323034
description: How to chase down ambiguous compilation errors.
---

Recently I've stumbled upon a nasty error thrown by _karma_, that was raising in the middle of bundle compilation of our package. To make things worse, code compilation worked fine when launching the project in a browser. Only the compilation for testing was broken.

The error said that there was an _Invalid Left-Hand Side in arrow function parameters_ somewhere in our code. It provided a stack trace and a position in form of `FileName.ts:123` which it fine, right?

Unfortunately, the line indicated by the error was something like this:

`await this.doSomeUpdates();`

which doesn't really look like an arrow function ;).

## The problem

Our codebase is written almost exclusively in _TypeScript_, so in order to launch unit tests in _Chrome_, we need to transpile it into _JavaScript_. The code is compiled and bundled using _Webpack_, **stored in memory** and launched by _karma_ in a headless browser instance.

It was clear, that the line indicated by the error, was pointing to a compiled file stored in memory, rather than to a _TypeScript_ source file. I saw two possibilies to cope with this problem:

1. Review the _Webpack_ and/or _karma_ configuration files, spend infinite amount of hours googling and troubleshooting, hoping that some fix will magically make the error point to a correct line, or...
2. Debug _karma_ launching our tests, chase down the error and find the source file in memory that causes problems.

## The solution

Since _NPM_ tasks are simply JavaScript files, it is possible to run them within the _Visual Studio Code_ debugger. This way we can debug the internals of libraries and track any ambiguous errors, uncaught exceptions and other surprises.

All of your locally installed packages are located in the 
`node_modules` directory. However, it has a special folder named `.bin` which typically contains executables of the downloaded modules. So nothing stops us from pointing to them within the _VSCode_'s `launch.json` file.

Let's say that we have a following task defined in a `package.json`:

```json
{
  // ...
  "scripts": {
    "start": "webpack --config config/webpack.config.js"
  },
  // ...
}
```

It's equivalent in `.vscode/launch.json` would be:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "Debug Webpack",
            "program": "${workspaceFolder}/node_modules/.bin/cli.js",
            "args": [
                "--config",
                "config/webpack.config.js"
            ]
        }
    ]
}
```

After saving the `launch.json` file, we can select _Debug Webpack_ from _Configuration selector_, run the script with `F5` and... that's it!

{% asset_img center debugger.png Hitting a breakpoint within the Webpack's configuration file %}

Happy debugging! 🐞

{% unsplash p 5fNmWej4tAA "Helloquence" %}