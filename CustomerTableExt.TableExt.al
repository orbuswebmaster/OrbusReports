tableextension 55148 CustomerTableExt extends Customer
{
    fields
    {
        field(55101; "Magento Contact No."; Text[100])
        {
        }
        field(55102; "Magento Contact Name"; Text[100])
        {
        }
        field(55103; "Magento Contact Email"; Text[100])
        {
        }
        field(55104; "Last Invoice Date"; Date)
        {
        }
        field(55105; DocType;Enum DocType)
        {
        }
        modify(Blocked)
        {
        trigger OnBeforeValidate()
        var
            UserSetup: Record "User Setup";
        begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId());
            if UserSetup.FindFirst()then begin
                if UserSetup."Finance Block" = true then Error('User: %1 does not have permission to modify the data in this table field (Blocked)', UserId());
            end;
        end;
        }
        modify("Credit Limit (LCY)")
        {
        trigger OnBeforeValidate()
        var
            UserSetup: Record "User Setup";
        begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId());
            if UserSetup.FindFirst()then begin
                if UserSetup."Finance Block" = true then Error('User: %1 does not have permission to modify the data in this table field (Blocked)', UserId());
            end;
        end;
        }
    }
}
