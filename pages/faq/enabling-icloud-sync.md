---
layout: default
title: Enabling iCloud Sync
permalink: /faq/enabling-icloud-sync
---

# Enabling iCloud Sync

We rely on iCloud to sync data. If the iCloud Sync option is disabled in the app, it means the app can't access your iCloud account on your device for some reason (Technically, we're checking if your iCloud account is available via [CKAccountStatus](https://developer.apple.com/documentation/cloudkit/ckaccountstatus)). To enable it, please check the following.

**iOS/iPadOS**

1. Go to `Settings (System)` → `Apple ID` → `iCloud` and make sure that you check `Expenses`
2. Relaunch the app to properly reflect the change
3. See the iCloud Sync is now enabled

**macOS**

1. Go to `System Preferences (System)` → `Apple ID` → `iCloud Drive (Documents)` and make sure that you check `Expenses`
2. Relaunch the app to properly reflect the change
3. See the iCloud Sync is now enabled

If it still doesn't work, please check the following:
- [Sign out of iCloud on your device](https://support.apple.com/en-us/HT208242) and sign in to iCloud again
- See if there is any error or warning on your iCloud account
- Check if parental controls, device management, or incomplete setup for two-factor authentication might deny access to iCloud account credentials
- Restart your device or reinstall the app

{% include faq_footer.html %}