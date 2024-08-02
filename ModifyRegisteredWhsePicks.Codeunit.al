codeunit 55155 ModifyRegisteredWhsePicks
{
    Permissions = tabledata "Registered Whse. Activity Hdr."=RIMD,
        tabledata "Registered Whse. Activity Line"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        RegisteredWarehouseActivityHeader: Record "Registered Whse. Activity Hdr.";
        RegisteredWarehouseActivityLine: Record "Registered Whse. Activity Line";
    begin
        RegisteredWarehouseActivityHeader.Reset();
        RegisteredWarehouseActivityHeader.SetRange(Type, RegisteredWarehouseActivityHeader.Type::Pick);
        if RegisteredWarehouseActivityHeader.FindSet()then repeat if RegisteredWarehouseActivityHeader."Source No" = '' then begin
                    RegisteredWarehouseActivityLine.Reset();
                    RegisteredWarehouseActivityLine.SetRange("No.", RegisteredWarehouseActivityHeader."No.");
                    if RegisteredWarehouseActivityLine.FindFirst()then begin
                        RegisteredWarehouseActivityHeader."Source No":=RegisteredWarehouseActivityLine."Source No.";
                        RegisteredWarehouseActivityHeader."Source Type":=Format(RegisteredWarehouseActivityLine."Source Document", 0, '<Text>');
                        RegisteredWarehouseActivityHeader.Modify();
                    end;
                end;
            until RegisteredWarehouseActivityHeader.Next() = 0;
    end;
}
