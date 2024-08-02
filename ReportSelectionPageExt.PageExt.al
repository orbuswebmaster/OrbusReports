pageextension 55128 ReportSelectionPageExt extends "Report Selection - Sales"
{
    trigger OnOpenPage()
    var
        ReportSelection: Record "Report Selections";
        var1: Integer;
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"Case Header");
        if ReportSelection.FindFirst()then var1:=1
        else
        begin
            ReportSelection.Init();
            ReportSelection.Usage:=ReportSelection.Usage::"Case Header";
            ReportSelection.Sequence:='1';
            ReportSelection.Insert();
            ReportSelection.Init();
            ReportSelection.Usage:=ReportSelection.Usage::"Case Line";
            ReportSelection.Sequence:='1';
            ReportSelection.Insert();
        end;
    end;
}
