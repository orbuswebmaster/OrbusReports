pageextension 55151 SalesLineListPageExt extends "Sales Lines"
{
    layout
    {
        addafter("Ava Taxable Amount")
        {
            field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
            {
                ApplicationArea = All;
                Caption = 'Prepayment Line Amount';
            }
            field("Assigned User ID"; Rec."Assigned User ID")
            {
                ApplicationArea = All;
                Caption = 'Assigned User ID';
            }
        }
        /*addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 3 (Value)"; Rec."Shortcut Dimension 3 (Value)")
            {
                ApplicationArea = All;
                CaptionClass = ShortcutDimension3;
            }
            field("Shortcut Dimension 4 (Value)"; Rec."Shortcut Dimension 4 (Value)")
            {
                ApplicationArea = All;
                CaptionClass = ShortcutDimension4;
            }
            field("Shortcut Dimension 5 (Value)"; Rec."Shortcut Dimension 5 (Value)")
            {
                ApplicationArea = All;
                CaptionClass = ShortcutDimension5;
            }
            field("Shortcut Dimension 6 (Value)"; Rec."Shortcut Dimension 6 (Value)")
            {
                ApplicationArea = All;
                CaptionClass = ShortcutDimension6;
            }
            field("Shortcut Dimension 7 (Value)"; Rec."Shortcut Dimension 7 (Value)")
            {
                ApplicationArea = All;
                CaptionClass = ShortcutDimension7;
            }
            field("Shortcut Dimension 8 (Value)"; Rec."Shortcut Dimension 8 (Value)")
            {
                ApplicationArea = All;
                CaptionClass = ShortcutDimension8;
            }
        }*/
        addafter(Type)
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                Caption = 'Status';
            }
        }
    }
    var ApplyFilterVar: Text;
    trigger OnOpenPage()
    var
    begin
        if ApplyFilterVar = '' then exit
        else
        begin
            Rec.Reset();
            Rec.FilterGroup(11);
            Rec.SetFilter("Document No.", ApplyFilterVar);
            Rec.FilterGroup(0);
        end;
    end;
    procedure ApplyFilter(var1: Text)
    var
    begin
        ApplyFilterVar:=var1;
    end;
}
