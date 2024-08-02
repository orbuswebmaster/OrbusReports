pageextension 55195 DimensionValueListPageExt extends "Dimension Values"
{
    var ShortcutDim: Text;
    trigger OnOpenPage()
    var
    begin
        if ShortcutDim = '' then exit
        else
        begin
            Rec.Reset();
            Rec.FilterGroup(11);
            Rec.SetFilter("Dimension Code", ShortcutDim);
            Rec.FilterGroup(0);
        end;
    end;
    procedure GetValues(var1: Text)
    var
    begin
        ShortcutDim:=var1;
    end;
    procedure ProduceValues(): Text var
        DimensionValue: Record "Dimension Value";
    begin
        DimensionValue.Reset();
        CurrPage.SetSelectionFilter(DimensionValue);
        if DimensionValue.FindFirst()then exit(DimensionValue.Code);
    end;
}
