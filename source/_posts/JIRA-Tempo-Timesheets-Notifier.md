---
title: JIRA Tempo Timesheets Notifier
date: 2015-12-14
tags: 
 - JIRA
 - UserScript
---

I've made a UserScript that periodically displays currently tracked issue in JIRA Tempo Timesheets using HTML5 Notification API. It was a functionality that I really missed in Tempo Timesheets, so after tracking another couple of minutes to a wrong issue I decided to implement it myself. 

The idea is trivial: the script sets an interval, which every 10 minutes searches the DOM for the issue's summary and shows a new notification. 

<center>
{% asset_img toast.png Exemplary notification %}
</center>

The source and installation guide are [available on GitHub](https://github.com/zbicin/tempo-notifier).