---
title: "Jekyll Site Statistics"
last_modified_at: 2021-01-24T21:12:02+01:00
excerpt: "Here is my short analysis of the different trackers that are mentioned in the plugin hendrikschneider/jekyll-analytics"
categories:
  - Blog
  - Tech
tags:
  - Jekyll
  - Tracking
  - Statistics
---

There is a [plugin for Jekyll](https://github.com/hendrikschneider/jekyll-analytics) made by `hendrikschneider` that allows usage statistics for your Jekyll site. I want to have some sort of statistics regarding usage of my blog, but I also care about your privacy. Here is my short analysis of the different trackers that are mentioned in the plugin.

My tracking requirements:

- Free
- Privacy focused
- Negligable performance hit
- Preferrably without cookies

## GoogleAnalytics
Not gonna happen.

## Matomo
[Matomo](https://matomo.org), formerly Piwik, say they are a Google Analytics alternative "that protects your data and your customers' privacy". Seems promising, but I'll look into that. Self hosted service is free and the Cloud version is about $30/month up to 50k pageviews. Matomo does also support cookie-less usage, but is not configured that way by default.

## MPulse

[MPulse]() seems to be more focused on APM rather than usage statistics. Of course, usage statistics included in APM, but performance shouldn't be an issue on this lightweight page, and adding APM would probably affect performance more than it would help by understanding the performance.

## Plausible

[Plausible](https://plausible.io) is also a "simple and privacy-friendly alternative to Google Analytics". It does not use cookies, which from my perspective is a huge plus. As Matomo, Plausible is not free either, but is at a lower cost, at $6/month up to 10k views.

## Conclusion

The tracker that fits best with my needs is self-hosted Matomo. It will require some manual configuration to disable cookies, but that is fine. Since it's not cloud, I will also have to maintain the server and database myself.
