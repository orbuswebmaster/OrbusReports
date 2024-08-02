codeunit 55123 GetSalesOrderNo
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
        var1:=0;
        var2:=0;
        var3:=0;
        ReservationEntry.Reset();
        ReservationEntry.SetFilter("Source Type", '5406|37');
        if ReservationEntry.FindLast()then repeat ProductionHeader.Reset();
                ProductionHeader.SetRange("No.", ReservationEntry."Source ID");
                if ProductionHeader.FindFirst()then if(ProductionHeader."Sales Order No." = '') or (ProductionHeader."Sales Order No." = 'No SO #')then begin
                        var1:=ReservationEntry."Line No.";
                        ReservationEntry.Next(-1);
                        var2:=ReservationEntry."Line No.";
                        var3:=var1 - var2;
                        if var3 = 1 then begin
                            ProductionHeader."Sales Order No.":=ReservationEntry."Source ID";
                            ProductionHeader.Modify();
                            ReservationEntry.Next(1);
                        end
                        else
                        begin
                            ProductionHeader."Sales Order No.":='';
                            ProductionHeader.Modify();
                            ReservationEntry.Next(1);
                        end;
                    end;
            until ReservationEntry.Next(-1) = 0;
    end;
}
