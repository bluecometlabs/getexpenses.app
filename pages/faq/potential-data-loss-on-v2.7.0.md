---
layout: default
title: Potential data loss on v2.7.0
permalink: /faq/potential-data-loss
---

# Potential data loss on v2.7.0

## Solution

If you don't any sheets that you had previously on macOS, you might be able to restore your data by removing a broken new data store. Please follow the steps below:

1. Go to Terminal.app on your macOS
2. Run the following command (if you use Setapp replace ` com.pixyzehn.Expenses` with ` com.pixyzehn.Expenses-setapp`)

    ```sh
    defaults write com.pixyzehn.Expenses showTroubleshootingMigrationIssueEnabled -bool true
    ```

3. Restart Expenses.app
4. Go to Preferences > Troubleshooting Migration Issue
5. Click "Retry Migration" (if it's disabled, please contact us with the screenshot)

*Updated on 2022-09-18*

---

## Context

We've found a potential data loss issue only when updating the app to v2.7.0 from earlier versions. The data loss can happen only locally, so if you have any backup on iCloud using Expenses Pro, you can restore the data from the backup. If not, unfortunately, you may lose the data.

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
