codeunit 55121 ShortDescForComp
{
    Permissions = tabledata "Prod. Order Component"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        ProdOrderComponent: Record "Prod. Order Component";
        Var1: Text;
    begin
        ProdOrderComponent.Reset();
        ProdOrderComponent.SetRange("Short Description", '');
        if ProdOrderComponent.FindSet()then repeat Var1:=DelStr(ProdOrderComponent.Description, 21, 100);
                ProdOrderComponent."Short Description":=Var1;
                ProdOrderComponent.Modify();
            until ProdOrderComponent.Next() = 0;
    end;
}
