# Crypto Balance Excel Sheet

If you're anything like me then you have several cryptocurrenties and altcoins organized in different wallets scattered around on dozens of addresses and multiple exchanges. To keep track of it all can be a dauntig task. I was and still am unhappy with most of the available wallet and balance apps, this is why I felt that I could create a simple to use but powerful Excel workbook to keep track of all my cryptos and their value in Fiat. Also, privacy is a big concern and I didn't want any service to know about my balances. When used correctly this Excel sheet allows to keep track of all *public* addresses and regain the overview over your crypto-empire.

## Features

- Simple to use and configure for normal excel users. Advanced Excel users will have no issues.
- The easiest overview of your crypto holdings, broken down to the single public address. No more guesswork.
- Pretty much absolute privacy. Your own API Keys. No need to enter values in apps that gather your informations.
- Calculates holdings in BTC and any Fiat (default USD & EUR) per wallet.
- Calculates total holdings of all wallets in BTC and any Fiat (default USD & EUR).
- Enter symbol, public address and balance - the rest is calculated automagically - et voilà!
- Support for any cryptocurrency (listed on coinmarketcap.com).
- Support for multiple wallets containing multiple addresses.
- Support for any available block explorer and direct navigation to entered address (customnizable).
- Periodically updates values from several APIs for all cryptocurrencies, Fiat currencies and fees/gas for BTC and ETH.
- Calculates your specific sums of the main cryptocurrencies.
- Automatic dominance calculation in a cool pie chart.
- **No VBA or Macros**! All queries are written in [Power Query M](https://docs.microsoft.com/en-us/powerquery-m/).
- Semantic versioning makes it easy keep your portfolio up-to-date with this project.

![Crypto Balance Excel Sheet Example](/images/crypto-balance-excel-sheet-example.png)

## Getting Started

### Prerequisites

- MS Office Excel is needed as any other Excel implementation does not support queries written in Power Query M.
- Clone/Download this repository to a local folder on your computer.

### Configuration

- To take full advantage of all the features, open the file */config/config.json* with your favorite text editor and enter the required .information.
- You will find further instructions, such as your Fiat currency and needed API Keys in the comments of each configuration item.

:information_source: Any API key required comes from a provider with a reputable source and where the free plan is enough. You may be required to register with a username/email though.

:information_source: The API Keys are optional. If you do not use them advanced features as conversion to BTC, 2nd Fiat and fee calculation will not work. I suggest to at least configure the CoinMarketCap API Key.

### Using the sheet

- Start the workbook *Queries.xlsx* and leave it open. Confirm possible messages from Excel. You can minimize it after that, it will do its thing and update the queries periodically.
- Start the workbook *Portfolio.xlsx*. Enter your holdings by filling out the tables. For details have a look at the examples in it and replace the fields in column A troguh E with your own values. You can replace with your own values. Delete unneeded wallet tables or add more by duplicating them.
- You can add several addresses of the same cryptocurrency, in fact you should add **all** of them :smile:

:bulb: Add more rows to the tables by selecting a cell in the table and pressing <kbd>CTRL</kbd> + <kbd>+</kbd>

:bulb: To add a new table select everything in an existing table, copy and paste in the row before the totals table.

:information_source: ETH ERC20 Tokens: To add an ERC20 Token add the prefix "ERC20" in the NAME column.

:information_source: The basic features will work even if you do not set up your API Keys, but the most useful functions will be disabled and the respective columns will stay empty.

:warning: Only fill in the columns WALLET, NAME, SYM, ADDRESS by hand (**A** to **D**), the rest will be calculated automatically and pulled in from *Queries.xlsx*.

### Security Messages

During first time startup and when you update your API keys information a popup regarding privacy levels may be shown. You can either confirm the desired privacy level or click the checkbox *Ignore Privacy Levels checks for this file.*
![Privacy Levels checks message](/images/ignore-privacy-levels-check.png)

Another popup that can appear is the Access Web content message. Just confirm this as well.
![Access WEb content message](/images/access-web-content-check.png)

Learn more about [Privacy Levels](https://support.microsoft.com/en-us/office/privacy-levels-power-query-cc3ede4d-359e-4b28-bc72-9bee7900b540)

## Updates & Versioning

An important question is how to handle the situation when there are updates to this repository or the queries.
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

To allow backwards compatibility and ease of use the workbook has been splitted in two separate workbooks.

*Queries.xlsx* performs all the heavy logic operations, loads queries from files and connects to various web services in the background. I expect updates to mainly affect this workbook. In the spirit of an open source project, the M queries have been written as clear text files so they can be easiliy versioned.

The second workbook, *Portfolio.xlsx* is a dedicated spreadsheet where you enter your crypto holdings. This means that you will be able to copy and paste your *Portfolio.xlsx* into any newer version of this repo as long as there is no *major* version update (i.e. The first number in the version stays the same) and everything should just work fine.

:information_source: This is especially important if you have a long list of addresses in your *Portfolio.xlsx* and removes much of the pain of an update.

## Troubleshooting

- Tested on MS Excel 2019 Professional Plus - ENG
- Dependendig on your regional settings in Windows you may be required to change some settings either on your system or in Excel.
  - The 1000 Separator used is " ' "
  - The formula expression separator used is " ; "

:bulb: Learn how to change the formula separator [in this article](https://www.excel-exercise.com/comma-or-semicolon-in-excel-formula/)

:information_source: If you find a bug, please report it [here](https://github.com/KarmCraft/crypto-balance-excel-sheet/issues)

## Donations are appreciated, buy me a :coffee:

- BTC: [bc1q27vkxgcwg3ryswc6p6kavdlp97zhegq6se9s5r](https://blockchair.com/bitcoin/address/bc1q27vkxgcwg3ryswc6p6kavdlp97zhegq6se9s5r)
- ETH: [0xB9Ce62394f3406d7F86B240212daCBbd4d452329](https://etherscan.io/address/0xB9Ce62394f3406d7F86B240212daCBbd4d452329)
- LTC: [ltc1q6q07s6ye0y34d7fdlu3nqjd4fnak8zwnrt8fev](https://chainz.cryptoid.info/ltc/address.dws?MK1HBhXE7AEmf9oLjWWuLCUPP7sgn5Pq9d.htm)
- BCH: [qz2hnx84eht4cphm6nt9al743q3w5tr8g58llc2w8s](https://blockchair.com/bitcoin-cash/address/3Ax4XaV7o8dDFtGBCWpfQuDfCttXerfiJR)
- API Keys: If you feel like sponsoring or sharing an API key from a paid subscription plan, I will consider adding it as a default in the config files.
