codeunit 55142 ClearWhseWorksheetLine
{
    Permissions = tabledata "Whse. Worksheet Line"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        WhseWorksheetLine: Record "Whse. Worksheet Line";
    begin
        WhseWorksheetLine.Reset();
        WhseWorksheetLine.SetFilter("Worksheet Template Name", 'PICK');
        if WhseWorksheetLine.FindSet()then WhseWorksheetLine.DeleteAll();
    end;
}
