page 55145 SalesRecordForCaseList
{
    ApplicationArea = All;
    SourceTable = SalesRecordForCase;
    Caption = 'SalesRecordForCaseList';
    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field("Sales Record No."; Rec."Sales Record No.")
                {
                    ApplicationArea = All;
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
