pageextension 55193 PickWorksheetPageExt extends "Pick Worksheet"
{
    layout
    {
        addafter("Destination No.")
        {
            field("Shortcut Dimension 3"; Rec."Shortcut Dimension 3")
            {
                ApplicationArea = All;
                CaptionClass = CaptionVar;

                trigger OnLookup(var Text: Text): Boolean var
                    GLSetup: Record "General Ledger Setup";
                    DimensionValue: Record "Dimension Value";
                    DimensionValueList: Page "Dimension Values";
                    var1: Text;
                begin
                    DimensionValueList.LookupMode(true);
                    GLSetup.Reset();
                    if GLSetup.FindFirst()then var1:=GLSetup."Shortcut Dimension 3 Code";
                    DimensionValueList.GetValues(var1);
                    if DimensionValueList.RunModal() = Action::LookupOK then begin
                        if Rec."Shortcut Dimension 3" <> DimensionValueList.ProduceValues()then begin
                            Rec."Shortcut Dimension 3":=DimensionValueList.ProduceValues();
                            Rec.Modify();
                        end;
                    end;
                end;
            }
        }
        addafter(CurrentSortingMethod)
        {
            field(ShortcutDimension3; ShortcutDimension3)
            {
                ApplicationArea = All;
                CaptionClass = CaptionVar;

                trigger OnValidate()
                var
                    DimensionValue: Record "Dimension Value";
                    GLSetup: Record "General Ledger Setup";
                    var1: Text;
                begin
                    GLSetup.Reset();
                    if GLSetup.FindFirst()then var1:=GLSetup."Shortcut Dimension 3 Code";
                    DimensionValue.Reset();
                    DimensionValue.SetFilter("Dimension Code", var1);
                    DimensionValue.SetFilter(Code, ShortcutDimension3);
                    if DimensionValue.FindFirst()then exit
                    else
                        Error('Has to be a vlaid dimension value for the %1', CaptionVar);
                    Rec.Reset();
                    Rec.SetFilter(Name, CurrentWkshName);
                    Rec.SetFilter("Location Code", CurrentLocationCode);
                    Rec.SetFilter("Shortcut Dimension 3", ShortcutDimension3);
                    if CurrentSortingMethod = CurrentSortingMethod::None then exit;
                    if CurrentSortingMethod = CurrentSortingMethod::Item then begin
                        Rec.SetCurrentKey("Item No.");
                        Rec.Ascending(true);
                    end;
                    if CurrentSortingMethod = CurrentSortingMethod::Document then begin
                        Rec.SetCurrentKey("Whse. Document No.");
                        Rec.Ascending(true);
                    end;
                    if CurrentSortingMethod = CurrentSortingMethod::"Due Date" then begin
                        Rec.SetCurrentKey("Due Date");
                        Rec.Ascending(true);
                    end;
                    if CurrentSortingMethod = CurrentSortingMethod::"Shelf or Bin" then begin
                        Rec.SetCurrentKey("Shelf No.");
                        Rec.Ascending(true);
                    end;
                    CurrPage.Update(false);
                end;
                trigger OnLookup(var Text: Text): Boolean var
                    DimensionValuesListPage: Page "Dimension Values";
                    GLSetup: Record "General Ledger Setup";
                    var1: Text;
                begin
                    DimensionValuesListPage.LookupMode(true);
                    GLSetup.Reset();
                    if GLSetup.FindFirst()then var1:=GLSetup."Shortcut Dimension 3 Code";
                    DimensionValuesListPage.GetValues(var1);
                    if DimensionValuesListPage.RunModal() = Action::LookupOK then begin
                        ShortcutDimension3:=DimensionValuesListPage.ProduceValues();
                        Rec.Reset();
                        Rec.SetFilter(Name, CurrentWkshName);
                        Rec.SetFilter("Location Code", CurrentLocationCode);
                        Rec.SetFilter("Shortcut Dimension 3", ShortcutDimension3);
                        if CurrentSortingMethod = CurrentSortingMethod::None then exit;
                        if CurrentSortingMethod = CurrentSortingMethod::Item then begin
                            Rec.SetCurrentKey("Item No.");
                            Rec.Ascending(true);
                        end;
                        if CurrentSortingMethod = CurrentSortingMethod::"Shelf or Bin" then begin
                            Rec.SetCurrentKey("Shelf No.");
                            Rec.Ascending(true);
                        end;
                        if CurrentSortingMethod = CurrentSortingMethod::"Due Date" then begin
                            Rec.SetCurrentKey("Due Date");
                            Rec.Ascending(true);
                        end;
                        if CurrentSortingMethod = CurrentSortingMethod::Document then begin
                            Rec.SetCurrentKey("Whse. Document No.");
                            Rec.Ascending(true);
                        end;
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
        modify(CurrentLocationCode)
        {
            trigger OnAfterValidate()
            var
            begin
                Rec.Reset();
                Rec.SetFilter(Name, CurrentWkshName);
                Rec.SetFilter("Location Code", CurrentLocationCode);
                Rec.SetFilter("Shortcut Dimension 3", ShortcutDimension3);
                CurrPage.Update(false);
            end;
        }
    }
    var CaptionVar: Text;
    ShortcutDimension3: Text;
    trigger OnOpenPage()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Reset();
        if GLSetup.FindFirst()then CaptionVar:=GLSetup."Shortcut Dimension 3 Code" + ' Dimension';
    end;
    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        Item.Reset();
        Item.SetRange("No.", Rec."Item No.");
        if Item.FindFirst()then begin
            if Rec."Shortcut Dimension 3" <> Item."Product Line Dimension" then begin
                Rec."Shortcut Dimension 3":=Item."Product Line Dimension";
                Rec.Modify();
            end;
        end;
    end;
}
