codeunit 55192 ModifySalesInvoiceLines
{
    Permissions = tabledata "Sales Invoice Line"=RIMD,
        tabledata "G/L Entry"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesInvoiceLineArchive: Record "Sales Line Archive";
        DimSetEntry: Record "Dimension Set Entry";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.Reset();
        if SalesInvoiceLine.FindSet()then repeat SalesInvoiceLineArchive.Reset();
                SalesInvoiceLineArchive.SetRange("Document No.", SalesInvoiceLine."Order No.");
                SalesInvoiceLineArchive.SetRange("Line No.", SalesInvoiceLine."Order Line No.");
                if SalesInvoiceLineArchive.FindFirst()then begin
                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", SalesInvoiceLineArchive."Dimension Set ID");
                    if DimSetEntry.FindSet()then repeat if DimSetEntry."Global Dimension No." = 3 then SalesInvoiceLine."Shortcut Dimension 3 (Value)":=DimSetEntry."Dimension Value Code";
                            if DimSetEntry."Global Dimension No." = 4 then SalesInvoiceLine."Shortcut Dimension 4 (Value)":=DimSetEntry."Dimension Value Code";
                            if DimSetEntry."Global Dimension No." = 5 then SalesInvoiceLine."Shortcut Dimension 5 (Value)":=DimSetEntry."Dimension Value Code";
                            if DimSetEntry."Global Dimension No." = 6 then SalesInvoiceLine."Shortcut Dimension 6 (Value)":=DimSetEntry."Dimension Value Code";
                            if DimSetEntry."Global Dimension No." = 7 then SalesInvoiceLine."Shortcut Dimension 7 (Value)":=DimSetEntry."Dimension Value Code";
                            if DimSetEntry."Global Dimension No." = 8 then SalesInvoiceLine."Shortcut Dimension 8 (Value)":=DimSetEntry."Dimension Value Code";
                            SalesInvoiceLine.Modify();
                        until DimSetEntry.Next() = 0 end;
            until SalesInvoiceLine.Next() = 0;
    end;
}
