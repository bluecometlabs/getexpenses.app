---
layout: default
title: Contact
permalink: /contact/
---

<script>
function updateTime() {
    const now = new Date();
    // Get the current time in milliseconds since the Unix Epoch
    const utcTime = now.getTime() + (now.getTimezoneOffset() * 60000);
    // Adjust for UTC+9
    const timeZoneOffset = 9 * 60 * 60000; // 9 hours in milliseconds
    const localTime = new Date(utcTime + timeZoneOffset);
    // Format the time as HH:MM
    const hours = String(localTime.getHours()).padStart(2, '0');
    const minutes = String(localTime.getMinutes()).padStart(2, '0');
    // Display the time
    document.getElementById('currentTime').textContent = `${hours}:${minutes}`;
}
// Update the time every second
setInterval(updateTime, 1000);
</script>

## Contact

Any feedback and suggestions are welcome. We will read every tweet and email. We typically respond within one to two days, depending on the time zone difference. If you have a question, please check the [FAQ](/faq/) before you contact us.

Our time zone is UTC+9, where it's currently <strong><span id="currentTime"></span></strong>.

- [contact@bluecometlabs.com](mailto:contact@bluecometlabs.com) for feedback, suggestions, and bug reports
- [@expensesapp]({{ site.links.twitter }}){:target="_blank"} on X
- [@expenses]({{ site.links.mastodon }}){:target="_blank"} on Mastodon
