page 55187 CSStatusList
{
    PageType = List;
    SourceTable = CSStatus;
    UsageCategory = Lists;
    caption = 'CS Status List';
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
        CSStatus: Record CSStatus;
        var1: Integer;
    begin
        CSStatus.Reset();
        if CSStatus.FindSet()then var1:=1
        else
        begin
            CSStatus.Init();
            CSStatus.Code:='New';
            CSStatus.Description:='New';
            CSStatus.Insert();
            CSStatus.Init();
            CSStatus.Code:='Under Review';
            CSStatus.Description:='Under Review';
            CSStatus.Insert();
            CSStatus.Init();
            CSStatus.Code:='Waiting On Client';
            CSStatus.Description:='Waiting On Client';
            CSStatus.Insert();
            CSStatus.Init();
            CSStatus.Code:='Complete';
            CSStatus.Description:='Complete';
            CSStatus.Insert();
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
