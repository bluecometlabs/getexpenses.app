---
layout: default
title: Import CSV Data
permalink: /faq/import-csv-data
---

# Import CSV Data

> Note: Import your data from a CSV file is available on version 3.5.0 and later.  
> It's also only available on iOS 16.0/macOS 13.0 and later.

You can import your data from a CSV file. The CSV file should have the following columns:

- `Date` (String)  
`yyyy-MM-dd`, `yyyy-MM-dd HH:mm`, `yyyy-MM-dd HH:mm:ss`, `yyyy-MM-dd HH:mm:ssZ`, or `yyyy-MM-dd'T'HH:mm:ssZ` format.

- `Category` (String)  
If not found, it will be default to `No Category` or the first category you have in the app.

- `Price` (Double)  
`-`: expense, `+`: income. If you need to use `,` as a decimal separator, you need wrap the value with double quotes like `"-12,34"`.

- `Notes` (String)  
The default value is an empty string.

Example:

```
Date,Category,Price,Notes
2024-03-31,Groceries,-1000.0,Supermarket
2024-03-30,Budget,2500.0,,
2024-03-29,Transport,-300.0,Bus
...
```

```
┏━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┓
┃    ┃ Date       ┃ Category    ┃ Price         ┃ Notes             ┃
┡━━━━╇━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━┩
│    │ 2024-03-31 │ Groceries   │      -1,000.0 │ Supermarket       │
│    │ 2024-03-30 │ Budget      │       2,500.0 │                   │
│    │ 2024-03-29 │ Transport   │        -300.0 │ Bus               │
...
```

{% include faq_footer.html %}
