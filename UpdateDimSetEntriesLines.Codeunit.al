codeunit 55151 UpdateDimSetEntriesLines
{
    Permissions = tabledata "Dimension Set Entry"=RIMD;

    trigger OnRun()
    var
        DimSetEntry: Record "Dimension Set Entry";
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        if SalesLine.FindSet()then repeat DimSetEntry.Reset();
                DimSetEntry.SetRange("Source No", SalesLine."Document No.");
                DimSetEntry.SetRange("Source No.- Line No.", SalesLine."Line No.");
                DimSetEntry.SetFilter("Dimension Code", 'LOC');
                if DimSetEntry.FindFirst()then begin
                    DimSetEntry."Dimension Value Code":=SalesLine."Location Code";
                    DimSetEntry.Modify();
                end;
            until SalesLine.Next() = 0;
    end;
}
