pageextension 55178 UserListPageExt extends Users
{
    actions
    {
        addafter(AddMeAsSuper)
        {
            action(InsertpermissionSetFoprUser)
            {
                ApplicationArea = All;
                Caption = 'Insert Permission Set For Users';
                Image = Lock;
                Promoted = true;
                PromotedCategory = Process;
                Visible = VisibleVar1;

                trigger OnAction()
                var
                    User: Record User;
                    ModifyPermissionSetSD: Page ModifyPermissionSetForUsersSD;
                    UserRecords: Text;
                begin
                    UserRecords:='';
                    User.Reset();
                    CurrPage.SetSelectionFilter(User);
                    if User.FindSet()then repeat UserRecords:=UserRecords + User."User Name" + '|';
                        until User.Next() = 0;
                    UserRecords:=DelChr(UserRecords, '>', '|');
                    ModifyPermissionSetSD.GetValues(UserRecords);
                    if ModifyPermissionSetSD.RunModal() = Action::OK then ModifyPermissionSetSD.ModifyUserPermissions();
                end;
            }
        }
    }
    var VisibleVar1: Boolean;
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."User Permission Set Visible" = true then VisibleVar1:=true
            else
                VisibleVar1:=false;
        end;
    end;
}
