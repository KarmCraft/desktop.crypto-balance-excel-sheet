let
    ApiKey = GetCellValue("CONFIG_API_FIAT"),
    ApiUrl =
        Text.Combine(
            {
                "https://openexchangerates.org/api/latest.json?app_id=",
                ApiKey
            }
        ),
    Source =
        if ApiKey = "" then
            Json.Document("{""rates"":{""USD"":1}}")
        else
            Json.Document(Web.Contents(ApiUrl)),
    FiatRates = Source[rates],
    Result = Record.ToTable(FiatRates)
in
    Result