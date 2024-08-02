pageextension 55157 PermissionSetPageExt extends "Lookup Permission Set"
{
    procedure ProdcueValues(): Text var
        AggregatePermissionSet: Record "Aggregate Permission Set";
        var1: Text;
    begin
        var1:='';
        AggregatePermissionSet.Reset();
        CurrPage.SetSelectionFilter(AggregatePermissionSet);
        if AggregatePermissionSet.FindSet()then repeat var1:=var1 + AggregatePermissionSet."Role ID" + '|';
            until AggregatePermissionSet.Next() = 0;
        var1:=DelChr(var1, '>', '|');
        exit(var1);
    end;
}
