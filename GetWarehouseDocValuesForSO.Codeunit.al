codeunit 55131 GetWarehouseDocValuesForSO
{
    Permissions = tabledata "Registered Whse. Activity Hdr."=RIMD,
        tabledata "Registered Whse. Activity Line"=RIMD,
        tabledata "Sales Header"=RIMD,
        tabledata "Sales Line"=RIMD,
        tabledata "Warehouse Activity Header"=RIMD,
        tabledata "Warehouse Activity Line"=RIMD;

    trigger OnRun()
    var
    begin
    end;
    procedure GetWarehousePickNo()
    var
        SalesHeader: Record "Sales Header";
        WhseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityLine: Record "Warehouse Activity Line";
    begin
        WhseActivityHeader.Reset();
        WhseActivityHeader.SetRange("Source Document", WhseActivityHeader."Source Document"::"Sales Order");
        if WhseActivityHeader.FindSet()then repeat SalesHeader.Reset();
                SalesHeader.SetRange("No.", WhseActivityHeader."Source No.");
                SalesHeader.SetFilter("Warehouse Pick No.", '');
                if SalesHeader.FindFirst()then begin
                    SalesHeader."Warehouse Pick No.":=WhseActivityHeader."No.";
                    SalesHeader.Modify();
                end;
            until WhseActivityHeader.Next() = 0;
    end;
    procedure GetRegisteredWarehousePickNo()
    var
        SalesHeader: Record "Sales Header";
        RegisteredWarehousePickHeader: Record "Registered Whse. Activity Hdr.";
        RegisteredWarehousePickLine: Record "Registered Whse. Activity Line";
    begin
        RegisteredWarehousePickHeader.Reset();
        RegisteredWarehousePickHeader.SetFilter("Source Type", 'Sales Order');
        if RegisteredWarehousePickHeader.FindSet()then repeat SalesHeader.Reset();
                SalesHeader.SetRange("No.", RegisteredWarehousePickHeader."Source No");
                SalesHeader.SetFilter("Registered Warehouse Pick No.", '');
                if SalesHeader.FindFirst()then begin
                    SalesHeader."Registered Warehouse Pick No.":=RegisteredWarehousePickHeader."No.";
                    SalesHeader.Modify();
                end;
            until RegisteredWarehousePickHeader.Next() = 0;
    end;
}
