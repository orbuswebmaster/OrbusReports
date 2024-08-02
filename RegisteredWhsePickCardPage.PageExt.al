pageextension 55136 RegisteredWhsePickCardPage extends "Registered Pick"
{
    layout
    {
        addafter("No. Printed")
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
                Caption = 'Source Type';
                Editable = false;
            }
            field("Source No"; Rec."Source No")
            {
                ApplicationArea = All;
                Caption = 'Source No.';
                Editable = false;
            }
        }
        addafter("Assigned User ID")
        {
            field("Printed By"; Rec."Printed By")
            {
                ApplicationArea = All;
                Caption = 'Printed By';
                Editable = false;
            }
        }
    }
    actions
    {
        addafter(List)
        {
            action(RegisteredPickReport)
            {
                ApplicationArea = All;
                Caption = 'Registered Pick Report';
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    RegisteredWarehouseActivityHeader: Record "Registered Whse. Activity Hdr.";
                begin
                    RegisteredWarehouseActivityHeader.Reset();
                    RegisteredWarehouseActivityHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::RegisteredWarehousePick, true, true, RegisteredWarehouseActivityHeader);
                end;
            }
        }
    }
}
