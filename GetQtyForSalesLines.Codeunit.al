codeunit 55139 GetQtyForSalesLines
{
    trigger OnRun()
    var
        VendorLedgerEntries: Record "Vendor Ledger Entry";
        CHeckLedgerEntries: Record "Check Ledger Entry";
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforeSalesLineModify', '', false, false)]
    local procedure BeforeSalesLineModify(var SalesLine: Record "Sales Line"; WarehouseShipmentLine: Record "Warehouse Shipment Line"; var ModifyLine: Boolean; Invoice: Boolean)
    var
        Qty: Decimal;
    begin
        // This code will set the qty's back that got cleared when posting the Warehouse Shipment.
        if SalesLine.Type = SalesLine.Type::Resource then begin
            if SalesLine."Outstanding Quantity" = 0 then Qty:=SalesLine.Quantity
            else
                Qty:=SalesLine."Outstanding Quantity";
            SalesLine."Qty. to Ship":=Qty;
            SalesLine."Qty. to Ship (Base)":=Qty;
            SalesLine."Qty. to Invoice":=Qty;
            SalesLine."Qty. to Invoice (Base)":=Qty;
            ModifyLine:=true;
        end;
    end;
}
