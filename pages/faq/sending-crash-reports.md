---
layout: default
title: Sending Crash Reports
permalink: /faq/sending-crash-reports
---

# Sending Crash Reports

If we can't find any crash reports, the best way would be to send us crash reports to identify the issue.

- [iOS/iPadOS](#iosipados)
- [macOS](#macos)

---

## iOS/iPadOS

1. Open the Analytics & Improvements section (in Settings > Privacy & Security) on the device. See [ Share analytics, diagnostics, and usage information with Apple](https://support.apple.com/en-us/HT202100){:target="_blank"}
2. Tap Analytics Data
3. Locate the log for Expenses. The log name starts with `Expenses_<DateTime>` for crash reports, or `JetsamEvent_<DateTime>` for high-memory use crashes
4. Select the desired log
5. Tap the Share icon, and select Mail to send the crash report as a mail attachment to [contact@bluecometlabs.com](mailto:contact@bluecometlabs.com)

## macOS

1. Open the Console app, from Applications > Utilities in Finder
2. Select Crash Reports
3. Locate crash reports for Expenses in the list. Logs are listed by your app’s binary name
4. Right-click the desired log’s file name
5. Select Reveal in Finder
6. Drag the file displayed in Finder to Mail to send the crash report as a mail attachment to [contact@bluecometlabs.com](mailto:contact@bluecometlabs.com)

For more detail, please refer to [Acquiring Crash Reports and Diagnostic Logs](https://developer.apple.com/documentation/xcode/acquiring-crash-reports-and-diagnostic-logs#locate-crash-reports-and-memory-logs-on-the-device){:target="_blank"}.

{% include faq_footer.html %}
