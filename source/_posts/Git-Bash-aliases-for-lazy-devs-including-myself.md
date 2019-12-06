---
title: Git/Bash aliases for lazy devs (including myself)
subtitle: A set of aliases that I genuinely use on everyday basis
description: A set of aliases that I genuinely use on everyday basis
date: 2019-12-06
tags: Git
cover_color: f5e9da
backdrop_opacity: 0.7
---

Some time ago I stumbled upon several repositories containing sets of aliased commands, that were meant to simplify everyday Git operations. I don't have exact links, but the idea stuck in my head and kept incubating in the meantime.


As a result, I've established a set of my own aliases that I use on a daily basis. I'm happy to share them with you in this post and hopefully you'll find something useful for your working style.

## `.gitconfig` or `.bashrc`?

Technically, there are several ways to do that. For example, we can use a dedicated [`git alias`](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases) command to set it up or simply put some `alias` statements in the `.bashrc` file. The first approach allows us to create aliases such as `git ch` (=`git checkout`), however the `git` part of the command is always required. We can do better than that. ;)

 Using bash aliases in `.bashrc` gives us more flexibility. We can skip the `git` part entirely and make commands even shorter, e.g. `gch` instead of `git checkout`.

## My aliases in .bashrc

Below you can see a set of aliases that I established during a few months and genuinely use everyday. Just copy paste them into your `~/.bashrc` file and restart the terminal. Feel free to share your own aliases in the comments!

```sh
# Git Push/Pull
alias gps='gpush';
__git_complete gps _git_push_
alias gpl='gpull';
__git_complete gpl _git_pull

# Git Fetch/Checkout
alias gf='git fetch';
__git_complete gf _git_fetch
alias gch='git checkout';
__git_complete gch _git_checkout
alias gfch='gf && gch';
__git_complete gfch _git_checkout
function gchp { git checkout $1; git pull; };
__git_complete gchp _git_checkout
function gchpch { git checkout $1; git pull; git checkout -; };
__git_complete gchpch _git_checkout

# Git Stash
alias gstash='git stash save';
alias gpop='git stash pop';

# Other Git aliases
alias gbfind='git branch --list -a | grep';
alias gshitiforgotthisone='git commit --amend --no-edit';
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
```
