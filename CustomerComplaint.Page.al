page 55176 CustomerComplaint
{
    PageType = List;
    SourceTable = CustomerComplaint;
    UsageCategory = Lists;
    Caption = 'Customer Complaint';
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
        CustomerComplaint: Record CustomerComplaint;
        var1: Integer;
    begin
        CustomerComplaint.Reset();
        if CustomerComplaint.FindSet()then var1:=1
        else
        begin
            CustomerComplaint.Init();
            CustomerComplaint.Code:='Return For Repair/Return For Credit';
            CustomerComplaint.Description:='Return For Repair/Return For Credit';
            CustomerComplaint.Insert();
            CustomerComplaint.Init();
            CustomerComplaint.Code:='Recieved Wrong Product';
            CustomerComplaint.Description:='Recieved Wrong Product';
            CustomerComplaint.Insert();
            CustomerComplaint.Init();
            CustomerComplaint.Code:='Package Arrived Damaged';
            CustomerComplaint.Description:='Package Arrived Damaged';
            CustomerComplaint.Insert();
        end;
    end;
    procedure ProduceValues(): Text var
        CustomerComplaint: Record CustomerComplaint;
    begin
        CustomerComplaint.Reset();
        CurrPage.SetSelectionFilter(CustomerComplaint);
        if CustomerComplaint.FindFirst()then exit(CustomerComplaint.Code);
    end;
}
