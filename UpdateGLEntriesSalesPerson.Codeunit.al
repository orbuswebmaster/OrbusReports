codeunit 55183 UpdateGLEntriesSalesPerson
{
    Permissions = tabledata "G/L Entry"=RIMD;
    Tableno = "Job Queue Entry";

    trigger OnRun()
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        SalesInvoiceHEader: Record "Sales Invoice Header";
    begin
        GLEntry.Reset();
        GLEntry.SetFilter("G/L Account No.", '40000..40009|41000..49999');
        if GLEntry.FindSet()then repeat if GLEntry.SalesPerson = '' then begin
                    if Format(GLEntry."Document No.").StartsWith('PS-INV')then begin
                        SalesInvoiceHEader.Reset();
                        SalesInvoiceHEader.SetRange("No.", GLEntry."Document No.");
                        if SalesInvoiceHEader.FindFirst()then begin
                            GLEntry.SalesPerson:=SalesInvoiceHEader."Salesperson Code";
                            GLEntry.Modify();
                        end;
                    end;
                end;
            until GLEntry.Next() = 0 end;
}
