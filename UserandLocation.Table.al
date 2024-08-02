table 55103 UserandLocation
{
    fields
    {
        field(55101; "Entry No."; Integer)
        {
        }
        field(55102; "User ID"; Text[100])
        {
        }
        field(55103; Location; Text[100])
        {
            trigger OnValidate()
            var
                UserandLocation: Record UserandLocation;
            begin
                UserandLocation.Reset();
                UserandLocation.SetRange("Entry No.", Rec."Entry No.");
                if UserandLocation.FindFirst()then begin
                    Rec.Location:=UpperCase(Rec.Location);
                    Rec.Modify();
                end
                else
                    Rec.Location:=UpperCase(Rec.Location);
            end;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
        }
        key(SK; "User ID", Location)
        {
        }
    }
    trigger OnInsert()
    var
        UserandLocation: Record UserandLocation;
    begin
        UserandLocation.Reset();
        if UserandLocation.FindLast()then Rec."Entry No.":=UserandLocation."Entry No." + 1
        else
            Rec."Entry No.":=1;
    end;
}
