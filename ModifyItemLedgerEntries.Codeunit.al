codeunit 55185 ModifyItemLedgerEntries
{
    Permissions = tabledata "Item Ledger Entry"=RIMD;
    TableNo = "Item Ledger Entry";

    trigger OnRun()
    var
        WarehouseEntry: Record "Warehouse Entry";
    begin
        WarehouseEntry.Reset();
        WarehouseEntry.SetRange("Whse. Document No.", Rec."Document No.");
        WarehouseEntry.SetFilter("Bin Code", '<>ADJ');
        if WarehouseEntry.FindFirst()then begin
            Rec."Bin Code":=WarehouseEntry."Bin Code";
            Rec.Modify();
        end;
    end;
/*procedure ModifyItemLedgerEntries(var1: Text; var2: Text; var3: Record "Item Ledger Entry")
    var
        WarehouseEntry: Record "Warehouse Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        WarehouseEntry.Reset();
        WarehouseEntry.SetRange("Whse. Document No.", var1);
        if
        WarehouseEntry.FindFirst()
        then begin
            var2 := WarehouseEntry."Bin Code";
            
        end;
    end;*/
}
