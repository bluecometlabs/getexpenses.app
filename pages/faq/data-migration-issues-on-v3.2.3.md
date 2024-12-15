---
layout: default
title: Data migration issues on v3.2.3
permalink: /faq/data-migration-issues
---

# Data migration issues on v3.2.3

We've found data migration issues after updating the app to v3.2.3 from earlier versions. That was caused by introducing new sheet settings.

- [Solution](#solution)
- [Problem](#problem)

---

## Solution

Please check the following steps to see if you can restore your data:

- Update the app to v3.2.5 or higher versions
- Force-fetching all data from iCloud. See also [Troubleshooting iCloud Sync](/faq/troubleshooting-icloud-sync)

If you haven't enabled iCloud Sync, please contact us via email. We'll do our best to find a way to restore your data.

---

## Problem

Since the potential cause was pretty complicated from a technical perspective, we couldn't find a way to fix it reliably in the upcoming versions. We'll rollback all the features introduced in v3.2.3 (and v3.2.4) and disable these versions on App Store later on.

Due to the rollback, you might see that all sheets are moved into the "Sheets" section. For now, this is an expected behavior. Please force-fetch all data from iCloud or move them back to the original places manually by archiving, moving to trash, and pinning.

Sorry for the inconvenience. We'll do our best to prevent this kind of issue in the future.
