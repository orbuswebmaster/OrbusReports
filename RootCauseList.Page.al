page 55199 RootCauseList
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Root Cause List';
    SourceTable = RootCause;
    PageType = List;

    layout
    {
        area(Content)
        {
            field(RootCauseDepartment; RootCauseDepartment)
            {
                ApplicationArea = All;
                Visible = VisibleVarDep;
                Editable = false;
                Caption = 'Root Cause Department';
            }
            repeater(Main)
            {
                Editable = EditableVar;

                field("Root Cause Department"; Rec."Root Cause Department")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Root Cause Name';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        CanModifyInternalReprint: Codeunit CanModifyInternalReprint;
    begin
        //CurrPage.Editable(CanModifyInternalReprint.CanModifyRootCause());
        EditableVar:=CanModifyInternalReprint.CanModifyRootCause();
        if RootCauseDepartment = '' then VisibleVarDep:=false
        else
        begin
            VisibleVarDep:=true;
            Rec.Reset();
            Rec.FilterGroup(11);
            Rec.SetFilter("Root Cause Department", RootCauseDepartment);
            Rec.FilterGroup(0);
        end;
    end;
    var RootCauseDepartment: Text;
    VisibleVarDep: Boolean;
    EditableVar: Boolean;
    procedure ApplyFilter(var1: Text)
    var
    begin
        RootCauseDepartment:=var1;
    end;
    procedure ProduceValues(): Text var
        RootCause: Record RootCause;
    begin
        RootCause.Reset();
        CurrPage.SetSelectionFilter(RootCause);
        if RootCause.FindFirst()then exit(RootCause.Name);
    end;
}
