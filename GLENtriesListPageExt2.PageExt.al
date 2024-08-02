pageextension 55154 GLENtriesListPageExt2 extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field(SalesPerson; Rec.SalesPerson)
            {
                ApplicationArea = All;
                Caption = 'SalesPerson';
            }
        }
        addafter("Source No.")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                Caption = 'Customer Name';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        GetCustomerName: Codeunit GetCustomerNameForGLEntries2;
    begin
        GetCustomerName.Run(Rec);
    end;
}
