page 55198 DepartmentToPerformRework
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Department To Perform Rework';
    SourceTable = DepartmentToPerformRework;
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
        CanModifyInternalReprint: Codeunit CanModifyInternalReprint;
    begin
        EditableVar:=CanModifyInternalReprint.CanModifyDepartmentPerforming();
    end;
    procedure ProduceValues(): Text var
        DepPerformingRework: Record DepartmentToPerformRework;
    begin
        DepPerformingRework.Reset();
        CurrPage.SetSelectionFilter(DepPerformingRework);
        if DepPerformingRework.FindFirst()then exit(DepPerformingRework.Name);
    end;
}
