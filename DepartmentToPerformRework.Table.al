table 55145 DepartmentToPerformRework
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
        DepPerformingRework: Record DepartmentToPerformRework;
    begin
        DepPerformingRework.Reset();
        if DepPerformingRework.FindLast()then Rec."Entry No.":=DepPerformingRework."Entry No." + 1
        else
            Rec."Entry No.":=1;
    end;
}
