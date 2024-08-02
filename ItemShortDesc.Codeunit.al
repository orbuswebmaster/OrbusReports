codeunit 55122 ItemShortDesc
{
    Permissions = tabledata Item=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        Item: Record Item;
        Var1: Text;
    begin
        Item.Reset();
        Item.SetRange("Short Description", '');
        if Item.FindSet()then repeat Var1:=DelStr(Item.Description, 21, 100);
                Item."Short Description":=Var1;
                Item.Modify();
            until Item.Next() = 0;
    end;
}
