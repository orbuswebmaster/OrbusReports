pageextension 55119 PostedShipmentListPageExt extends "Posted Whse. Shipment List"
{
    actions
    {
        addafter("&Shipment")
        {
            action(ShipmentReport)
            {
                Caption = 'Warehouse Shipment Report';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    ReportSelections: Record "Report Selections";
                    SelectedReport: Integer;
                    PostedWarehouseShipmentHeader: Record "Posted Whse. Shipment Header";
                    PostedWarehouseShipmentListPage: Page "Posted Whse. Shipment List";
                    PackFilter: Text;
                begin
                    PostedWarehouseShipmentHeader.Reset();
                    PostedWarehouseShipmentHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Whse. - Posted Shipment", true, true, PostedWarehouseShipmentHeader);
                end;
            }
        }
    }
}
