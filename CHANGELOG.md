# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0]

### Several updates to make the Portofolio work in 2025

- Simplified Fees API Query.
- Adopting ETH proposed Fees as default.
- Changed ETH Fee provider to etherscan, you will have to crete new API Key.
- Increased CoinMarketCap query count to 3500 because there .are way more tokens now. **Careful if you're on the free API plan, more API points are consumed from your mothly allocation**.
- Added a second, configurable FIAT value. Just Add another column before "EXPLORER" and fill with the Formula `=@FIAT_2_RATE`
- New Explorers such as TFUEL, ALIAS, VTC, RVN, LTC, BNB, SOL

## [1.0.0]

- Initial release to public
