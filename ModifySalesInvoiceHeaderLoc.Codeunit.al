codeunit 55198 ModifySalesInvoiceHeaderLoc
{
    Permissions = tabledata "Sales Invoice Header"=RIMD;

    trigger OnRun()
    var
    begin
    end;
    procedure ModifySalesInvoiceHeaderLoc(InvoiceNo: Text; NewLocationCode: Text)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", InvoiceNo);
        if SalesInvoiceHeader.FindFirst()then begin
            SalesInvoiceHeader."Location Code":=NewLocationCode;
            SalesInvoiceHeader.Modify();
        end;
    end;
}
