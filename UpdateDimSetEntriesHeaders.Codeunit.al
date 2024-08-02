codeunit 55150 UpdateDimSetEntriesHeaders
{
    Permissions = tabledata "Dimension Set Entry"=RIMD;

    trigger OnRun()
    var
        DimSetEntry: Record "Dimension Set Entry";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange(Status, SalesHeader.Status::Released);
        if SalesHeader.FindSet()then repeat DimSetEntry.Reset();
                DimSetEntry.SetRange("Source No", SalesHeader."No.");
                DimSetEntry.SetFilter("Dimension Code", 'LOC');
                if DimSetEntry.FindFirst()then begin
                    DimSetEntry."Dimension Value Code":=SalesHeader."Location Code";
                    DimSetEntry.Modify();
                end;
            until SalesHeader.Next() = 0;
    end;
}
