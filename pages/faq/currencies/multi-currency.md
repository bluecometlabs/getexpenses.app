---
layout: default
title: Multi Currency
permalink: /faq/multi-currency
---

## Multi Currency

The app supports multiple currencies. This means you can add expenses/income in different currencies in **a single sheet**. The currency rates are usually updated every day. The supported currencies are listed in [the XML file](https://github.com/bluecometlabs/getexpenses.app/blob/main/eurofxref/eurofxref.xml){:target="_blank"}.

- [Example](#example)
- [How the conversion works](#how-the-conversion-works)

---

### Example

For example, you can add an expense in USD and another expense in EUR.

<img src="../../assets/faq/multi-currency/multi-currency-expenses-mac.jpg" width="40%">

In the above example, the sheet is in USD. The first expense (`-€12.00`) is in EUR, and the second expense (`-$20.00`) is in USD. The app will automatically convert the EUR expense to USD. The total amount (`-$34.25`) of the sheet is in USD.

Note that the last currency you selected will be used in the next expense/income.

### How the conversion works

When adding an expense/income in a different currency, you can choose either `Automatic` or `Manual (Fixed)`. If you choose `Automatic`, the app will automatically convert the amount to the sheet's currency based on the latest currency rates. If you choose `Manual (Fixed)`, the app will convert the amount using the specified currency rate. The default currency rate is the current one (Fixed). You can also set a custom currency rate as default so that you don't have to specify it every time.

{% include faq_footer.html %}
