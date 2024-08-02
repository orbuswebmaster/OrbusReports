table 55141 CaseReasonDetail
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Reason Code"; Text[100])
        {
            trigger OnValidate()
            var
                CaseReasonDetail: Record CaseReasonDetail;
            begin
                CaseReasonDetail.Reset();
                CaseReasonDetail.SetRange("Entry No.", Rec."Entry No.");
                if CaseReasonDetail.FindFirst()then begin
                    Rec."Reason Code":=UpperCase(Rec."Reason Code");
                    Rec.Modify();
                end
                else
                    Rec."Reason Code":=UpperCase(Rec."Reason Code");
            end;
        }
        field(3; "Code"; Text[100])
        {
        }
        field(4; "Description"; Text[400])
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
        CaseReasonDetail: Record CaseReasonDetail;
    begin
        CaseReasonDetail.Reset();
        if CaseReasonDetail.FindLast()then Rec."Entry No.":=CaseReasonDetail."Entry No." + 1
        else
            Rec."Entry No.":=1;
    end;
}
