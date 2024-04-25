---
layout: default
title: Time Zone Support
permalink: /faq/time-zone-support
---

# Time Zone Support

Starting from `v3.5.0`, the app keeps track of the time zone of the device for each expense. The app will use the time zone to display the date and time of the expense. The app will also use the time zone to calculate the total expenses for each day.

> For this reason, expenses that were added before `v3.5.0` won't gain the time zone support. The app will display the date and time of these expenses in the device's time zone regardless of the time zone of the device when the expense was added.

For example, if you are in New York and you add an expense on `2024-03-31 07:44 AM`, the app will display the expense as `2024-03-31 07:44 AM` in New York time. If you travel to London and you open the app, the app will display the expense as `2024-03-31 07:44 AM` with the time zone of New York (`America/New_York`).

The app will also show all the information (e.g., Stats, Trends, etc) given the time zone of the expenese if it's different from the device's time zone.

<img src="../../assets/faq/time-zone-support/time-zone.jpg" width="80%">

The app will show the time zone in the expense detail view when it's different from the device's time zone.

{% include faq_footer.html %}
