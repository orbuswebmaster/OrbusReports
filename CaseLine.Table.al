table 55142 CaseLine
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Case No."; Text[100])
        {
        }
        field(3; Type; Enum RecordType)
        {
        }
        field(4; "No."; Text[100])
        {
            TableRelation = IF (Type = CONST(Item)) Item ELSE IF (Type = CONST(Resource)) Resource;

        }
        field(5; "Sales Record No."; Text[100])
        {
        }
        field(6; Name; Text[200])
        {
        }
        field(7; "Contact Name"; Text[200])
        {
        }
        field(8; "Assigned User ID"; Text[100])
        {
        }
        field(9; "SalesPerson Code"; Text[100])
        {
        }
        field(10; Status; Text[100])
        {
        }
        field(11; "Reason Code"; Text[100])
        {
        }
        field(12; "Department Dimension"; Text[100])
        {
        }
        field(13; "Resolution Document"; Text[100])
        {
        }
        field(14; "Resolution No."; Text[100])
        {
        }
        field(15; "Created By"; Text[100])
        {
        }
        field(16; "DateTime Created"; DateTime)
        {
        }
        field(17; Quantity; Decimal)
        {
        }
        field(18; "Line No."; Integer)
        {
        }
        field(19; "Retrieved Intial Values"; Boolean)
        {
        }
        field(20; "Location Code"; Text[100])
        {
        }
        field(21; "Resolution Code"; Text[100])
        {
        }
        field(22; "Variant Code"; Text[100])
        {
        }
        field(23; "Department Specification"; Text[100])
        {
        }
    }
    keys
    {
        key(PK; "Case No.", "Line No.")
        {
        }
    }
    trigger OnInsert()
    var
        CaseLine: Record CaseLine;
        SalesRecordForCaseLine: Record SalesRecordForCase;
        CaseWSG: Record "Case WSG";
        var1: Integer;
        CaseNo: Text;
    begin
        if Rec.Type = Rec.Type::" " then Rec.FieldError(Rec.Type, '"Type" table field must have a value other than "blank" before record can be inserted into "Case line" table');
        CaseNo := '';
        CaseLine.Reset();
        if CaseLine.FindLast() then
            Rec."Entry No." := CaseLine."Entry No." + 1
        else
            Rec."Entry No." := 1;
        SalesRecordForCaseLine.Reset();
        SalesRecordForCaseLine.SetRange("User ID", UserId());
        if SalesRecordForCaseLine.FindLast() then CaseNo := SalesRecordForCaseLine."Case No.";
        CaseLine.Reset();
        CaseLine.SetFilter("Case No.", CaseNo);
        if CaseLine.FindLast() then
            var1 := CaseLine."Line No." + 1
        else
            var1 := 1;
        Rec."Line No." := var1;
        /*CaseWSG.Reset();
            CaseWSG.SetFilter("No.", CaseNo);
            if
            CaseWSG.FindFirst()
            then
            begin
                CaseLine."Sales Record No." := CaseWSG."Sales Header No.";
                CaseLine."SalesPerson Code" := CaseWSG."SalesPerson Code";
                CaseLine."Assigned User ID" := CaseWSG."Assigned User ID";
                CaseLine."Case No." := CaseNo;
                CaseLine."Contact Name" := CaseWSG."Contact Name";
                CaseLine."Created By" := UserId();
                CaseLine."DateTime Created" := CurrentDateTime();
                CaseLine."Department Code" := CaseWSG."Department Specification";
                CaseLine.Name := CaseWSG."Entity Name";
                CaseLine."Reason Code" := CaseWSG."Reason Code";
                caseline."Resolution Document" := CaseWSG."Resolution Code";
                CaseLine."Resolution No." := CaseWSG."Resolution No.";
            end;*/
    end;
}
