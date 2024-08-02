codeunit 55184 UpdateSalesInvoiceLines
{
    Permissions = tabledata "Sales Invoice Line"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLines: Record "Sales Invoice Line";
    begin
        SalesInvoiceLines.Reset();
        if SalesInvoiceLines.FindSet()then repeat SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetRange("No.", SalesInvoiceLines."Document No.");
                if SalesInvoiceHeader.FindFirst()then begin
                    SalesInvoiceLines."SalesOrder Created At":=SalesInvoiceHeader."Created At";
                    SalesInvoiceLines.Modify();
                end;
            until SalesInvoiceLines.Next() = 0 end;
}
