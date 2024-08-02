codeunit 55182 GetRegisteredPick
{
    Permissions = tabledata "Registered Whse. Activity Hdr."=RIMD;

    trigger OnRun()
    var
    begin
    end;
    procedure ModifyRegisteredWhseActivityHeader(var1: Text; var2: Text)
    var
        RegisteredWhseActivityHeader: Record "Registered Whse. Activity Hdr.";
    begin
        RegisteredWhseActivityHeader.Reset();
        RegisteredWhseActivityHeader.SetFilter("Whse. Activity No.", var1);
        if RegisteredWhseActivityHeader.FindFirst()then begin
            RegisteredWhseActivityHeader."Printed By":=var2;
            RegisteredWhseActivityHeader.Modify();
        end;
    end;
}
