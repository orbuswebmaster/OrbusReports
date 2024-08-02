codeunit 55138 AmountsForSalesInvHeader
{
    Permissions = tabledata "Sales Invoice Header"=RIMD;

    trigger OnRun()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        var10: Decimal;
        var20: Decimal;
        AmountMinusFreightVar: Decimal;
    begin
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("Amount Minus Freight", 0);
        if SalesInvoiceHeader.FindSet()then repeat SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine.CalcSums(Amount);
                var10:=SalesInvoiceLine.Amount;
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Resource);
                SalesInvoiceLine.SetFilter("No.", 'RES0000018');
                SalesInvoiceLine.CalcSums(Amount);
                var20:=SalesInvoiceLine.Amount;
                SalesInvoiceHeader."Amount Minus Freight":=var10 - var20;
                if SalesInvoiceHeader."Amount Minus Freight" > 0 then SalesInvoiceHeader.Modify();
            until SalesInvoiceHeader.Next() = 0;
    end;
    procedure GetFreightAmountOnOpenPage(var1: Record "Sales Invoice Header")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        var30: Decimal;
        var40: Decimal;
    begin
        if var1."Amount Minus Freight" = 0 then begin
            SalesInvoiceLine.Reset();
            SalesInvoiceLine.SetRange("Document No.", var1."No.");
            SalesInvoiceLine.CalcSums(Amount);
            var30:=SalesInvoiceLine.Amount;
            SalesInvoiceLine.Reset();
            SalesInvoiceLine.SetRange("Document No.", var1."No.");
            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Resource);
            SalesInvoiceLine.SetFilter("No.", 'RES0000018');
            SalesInvoiceLine.CalcSums(Amount);
            var40:=SalesInvoiceLine.Amount;
            var1."Amount Minus Freight":=var30 - var40;
            var1.Modify();
        end;
    end;
}
