codeunit 55193 ModSalesInvoiceHeaderRecords
{
    Permissions = tabledata "Sales Invoice Header"=RIMD;

    trigger OnRun()
    var
    begin
    end;
    procedure ModifySalesInvoiceHeaderRecords()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        SalesInvoiceHeader.Reset();
        if SalesInvoiceHeader.FindSet()then repeat SalesHeaderArchive.Reset();
                SalesHeaderArchive.SetRange("No.", SalesInvoiceHeader."Order No.");
                if SalesHeaderArchive.FindFirst()then begin
                    SalesInvoiceHeader."Assigned User ID 2":=SalesHeaderArchive."Assigned User ID";
                    SalesInvoiceHeader.Modify();
                end;
            until SalesInvoiceHeader.Next() = 0 end;
}
