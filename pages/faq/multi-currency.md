---
layout: default
title: Multi currency
permalink: /faq/multi-currency
---

# Multi currency

The app supports multiple currencies. This means you can add expenses/income in different currencies in **a single sheet**. The currency rates are usually updated every day. The supported currencies are listed in [the XML file](https://github.com/pixyzehn/getexpenses.app/blob/main/eurofxref/eurofxref.xml).

- [Example](#example)
- [How the conversion works](#how-the-conversion-works)

---

## Example

For example, you can add an expense in USD and another expense in EUR.

<img src="../../assets/faq/multi-currency/multi-currency-expenses-mac.jpg" width="40%">

In the above example, the sheet is in USD. The first expense (`-€12.00`) is in EUR, and the second expense (`-$20.00`) is in USD. The app will automatically convert the EUR expense to USD. The total amount (`-$34.25`) of the sheet is in USD.

## How the conversion works

When adding an expense/income in a different currency, you can choose either `Automatic Updates` or not. If you choose `Automatic Updates`, the app will automatically convert the amount to the sheet's currency based on the latest currency rates. If you choose not, the app will convert the amount using the currency rate at the time you added the expense/income.

{% include faq_footer.html %}