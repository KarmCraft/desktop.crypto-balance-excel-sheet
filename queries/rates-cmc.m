let
    ApiKey = GetCellValue("CONFIG_API_CMC"),
    ApiUrl =
        Text.Combine(
            {
                "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=",
                ApiKey,
                "&limit=3500"
            }
        ),
    Source =
        if ApiKey = "" then
            Json.Document(
                "{
                    ""status"": {
                        ""timestamp"": ""2020-01-01T00:00:00.000Z"",
                        ""error_code"": 0,
                        ""error_message"": null,
                        ""elapsed"": 0,
                        ""credit_count"": 0,
                        ""notice"": null,
                        ""total_count"": 0
                    },
                    ""data"": [
                        {
                            ""id"": 1,
                            ""name"": ""Bitcoin"",
                            ""symbol"": ""BTC"",
                            ""slug"": ""bitcoin"",
                            ""num_market_pairs"": 0,
                            ""date_added"": ""2013-04-28T00:00:00.000Z"",
                            ""tags"": [
                                ""mineable"",
                                ""pow"",
                                ""sha-256"",
                                ""store-of-value"",
                                ""state-channels""
                            ],
                            ""max_supply"": 21000000,
                            ""circulating_supply"": 18517281,
                            ""total_supply"": 18517281,
                            ""platform"": null,
                            ""cmc_rank"": 1,
                            ""last_updated"": ""2020-10-14T22:28:23.000Z"",
                            ""quote"": {
                                ""USD"": {
                                    ""price"": 1.0,
                                    ""volume_24h"": 0,
                                    ""percent_change_1h"": 0,
                                    ""percent_change_24h"": 0,
                                    ""percent_change_7d"": 0,
                                    ""market_cap"": 0,
                                    ""last_updated"": ""2020-01-00T00:00:00.000Z""
                                }
                            }
                        }
                    ]
                }"
            )
        else
            Json.Document(Web.Contents(ApiUrl)),
    ConvertedToTable = Record.ToTable(Source),
    Value = ConvertedToTable{1}[Value],
    ConvertedToTable1 =
        Table.FromList(
            Value,
            Splitter.SplitByNothing(),
            null,
            null,
            ExtraValues.Error
        ),
    ExpandedColumn1 =
        Table.ExpandRecordColumn(
            ConvertedToTable1,
            "Column1",
            {
                "id",
                "name",
                "symbol",
                "slug",
                "num_market_pairs",
                "date_added",
                "tags",
                "max_supply",
                "circulating_supply",
                "total_supply",
                "platform",
                "cmc_rank",
                "last_updated",
                "quote"
            },
            {
                "cmc.id",
                "cmc.name",
                "cmc.symbol",
                "cmc.slug",
                "cmc.num_market_pairs",
                "cmc.date_added",
                "cmc.tags",
                "cmc.max_supply",
                "cmc.circulating_supply",
                "cmc.total_supply",
                "cmc.platform",
                "cmc.cmc_rank",
                "cmc.last_updated",
                "cmc.quote"
            }
        ),
    ExpandedCmcQuote =
        Table.ExpandRecordColumn(
            ExpandedColumn1,
            "cmc.quote",
            {"USD"},
            {"cmc.quote.USD"}
        ),
    Result =
        Table.ExpandRecordColumn(
            ExpandedCmcQuote,
            "cmc.quote.USD",
            {
                "price",
                "volume_24h",
                "percent_change_1h",
                "percent_change_24h",
                "percent_change_7d",
                "market_cap",
                "last_updated"
            },
            {
                "cmc.quote.USD.price",
                "cmc.quote.USD.volume_24h",
                "cmc.quote.USD.percent_change_1h",
                "cmc.quote.USD.percent_change_24h",
                "cmc.quote.USD.percent_change_7d",
                "cmc.quote.USD.market_cap",
                "cmc.quote.USD.last_updated"
            }
        )
in
    Result