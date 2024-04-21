---
layout: default
title: CSV data
permalink: /faq/csv-data
---

# CSV data to import data

You can import your data from a CSV file. The CSV file should have the following columns:

- `Date`
- `Category`
- `Price`
- `Notes`

Example:

```
┏━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┓
┃    ┃ Date       ┃ Category    ┃ Price         ┃ Notes             ┃
┃    ┃ <String>   ┃ <String>    ┃ <Double>      ┃ <String>          ┃
┡━━━━╇━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━┩
│    │ 2024/03/31 │ Groceries   │      -1,000.0 │ Supermarket       │
│    │ 2024/03/30 │ Budget      │       2,500.0 │                   │
│    │ 2024/03/29 │ Transport   │        -300.0 │ Bus               │
...
```

{% include faq_footer.html %}
