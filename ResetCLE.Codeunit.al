codeunit 55140 ResetCLE
{
    Permissions = tabledata "Cust. Ledger Entry"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        CLE: Record "Cust. Ledger Entry";
    begin
        CLE.Reset();
        CLE.FindFirst();
        CLE.BooleanCHecked:=true;
        CLE.Modify();
    end;
}
