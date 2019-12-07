---
title: Git/Bash aliases for lazy devs (including myself)
subtitle: A set of aliases that I genuinely use on everyday basis.
description: A set of aliases that I genuinely use on everyday basis.
date: 2019-12-06
tags: Git
cover: cover-50.jpg
cover_color: a87c3a
backdrop_opacity: 0.7
---

Some time ago I stumbled upon several repositories containing sets of aliased commands, that were meant to simplify everyday Git operations. I don't have exact links, but the idea stuck in my head and kept incubating in the meantime.


As a result, I've established a set of my own aliases that I use on a daily basis. I'm happy to share them with you in this post and hopefully you'll find something useful for your working style.

## `.gitconfig` or `.bashrc`?

Technically, there are several ways to do that. For example, we can use a dedicated [`git alias`](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases) command to set it up or simply put some `alias` statements in the `.bashrc` file. The first approach allows us to create aliases such as `git ch` (=`git checkout`), however the `git` part of the command is always required. We can do better than that. ;)

 Using bash aliases in `.bashrc` gives us more flexibility. We can skip the `git` part entirely and make commands even shorter, e.g. `gch` instead of `git checkout`.

## My aliases in `.bashrc`

Below you can see a set of aliases that I established during a few months and genuinely use everyday. Just copy paste them into your `~/.bashrc` file and restart the terminal. Feel free to share your own aliases in the comments!

<script src="https://gist.github.com/zbicin/69d9a70b22207e55b296efd9a7da7a53.js"></script>

{% unsplash p eMzblc6JmXM "Kari Shea" %}
