page 55178 PriorityList
{
    PageType = List;
    SourceTable = Priority;
    UsageCategory = Lists;
    Caption = 'Priority List';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        Priority: Record Priority;
        var1: Integer;
    begin
        Priority.Reset();
        if Priority.FindSet()then var1:=1
        else
        begin
            Priority.Init();
            Priority.Code:='Same Day';
            Priority.Description:='Same Day';
            Priority.Insert();
            Priority.Init();
            Priority.Code:='Rush';
            Priority.Description:='Rush';
            Priority.Insert();
            Priority.Init();
            Priority.Code:='Standard';
            Priority.Description:='Standard';
            Priority.Insert();
        end;
    end;
    procedure ProduceValues(): Text var
        Priority: Record Priority;
    begin
        Priority.Reset();
        CurrPage.SetSelectionFilter(Priority);
        if Priority.FindFirst()then exit(Priority.Code);
    end;
}
