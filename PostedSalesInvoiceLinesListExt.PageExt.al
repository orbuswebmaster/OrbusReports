pageextension 55158 PostedSalesInvoiceLinesListExt extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                Caption = 'Location Code';
            }
        }
        addafter("Shortcut Dimension 2 Code")
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
        }
        addafter(Type)
        {
            field("SalesOrder Created At"; Rec."SalesOrder Created At")
            {
                ApplicationArea = All;
                Caption = 'Created At';
            }
        }
    }
    var ShortcutDimension3: Text;
    ShortcutDimension4: Text;
    ShortcutDimension5: Text;
    ShortcutDimension6: Text;
    ShortcutDimension7: Text;
    ShortcutDimension8: Text;
    trigger OnOpenPage()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Reset();
        if GLSetup.FindFirst()then begin
            ShortcutDimension3:=GLSetup."Shortcut Dimension 3 Code";
            ShortcutDimension4:=GLSetup."Shortcut Dimension 4 Code";
            ShortcutDimension5:=GLSetup."Shortcut Dimension 5 Code";
            ShortcutDimension6:=GLSetup."Shortcut Dimension 6 Code";
            ShortcutDimension7:=GLSetup."Shortcut Dimension 7 Code";
            ShortcutDimension8:=GLSetup."Shortcut Dimension 8 Code";
        end;
    end;
}
