---
layout: default
title: Potential data loss on v2.7.0
permalink: /faq/potential-data-loss
---

# Potential data loss on v2.7.0

We've found a potential data loss issue only when updating the app to v2.7.0 from earlier versions. The data loss can happen only locally, so if you have any backup on iCloud using Expenses Pro, you can restore the data from the backup. If not, unfortunately, you may lose the data.

If you have any backup, please see the following steps to restore the data:

1. Reinstall the app as corrupted data may cause some issues

    > for Expenses macOS app, you can do clean install by using [AppCleaner](https://freemacsoft.net/appcleaner/). When deleting the app, please select all associated items to delete.

2. Try force fetch all data from iCloud via the Sync page

If you don't have any backup, unfortunately, there is no easy way for us to restore the data so far. On macOS, you might be able to restore the data from Time Machine local snapshots. See also [About Time Machine local snapshots on Mac](https://support.apple.com/guide/mac-help/about-time-machine-local-snapshots-mh35933/mac). We're sorry for the inconvenience. For more details and what we can do, please contact us via email.

## Problem

We needed to move our data store to accomplish some new features. On the data migration, we found that we tried to delete the old store even if the migration failed in some situations. It seems that this could cause data loss for some users. In retrospect, we should have done the migration in a safe way, such as keeping the old store (or any backup) until the migration is done successfully. We'll add a safety check to prevent this issue in the future.

{% include faq_footer.html %}
