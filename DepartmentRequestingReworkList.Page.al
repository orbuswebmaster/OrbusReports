page 55197 DepartmentRequestingReworkList
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Department Requesting Rework List';
    SourceTable = DepartmentRequestingRework;
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
    var EditableVar: Boolean;
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        CanModifyInternalReprint: Codeunit CanModifyInternalReprint;
    begin
        EditableVar:=CanModifyInternalReprint.CanModifyDepartmentRequesting();
        if Name = '' then exit
        else
        begin
            Rec.Reset();
            Rec.FilterGroup(11);
            Rec.SetFilter(Name, Name);
            Rec.FilterGroup(0);
        end;
    end;
    var Name: Text;
    procedure ApplyFilter(var1: Text)
    var
    begin
        Name:=var1;
    end;
    procedure ProduceValues(): Text var
        Dep: Record DepartmentRequestingRework;
    begin
        Dep.Reset();
        CurrPage.SetSelectionFilter(Dep);
        if Dep.FindFirst()then exit(Dep.Name);
    end;
}
