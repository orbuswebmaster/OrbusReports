codeunit 55144 CanModifyInternalReprint
{
    trigger OnRun()
    var
    begin
    end;
    procedure CanModifyDepartmentRequesting(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Modify Department Requesting" = true then exit(true)
            else
                exit(false);
        end;
    end;
    procedure CanModifyDepartmentPerforming(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Modify Department Performing" = true then exit(true)
            else
                exit(false);
        end;
    end;
    procedure CanModifyRootCause(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Modify Root Cause" = true then exit(true)
            else
                exit(false);
        end;
    end;
}
