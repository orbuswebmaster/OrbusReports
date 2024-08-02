page 55121 PostedSalesInvoicesWS2
{
    ApplicationArea = All;
    SourceTable = "Sales Invoice Header";
    PageType = API;
    EntityName = 'PostedSalesInvoicesWS2';
    EntitySetName = 'PostedSalesInvoicesWS2';
    APIPublisher = 'Orbus';
    APIGroup = 'Orbus';
    DelayedInsert = true;
    Caption = 'Sales Invoice Header API';

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field(SelltoCustomerName; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field(SelltoEmail; Rec."Sell-to E-Mail")
                {
                    ApplicationArea = All;
                }
                field("SelltoContactNo"; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field(SelltoContactName; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field(OrderNo; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(ExternalDocumentNo; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Custom; Rec.Custom)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(SalespersonCode; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field(SalesPersonEmail; Rec."SalesPerson Email")
                {
                    ApplicationArea = All;
                }
                field(CreatedBy; Rec.Created_By)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
