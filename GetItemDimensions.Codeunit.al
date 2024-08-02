codeunit 55158 GetItemDimensions
{
    Permissions = tabledata Item=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        Item: Record Item;
        DefaultDimension: Record "Default Dimension";
        var1: Text;
    begin
        var1:='';
        Item.Reset();
        Item.SetFilter("Department Dimension", var1);
        if Item.FindSet()then repeat DefaultDimension.Reset();
                DefaultDimension.SetRange("No.", Item."No.");
                if DefaultDimension.FindSet()then repeat if DefaultDimension."Dimension Code" = 'DEPT' then begin
                            Item."Department Dimension":=DefaultDimension."Dimension Value Code";
                            Item.Modify();
                        end;
                        if DefaultDimension."Dimension Code" = 'DIVISION' then begin
                            Item."Division Dimension":=DefaultDimension."Dimension Value Code";
                            Item.Modify();
                        end;
                        if DefaultDimension."Dimension Code" = 'MATERIAL' then begin
                            Item."Material Dimension":=DefaultDimension."Dimension Value Code";
                            Item.Modify();
                        end;
                        if DefaultDimension."Dimension Code" = 'PRDLN' then begin
                            Item."Product Line Dimension":=DefaultDimension."Dimension Value Code";
                            Item.Modify();
                        end;
                    until DefaultDimension.Next() = 0;
            until Item.Next() = 0;
    end;
}
