codeunit 55154 DimSetEntriesSourceNo
{
    Permissions = tabledata "Dimension Set Entry"=RIMD;
    TableNo = "Sales Header";

    trigger OnRun()
    var
    begin
    end;
    procedure DimSetEntriesSourceNo(var1: Record "Sales Header")
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimensionValue: Record "Dimension Value";
    begin
        DimSetEntry.Reset();
        DimSetEntry.SetRange("Source No", var1."No.");
        DimSetEntry.SetFilter("Dimension Code", 'LOC');
        if DimSetEntry.FindFirst()then begin
            DimSetEntry."Dimension Value Code":=var1."Location Code";
            DimSetEntry.Modify();
        end
        else
        begin
            DimensionValue.Reset();
            DimensionValue.SetRange("Dimension Code", 'LOC');
            DimensionValue.SetRange(Code, var1."Location Code");
            if DimensionValue.FindFirst()then begin
                DimSetEntry.Init();
                DimSetEntry."Dimension Code":='LOC';
                DimSetEntry."Dimension Value Code":=var1."Location Code";
                DimSetEntry."Dimension Set ID":=var1."Dimension Set ID";
                DimSetEntry."Dimension Value ID":=DimensionValue."Dimension Value ID";
                DimSetEntry."Dimension Value Name":=DimensionValue.Name;
                DimSetEntry."Dimension Name":='Location';
                DimSetEntry."Global Dimension No.":=1;
                DimSetEntry."Source No":=var1."No.";
                DimSetEntry.Insert();
            end;
        end;
    end;
}
