codeunit 55125 ModifySIHeaderSalesPersonEmail
{
    Permissions = tabledata "Sales Invoice Header"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
        SalesPersonTableVar: Record "Salesperson/Purchaser";
    begin
        SalesInvoiceHeader.Reset();
        if SalesInvoiceHeader.FindSet()then repeat SalesPersonTableVar.Reset();
                SalesPersonTableVar.SetRange(Code, SalesInvoiceHeader."Salesperson Code");
                if SalesPersonTableVar.FindFirst()then begin
                    if SalesInvoiceHeader."SalesPerson Email" <> SalesPersonTableVar."E-Mail" then begin
                        SalesInvoiceHeader."SalesPerson Email":=SalesPersonTableVar."E-Mail";
                        SalesInvoiceHeader.Modify();
                    end;
                end;
            until SalesInvoiceHeader.Next() = 0;
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet()then repeat SalesPersonTableVar.Reset();
                SalesPersonTableVar.SetRange(Code, SalesHeader."Salesperson Code");
                if SalesPersonTableVar.FindFirst()then begin
                    if SalesHeader."SalesPerson Email" <> SalesPersonTableVar."E-Mail" then begin
                        SalesHeader."SalesPerson Email":=SalesPersonTableVar."E-Mail";
                        SalesHeader.Modify();
                    end;
                end;
            until SalesHeader.Next() = 0;
    end;
}
