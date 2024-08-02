table 55148 RootCause
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
        field(4; "Root Cause Department"; Text[100])
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
        RootCause: Record RootCause;
    begin
        RootCause.Reset();
        if RootCause.FindLast()then Rec."Entry No.":=RootCause."Entry No." + 1
        else
            Rec."Entry No.":=1;
    end;
}
