codeunit 55129 GetSalesDocValues
{
    Permissions = tabledata "Registered Whse. Activity Hdr."=RIMD,
        tabledata "Registered Whse. Activity Line"=RIMD;
    TableNo = "Registered Whse. Activity Hdr.";

    trigger OnRun()
    var
        RegisteredWarehouseActivityHeader: Record "Registered Whse. Activity Hdr.";
        RegisteredWarehouseActivityLine: Record "Registered Whse. Activity Line";
    begin
        if Rec."Source No" = '' then begin
            RegisteredWarehouseActivityLine.Reset();
            RegisteredWarehouseActivityLine.SetRange("No.", Rec."No.");
            if RegisteredWarehouseActivityLine.FindFirst()then begin
                Rec."Source Type":=Format(RegisteredWarehouseActivityLine."Source Document", 0, '<Text>');
                Rec."Source No":=RegisteredWarehouseActivityLine."Source No.";
                Rec.Modify();
            end;
        end;
    end;
}
