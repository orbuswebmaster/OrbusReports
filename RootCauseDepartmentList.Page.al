page 55151 RootCauseDepartmentList
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Root Cause Department';
    SourceTable = RootCauseDepartment;
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                Editable = EditableVar;

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var DepartmentRequestingReworkName: Text;
    VisibleVarDep: Boolean;
    EditableVar: Boolean;
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Modify Root Cause Department" = true then EditableVar:=true
            else
                EditableVar:=false;
        end;
    end;
    procedure ProduceValues(): Text var
        RootCauseDepartment: Record RootCauseDepartment;
    begin
        RootCauseDepartment.Reset();
        CurrPage.SetSelectionFilter(RootCauseDepartment);
        if RootCauseDepartment.FindFirst()then exit(RootCauseDepartment.Name);
    end;
}
