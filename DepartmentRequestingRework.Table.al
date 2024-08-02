table 55144 DepartmentRequestingRework
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; Description; Text[200])
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
        DepRequestingRework: Record DepartmentRequestingRework;
    begin
        DepRequestingRework.Reset();
        if DepRequestingRework.FindLast()then Rec."Entry No.":=DepRequestingRework."Entry No." + 1
        else
            Rec."Entry No.":=1;
    end;
}
