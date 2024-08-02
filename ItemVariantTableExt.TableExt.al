tableextension 55142 ItemVariantTableExt extends "Item Variant"
{
    fields
    {
    }
    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Allow Item Variants" = false then Error('Your User: %1 does not have permission to insert records into Item Variants table', UserId());
        end
        else
        begin
            UserSetup.Init();
            UserSetup."User ID":=UserId();
            UserSetup.Insert();
            Commit();
            Error('Your User: %1 does not have permission to insert records into Item Variants table', UserId());
        end;
    end;
}
