---
layout: default
title: CSV data
permalink: /faq/import-csv-data
---

# Import CSV data

> Note: Import your data from a CSV file is available on version 3.4.16 and later.  
> It's also only available on iOS 16.0/macOS 13.0 and later.

You can import your data from a CSV file. The CSV file should have the following columns:

- `Date` (String) [yyyy-MM-dd]
- `Category` (String)
- `Price` (Double) [`-`: expense, `+`: income]
- `Notes` (String)

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