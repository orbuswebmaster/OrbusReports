pageextension 55127 ResourceListPageExt extends "Resource List"
{
    procedure ProduceValues(): Text var
        Resource: Record Resource;
        var1: Text;
    begin
        var1:='';
        Resource.Reset();
        CurrPage.SetSelectionFilter(Resource);
        if Resource.FindSet()then repeat var1:=var1 + Resource."No." + '|';
            until Resource.Next() = 0;
        var1:=DelChr(var1, '>', '|');
        exit(var1);
    end;
}
