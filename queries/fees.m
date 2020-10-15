let
    BTCApiurl = "https://bitcoinfees.earn.com/api/v1/fees/recommended",
    BTCSource = Json.Document(Web.Contents(BTCApiurl)),
    BTCConvertedToTable = Record.ToTable(BTCSource),
    BTCReplacedFast =
        Table.ReplaceValue(
            BTCConvertedToTable,
            "fastestFee",
            "BTC Fast",
            Replacer.ReplaceText,
            {"Name"}
        ),
    BTCReplacedAverage =
        Table.ReplaceValue(
            BTCReplacedFast,
            "halfHourFee",
            "BTC Average",
            Replacer.ReplaceText,
            {"Name"}
        ),
    BTCFees =
        Table.ReplaceValue(
            BTCReplacedAverage,
            "hourFee",
            "BTC Slow",
            Replacer.ReplaceText,
            {"Name"}
        ),
    ETHApiUrl =
        Text.Combine(
            {
                "https://data-api.defipulse.com/api/v1/egs/api/ethgasAPI.json?api-key=",
                GetCellValue("CONFIG_API_ETHGAS")
            }
        ),
    ETHSource = Json.Document(Web.Contents(ETHApiUrl)),
    ConvertedToTable = Record.ToTable(ETHSource),
    ReplacedFast =
        Table.ReplaceValue(
            ConvertedToTable,
            "fast",
            "ETH Fast",
            Replacer.ReplaceValue,
            {"Name"}
        ),
    ReplacedSlow =
        Table.ReplaceValue(
            ReplacedFast,
            "safeLow",
            "ETH Slow",
            Replacer.ReplaceValue,
            {"Name"}
        ),
    ReplacedAverage =
        Table.ReplaceValue(
            ReplacedSlow,
            "average",
            "ETH Average",
            Replacer.ReplaceValue,
            {"Name"}
        ),
    ETHFees =
        Table.SelectRows(
            ReplacedAverage,
            each
                [Name]
                = "ETH Fast"
                or [Name]
                = "ETH Average"
                or [Name]
                = "ETH Slow"
        ),
    Fees =
        Table.Combine(
            {
                BTCFees,
                ETHFees
            }
        ),
    Result =
        Table.Sort(
            Fees,
            {
                {
                    "Name",
                    Order.Ascending
                }
            }
        )
in
    Result