page 55149 ProjectManagerList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ProjectManager;
    Caption = 'Project Manager';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = EditableVar1;

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Visible; Rec.Visible)
                {
                    ApplicationArea = All;
                    Visible = VisibleVar1;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Can Modify/Insert PM Records" = true then begin
                EditableVar1:=true;
                VisibleVar1:=true;
            end
            else
            begin
                EditableVar1:=false;
                VisibleVar1:=false;
            end;
        end;
        if VisibleBoolean = true then begin
            Rec.Reset();
            Rec.FilterGroup(11);
            Rec.SetRange(Visible, true);
            Rec.FilterGroup(0);
        end;
    end;
    var EditableVar1: Boolean;
    VisibleVar1: Boolean;
    VisibleBoolean: Boolean;
    procedure OnlyDisplayVisible(var1: Boolean)
    var
    begin
        VisibleBoolean:=var1;
    end;
    procedure ProduceName(): Text var
        ProjectManager: Record ProjectManager;
    begin
        ProjectManager.Reset();
        CurrPage.SetSelectionFilter(ProjectManager);
        if ProjectManager.FindFirst()then exit(ProjectManager.Name);
    end;
}
