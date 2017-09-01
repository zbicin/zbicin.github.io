---
title: ngh - you want to know this command
date: 2017-04-16
tags: Angular
---

# ngh - you want to know this command 

Back in the days there was a command in the [Angular CLI](https://cli.angular.io/) named `ng ghpages`. It was intended to provide a trival way of publishing the application generated with `ng`. It was building the project, grabbing the contents of the `dist` directory and pushing them to the `gh-pages` branch of the repository. Then, the application was available online at `<USERNAME>.github.io/<REPOSITORY NAME>`.

Because of unknown reasons (ok, [not so uknown](https://github.com/angular/angular-cli/pull/4385#issuecomment-280979569)) it got removed from the Angular CLI:

{% blockquote Mike Brocchi https://github.com/angular/angular-cli/pull/4385#issuecomment-280979569 discussion under the PR#4385 in the angular/cli repository %}
@gkucmierz there were many reported issues with this command, so rather than ship the CLI with the issues it was decided to remove it, especially with some viable community alternatives.
{% endblockquote %}

The void was quickly filled with new tools that were performing the same task. One that is especially worth recommending is [angular-cli-ghpages](https://github.com/angular-buch/angular-cli-ghpages). I use it in my Go home, JS project and it works flawlessly. You can check it out yourself by visiting [http://zbic.in/go-home-js](http://zbic.in/go-home-js).

What I would consider a good practice is creating an npm script that calls `ngh` with all required parameters. You can go [through all of the options](https://github.com/angular-buch/angular-cli-ghpages#options) yourself, to see what opportunities it gives. As a quick tl;dr example, a fragment of my `package.json` looks as follows:

```javascript package.json
{
  "scripts": {
    "ghpages": "ngh --no-silent --name=\"Krzysztof Zbiciński\" --email=\"<MY GITHUB EMAIL>\"",
  },
  //...
}
```