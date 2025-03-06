pageextension 55162 CaseListExt extends "Case List WSG"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("SalesPerson Code"; Rec."SalesPerson Code")
            {
                ApplicationArea = All;
                Caption = 'SalesPerson Code';
                Editable = false;
            }
        }
        addafter("Resolution No.")
        {
            field("Follow Up Date"; Rec."Follow Up Date")
            {
                ApplicationArea = All;
            }
            field("Must Arrive Date"; Rec."Must Arrive Date")
            {
                ApplicationArea = All;
            }
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
            }
            field("Responsible Owner Current"; Rec."Responsible Owner Current")
            {
                ApplicationArea = All;
            }
            field("CS Status"; Rec."CS Status")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Case Report")
        {
            action(CaserHeaderReport)
            {
                ApplicationArea = All;
                Image = Report;
                Caption = 'Case Header Report';
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    CaseHeader: Record "Case WSG";
                    CaseHeaderReport: Report CaseHeader;
                    ReportSelection: Record "Report Selections";
                    ReportID: Integer;
                begin
                    /*ReportSelection.Reset();
                    ReportSelection.SetRange(Usage, ReportSelection.Usage::"Case Header");
                    if
                    ReportSelection.FindFirst()
                    then
                    ReportID := ReportSelection."Report ID";*/
                    CaseHeaderReport.Run();
                end;
            }
            action(CaseLineReport)
            {
                ApplicationArea = All;
                Image = Report;
                Caption = 'Case Line Report';
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    CaseLineReport: Report CaseLine;
                begin
                    CaseLineReport.Run();
                end;
            }
        }
    }
}
