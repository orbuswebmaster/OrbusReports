table 55151 RootCauseDepartment
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
        RootCauseDepartment: Record RootCauseDepartment;
    begin
        RootCauseDepartment.Reset();
        if RootCauseDepartment.FindLast()then Rec."Entry No.":=RootCauseDepartment."Entry No." + 1
        else
            Rec."Entry No.":=1;
    end;
}
