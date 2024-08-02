page 55194 ModifyPermissionSetForUsersSD
{
    ApplicationArea = All;
    PageType = StandardDialog;
    Caption = 'Modify Permission Set For Users';

    layout
    {
        area(Content)
        {
            field(Users; Users)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(PermissionSets; PermissionSets)
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean var
                    PermissionSetVar: Page "Lookup Permission Set";
                begin
                    PermissionSetVar.LookupMode(true);
                    if PermissionSetVar.RunModal() = Action::LookupOK then PermissionSets:=PermissionSetVar.ProdcueValues();
                end;
            }
        }
    }
    var Users: Text;
    PermissionSets: Text;
    procedure ModifyUserPermissions()
    var
        AccessControl: Record "Access Control";
        User: Record User;
        AggregatePermissionSet: Record "Aggregate Permission Set";
        var1: Integer;
    begin
        User.Reset();
        User.SetFilter("User Name", Users);
        if User.FindSet()then repeat AggregatePermissionSet.Reset();
                AggregatePermissionSet.SetFilter("Role ID", PermissionSets);
                if AggregatePermissionSet.FindSet()then repeat AccessControl.Reset();
                        AccessControl.SetFilter("User Name", User."User Name");
                        AccessControl.SetFilter("Role ID", AggregatePermissionSet."Role ID");
                        if AccessControl.FindFirst()then var1:=1
                        else
                        begin
                            AccessControl.Init();
                            AccessControl."User Name":=User."User Name";
                            AccessControl."User Security ID":=User."User Security ID";
                            AccessControl."App ID":=AggregatePermissionSet."App ID";
                            AccessControl."Role ID":=AggregatePermissionSet."Role ID";
                            AccessControl.Scope:=AccessControl.Scope::System;
                            AccessControl."Company Name":='';
                            AccessControl."Role Name":=AggregatePermissionSet.Name;
                            AccessControl."App Name":=AggregatePermissionSet."App Name";
                            if AccessControl.Insert()then var1:=1
                            else
                                Error('Not all records were inserted into Access Control table. Please try again.');
                        end;
                    until AggregatePermissionSet.Next() = 0;
            until User.Next() = 0;
    end;
    procedure GetValues(var1: Text)
    var
    begin
        Users:=var1;
    end;
}
