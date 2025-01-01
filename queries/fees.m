let
    BTCApiUrl = "https://bitcoiner.live/api/fees/estimates/latest",
    BTCSource = Json.Document(Web.Contents(BTCApiUrl)),
    BTCFeesRaw = BTCSource[estimates][30][sat_per_vbyte],
    #"Converted to Table" = #table(1, {{BTCFeesRaw}}),
    #"Added Custom" = Table.AddColumn(#"Converted to Table", "Name", each "BTC Fees s/vB"),
    #"Reordered Columns" = Table.ReorderColumns(#"Added Custom",{"Name", "Column1"}),
    BTCFees = Table.RenameColumns(#"Reordered Columns",{{"Column1", "Value"}}),

    ETHApiUrl =
        Text.Combine(
            {
                "https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=",
				GetCellValue("CONFIG_API_ETHGAS")
            }
        ),
    ETHSource = Json.Document(Web.Contents(ETHApiUrl)),
    ETHFeesRaw = ETHSource[result],
    #"Converted to Table1" = Record.ToTable(ETHFeesRaw),
    #"Filtered Rows" = Table.SelectRows(#"Converted to Table1", each [Name] = "ProposeGasPrice"),
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows","ProposeGasPrice","ETH Proposed (gwei)",Replacer.ReplaceText,{"Name"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Value",{{"Value", type number}}),
    ETHFees = Table.TransformColumns(#"Changed Type",{{"Value", each Number.Round(_, 2), type number}}),
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