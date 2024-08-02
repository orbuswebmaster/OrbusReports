pageextension 55125 WarehousePickDocumentPageExt extends "Warehouse Pick"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Printed By"; Rec."Printed By")
            {
                ApplicationArea = All;
                Caption = 'Printed By';
                Editable = false;
            }
            field("Printed At"; Rec."Printed At")
            {
                ApplicationArea = All;
                Caption = 'Printed At';
                Editable = false;
            }
        }
    }
    actions
    {
        modify(RegisterPick)
        {
            trigger OnBeforeAction()
            var
            begin
                PrintedByVar:=Rec."Printed By";
                PickNoVar:=Rec."No.";
            end;
            trigger OnAfterAction()
            var
                RegisteredWhseActivityHeader: Record "Registered Whse. Activity Hdr.";
                GetRegisteredPick: Codeunit GetRegisteredPick;
            begin
                GetRegisteredPick.ModifyRegisteredWhseActivityHeader(PickNoVar, PrintedByVar);
            end;
        }
    }
    var PrintedByVar: Text;
    PickNoVar: Text;
}
