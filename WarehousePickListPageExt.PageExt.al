pageextension 55118 WarehousePickListPageExt extends "Warehouse Picks"
{
    actions
    {
        addafter("P&ick")
        {
            action(PickReport)
            {
                Caption = 'Pick Report';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    ReportSelections: Record "Report Selections";
                    SelectedReport: Integer;
                    WarehouseActivityHeader: Record "Warehouse Activity Header";
                    WarehouseListPage: Page "Warehouse Picks";
                    PickFilter: Text;
                begin
                    WarehouseActivityHeader.Reset();
                    WarehouseActivityHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Picking List", true, true, WarehouseActivityHeader);
                end;
            }
        }
    }
}
