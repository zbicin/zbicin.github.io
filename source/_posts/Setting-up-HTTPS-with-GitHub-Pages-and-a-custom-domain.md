---
title: HTTPS, GitHub Pages and a custom domain
subtitle: Quite surprisingly, setting it up wasn't so trivial.
description: Quite surprisingly, setting it up wasn't so trivial.
date: 2018-05-19 12:31:27
#cover: cover.jpg
tags:
 - GitHub
 - SSL
 - OVH
---

[GitHub Pages](https://pages.github.com/) are cool. It's a very fast and free way to host your static pages, used not only by weekend hackers, but also by [Twitter Bootstrap](http://getbootstrap.com/), [Electron](https://electronjs.org/) or... me, to host this blog. :)

For a long time it struggled with a quite major problem in my opinion. It was not supporting HTTPS in combination with a custom domain. Untill your page was hosted under `USERNAME.github.io` everything was working fine. However when you wanted to give your page a more tailored and customized look you were faced with a dillema: either do not use HTTPS and get this scary, red lock in your browser's address bar, or use some [tricks involving CloudFlare](https://medium.freecodecamp.org/an-illustrated-guide-for-setting-up-your-website-using-github-cloudflare-5a7a11ca9465).

Eventually, in May 2018 GitHub added this lacking functionality and [pages with a custom domain can be served over HTTPS](https://blog.github.com/2018-05-01-github-pages-custom-domains-https/). Being a long time user of a custom domain, I felt a slight relief, because I really considered changing to another hosting provider for this reason. 

Quite surprisinlgy, the process of turning on HTTPS was not so smooth, so I decided to write it down for future reference.

## Step by step guide

Here is a step by step guide how to turn on HTTPS in GitHub Pages with a custom domain hosted in OVH. Please, read the points carefully and do not omit any of them. The guide assumes that you are already using a custom domain with GitHub Pages over HTTP.

1. In your OVH Web Control Panel, go to the _Domains_ section, select your domain, and open the _Redirection_ tab. [Create four, A-type records](https://help.github.com/articles/setting-up-an-apex-domain/#configuring-a-records-with-your-dns-provider) that point to:
   - 185.199.108.153,
   - 185.199.109.153,
   - 185.199.110.153,
   - 185.199.111.153.
{% asset_img center ovh.png "Correctly setup A-type records in the OVH panel." %}
2. Check if your DNS record is set up correctly by launching `dig +noall +answer example.com` in terminal:
```sh
dig +noall +answer example.com
;example.com.
example.com.   3600  IN  A 185.199.108.153
example.com.   3600  IN  A 185.199.109.153
example.com.   3600  IN  A 185.199.110.153
example.com.   3600  IN  A 185.199.111.153
```
3. Remove custom domain from GitHub settings so it falls back to `USERNAME.github.io`. This is crucial.

4. Add the custom domain again. It seems to trigger some inner GitHub procedures that makes it aware of new configuration.

5. Check, if you can reach your page with the added custom domain over the HTTPS. It should work fine now.

6. Go back to GitHub and check "Enforce HTTPS for your domain" checkbox.

There you go! :)