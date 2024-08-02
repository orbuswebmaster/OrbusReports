page 55141 CaseReasonDetailList
{
    ApplicationArea = All;
    SourceTable = CaseReasonDetail;
    Caption = 'Case Reason Detail List';
    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Code';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        if ApplyFilter = '' then exit
        else
        begin
            Rec.Reset();
            Rec.FilterGroup(11);
            Rec.SetFilter("Reason Code", ApplyFilter);
            Rec.FilterGroup(0);
        end;
    end;
    var ApplyFilter: Text;
    procedure GetValues(var1: Text)
    var
    begin
        ApplyFilter:=var1;
    end;
    procedure ProduceValues(): Text var
        CaseReasonDetail: Record CaseReasonDetail;
    begin
        CaseReasonDetail.Reset();
        CurrPage.SetSelectionFilter(CaseReasonDetail);
        if CaseReasonDetail.FindFirst()then exit(CaseReasonDetail.Code);
    end;
}
