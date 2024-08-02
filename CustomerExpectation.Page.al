page 55177 CustomerExpectation
{
    PageType = List;
    SourceTable = CustomerExpectation;
    UsageCategory = Lists;
    Caption = 'Customer Expectation';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field(Code; Rec.Code)
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
    trigger OnOpenPage()
    var
        CustomerExpectation: Record CustomerExpectation;
        var1: Integer;
    begin
        CustomerExpectation.Reset();
        if CustomerExpectation.FindSet()then var1:=1
        else
        begin
            CustomerExpectation.Init();
            CustomerExpectation.Code:='Credit';
            CustomerExpectation.Description:='Credit';
            CustomerExpectation.Insert();
            CustomerExpectation.Init();
            CustomerExpectation.Code:='Item Replacement';
            CustomerExpectation.Description:='Item Replacement';
            CustomerExpectation.Insert();
            CustomerExpectation.Init();
            CustomerExpectation.Code:='Return For Credit: Return For Repair';
            CustomerExpectation.Description:='Return For Credit: Return For Repair';
            CustomerExpectation.Insert();
            CustomerExpectation.Init();
            CustomerExpectation.Code:='Other';
            CustomerExpectation.Description:='Other';
            CustomerExpectation.Insert();
        end;
    end;
    procedure ProduceValues(): Text var
        CustomerExpectation: Record CustomerExpectation;
    begin
        CustomerExpectation.Reset();
        CurrPage.SetSelectionFilter(CustomerExpectation);
        if CustomerExpectation.FindFirst()then exit(CustomerExpectation.Code);
    end;
}
