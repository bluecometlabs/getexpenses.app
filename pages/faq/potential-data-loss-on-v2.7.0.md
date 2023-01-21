---
layout: default
title: Potential data loss on v2.7.0
permalink: /faq/potential-data-loss
---

# Potential data loss on v2.7.0

We've found a potential data loss issue only when updating the app to v2.7.0 from earlier versions.

- [Solution](#solution)
- [Problem](#problem)

---

## Solution

If you don't any sheets that you had previously, you might be able to restore your data by removing broken new data store. Please follow the steps below:

> If you alread purchased Expenses Pro and your data is synced via iCloud, you can uninstall (make sure you removed all the files using [AppCleaner](https://freemacsoft.net/appcleaner/)) the app and reinstall it. Then, you can force fetch all data from iCloud.

1. Update Expenses to Version 2.7.9 or higher versions
2. Go to the app's settings and see if you can see "Restore" at the top
3. Go to "Restore"
3. Click "Restore" action (if it's disabled, please contact us with the screenshot) and restart the app

If you can't see it, please try the following steps on macOS:

Run the following command (if you use Setapp replace `com.pixyzehn.Expenses` with `com.pixyzehn.Expenses-setapp`) and restart the app

```sh
defaults write com.pixyzehn.Expenses showTroubleshootingMigrationIssueEnabled -bool true
```

If you don't have any backup, you might be able to restore the data from Time Machine local snapshots on macOS. See also [About Time Machine local snapshots on Mac](https://support.apple.com/guide/mac-help/about-time-machine-local-snapshots-mh35933/mac). We're sorry for the inconvenience. For more details and what we can do, please contact us via email.

*Updated on October 3, 2022*

---

## Problem

We needed to move our data store to accomplish some new features. On the data migration using [migratePersistentStore(_:to:options:type:)](https://developer.apple.com/documentation/coredata/nspersistentstorecoordinator/3747534-migratepersistentstore), we found something wrong with the migration process especially on macOS.

Old Store:
`~/Library/Containers/com.pixyzehn.Expenses/Data/Library/Application\ Support/Expenses/Expenses.sqlite`  
> If it's installed via Setapp: `~/Library/Containers/com.pixyzehn.Expenses-setapp/Data/Library/Application\ Support/Expenses/Expenses.sqlite`

↓

New Store:
`~/Library/Group\ Containers/group.com.pixyzehn.Expenses/Expenses.sqlite`

It seems that this could cause (or looked like) data loss for some users. In retrospect, we should have done the migration in a safe way. We'll add a safety check to prevent this issue in the future.

{% include faq_footer.html %}
