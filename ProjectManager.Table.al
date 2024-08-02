table 55149 ProjectManager
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; Name; Text[200])
        {
        }
        field(3; Visible; Boolean)
        {
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
        }
    }
    trigger OnInsert()
    var
        EntryNo: Integer;
        ProjectManager: Record ProjectManager;
    begin
        ProjectManager.Reset();
        if ProjectManager.FindLast()then begin
            Rec."Entry No.":=ProjectManager."Entry No." + 1;
            Rec.Visible:=true;
        end
        else
        begin
            Rec."Entry No.":=1;
            Rec.Visible:=true;
        end;
    end;
}
