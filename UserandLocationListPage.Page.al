page 55104 UserandLocationListPage
{
    ApplicationArea = All;
    SourceTable = UserandLocation;
    PageType = List;
    Caption = 'User and Location';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    Caption = 'Location';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        Rec.Reset();
        Rec.SetCurrentKey("User ID");
        Rec.Ascending(true);
        if Filter <> '' then begin
            Rec.FilterGroup(11);
            Rec.SetRange(Location, Filter);
            Rec.FilterGroup(0);
        end;
    end;
    procedure ProduceUserID(): Text var
        UserandLocation: Record UserandLocation;
    begin
        UserandLocation.Reset();
        CurrPage.SetSelectionFilter(UserandLocation);
        if UserandLocation.FindFirst()then exit(UserandLocation."User ID")end;
    procedure GetFilter(var1: Text)
    var
    begin
        Filter:=var1;
    end;
    var Filter: Text;
}
