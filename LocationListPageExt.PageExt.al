pageextension 55192 LocationListPageExt extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field("Return Name"; Rec."Return Name")
            {
                ApplicationArea = All;
            }
            field("Return Contact"; Rec."Return Contact")
            {
                ApplicationArea = All;
            }
        }
    }
    procedure GetLocationCode(): Text var
        Location: Record Location;
    begin
        Location.Reset();
        CurrPage.SetSelectionFilter(Location);
        if Location.FindFirst()then exit(Location.Code);
    end;
    procedure ApplyFilter()
    var
    begin
    end;
}
