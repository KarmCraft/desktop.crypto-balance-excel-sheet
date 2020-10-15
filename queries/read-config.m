let
    Path =
        Text.Combine(
            {
                GetCellValue("CONFIG_QUERYPATH"),
                "\config\config.json"
            }
        ),
    Source = Json.Document(Text.FromBinary(File.Contents(Path))),
    ConvertedToTable = Record.ToTable(Source),
    ExpandedValue =
        Table.ExpandRecordColumn(
            ConvertedToTable,
            "Value",
            {
                "Value",
                "Comment"
            },
            {
                "Value",
                "Comment"
            }
        ),
    Result =
        Table.RemoveColumns(
            ExpandedValue,
            {"Comment"}
        )
in
    Result