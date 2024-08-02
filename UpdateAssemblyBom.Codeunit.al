codeunit 55145 UpdateAssemblyBom
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        BOMComponent: Record "BOM Component";
    begin
        SalesLine.Reset();
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet()then repeat Item.Reset();
                Item.SetRange("No.", SalesLine."No.");
                if Item.FindFirst()then begin
                    BOMComponent.Reset();
                    BOMComponent.SetRange("Parent Item No.", Item."No.");
                    if BOMComponent.FindSet()then SalesLine."Assembly BOM":=SalesLine."Assembly BOM"::Yes
                    else
                        SalesLine."Assembly BOM":=SalesLine."Assembly BOM"::No;
                    SalesLine.Modify();
                end;
            until SalesLine.Next() = 0;
    end;
}
