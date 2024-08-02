codeunit 55124 ReservationEntryLineNo
{
    Permissions = tabledata "Production Order"=RIMD,
        tabledata "Reservation Entry"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        ReservationEntry: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        ProductionHeader: Record "Production Order";
        var1: Integer;
        var2: Integer;
        var3: Integer;
    begin
        ReservationEntry.Reset();
        if ReservationEntry.FindFirst()then repeat var1:=var1 + 1;
                if ReservationEntry."Line No." = 0 then begin
                    ReservationEntry."Line No.":=var1;
                    ReservationEntry.Modify();
                end;
            until ReservationEntry.Next() = 0;
    end;
}
