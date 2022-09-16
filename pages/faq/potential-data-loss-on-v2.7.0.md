---
layout: default
title: Potential data loss on v2.7.0
permalink: /faq/potential-data-loss
---

# Potential data loss on v2.7.0

**Update 2022-09-14**

If you don't any sheets that you had previously on macOS, you might be able to restore your data by removing a broken new data store. Please follow the steps below:

1. Go to Terminal.app on your macOS
2. Run the following command (Note: Replace [your user name] with your user name)

    ```sh
    rm -rf /Users/[your user name]/Library/Group\ Containers/group.com.pixyzehn.Expenses/Expenses.sqlite
    ```

3. Restart Expenses.app (so that the app creates a new data store based on the previous data store)
4. Check if your data is restored

---

We've found a potential data loss issue only when updating the app to v2.7.0 from earlier versions. The data loss can happen only locally, so if you have any backup on iCloud using Expenses Pro, you can restore the data from the backup. If not, unfortunately, you may lose the data.

If you have any backup, please see the following steps to restore the data:

1. Reinstall the app as corrupted data may cause some issues

    > for Expenses macOS app, you can do clean install by using [AppCleaner](https://freemacsoft.net/appcleaner/). When deleting the app, please select all associated items to delete.

2. Try force fetch all data from iCloud via the Sync page

If you don't have any backup, you might be able to restore the data from Time Machine local snapshots on macOS. See also [About Time Machine local snapshots on Mac](https://support.apple.com/guide/mac-help/about-time-machine-local-snapshots-mh35933/mac). We're sorry for the inconvenience. For more details and what we can do, please contact us via email.

## Problem

We needed to move our data store to accomplish some new features. On the data migration, we found that we tried to delete the old store even if the migration failed in some situations or the migration was not completed for some reason. It seems this can happen especially on macOS.

Old Store:
`/Users/[your user name]/Library/Containers/com.pixyzehn.Expenses/Data/Library/Application\ Support/Expenses/Expenses.sqlite`  
(If it's installed via Setapp: `/Users/[your user name]/Library/Containers/com.pixyzehn.Expenses-setapp/Data/Library/Application\ Support/Expenses/Expenses.sqlite`)

↓

New Store:
`/Users/[your user name]/Library/Group\ Containers/group.com.pixyzehn.Expenses/Expenses.sqlite`

It seems that this could cause (or looked like) data loss for some users. In retrospect, we should have done the migration in a safe way. We'll add a safety check to prevent this issue in the future.

{% include faq_footer.html %}
