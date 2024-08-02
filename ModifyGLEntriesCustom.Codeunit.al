codeunit 55199 ModifyGLEntriesCustom
{
    Permissions = tabledata "G/L Entry"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        GLEntry: Record "G/L Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        var1: Text;
        GLDocNo: Text;
    begin
        GLEntry.Reset();
        GLEntry.SetFilter("G/L Account No.", '40000..40009|41000..41999|50000..59999');
        if GLEntry.FindSet()then repeat GLDocNo:=Format(GLEntry."Document No.");
                if GLEntry."Location Code 2" = '' then begin
                    if(GLDocNo.StartsWith('PS-INV'))then begin
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetRange("No.", GLEntry."Document No.");
                        if SalesInvoiceHeader.FindFirst()then begin
                            GLEntry."Location Code 2":=SalesInvoiceHeader."Location Code";
                            GLEntry.Modify();
                        end;
                    end;
                end;
            until GLEntry.Next() = 0;
    end;
}
