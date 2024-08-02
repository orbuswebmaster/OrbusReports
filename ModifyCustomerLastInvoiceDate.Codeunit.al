codeunit 55191 ModifyCustomerLastInvoiceDate
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
    begin
        Customer.Reset();
        if Customer.FindSet()then repeat SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesInvoiceHeader.FindLast()then begin
                    if Customer."Last Invoice Date" <> SalesInvoiceHeader."Posting Date" then begin
                        Customer."Last Invoice Date":=SalesInvoiceHeader."Posting Date";
                        Customer.Modify();
                    end;
                end;
            until Customer.Next() = 0;
    end;
}
