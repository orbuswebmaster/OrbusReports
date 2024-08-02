pageextension 55117 CaseReasonCodeListPageExt extends "Case Reason Codes WSG"
{
    procedure ProduceValues(): Text var
        CaseReason: Record "Case Reason Code WSG";
        var1: Text;
    begin
        var1:='';
        CaseReason.Reset();
        CurrPage.SetSelectionFilter(CaseReason);
        if CaseReason.FindSet()then repeat var1:=var1 + CaseReason.Code + '|';
            until CaseReason.Next() = 0;
        var1:=DelChr(var1, '>', '|');
        exit(var1);
    end;
}
