pageextension 55135 RegisteredWhsePickListPage extends "Registered Whse. Picks"
{
    layout
    {
        addafter("Whse. Activity No.")
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
    }
    actions
    {
        addafter("P&ick")
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
    trigger OnAfterGetRecord()
    var
        GetSalesDocValues: Codeunit GetSalesDocValues;
    begin
        GetSalesDocValues.Run(Rec);
    end;
}
