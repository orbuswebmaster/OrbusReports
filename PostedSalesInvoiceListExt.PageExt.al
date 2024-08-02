pageextension 55141 PostedSalesInvoiceListExt extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Location Code")
        {
            field("Industry Shortcut Dimension"; Rec."Industry Shortcut Dimension")
            {
                ApplicationArea = All;
                Caption = 'Industry Code';
                Editable = false;
            }
            field("Created At"; Rec."Created At")
            {
                ApplicationArea = All;
                Caption = 'Sales Order Created At';
            }
            field(Created_By; Rec.Created_By)
            {
                ApplicationArea = All;
                Caption = 'Sales Order Created By';
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Your Reference';
            }
        }
        addbefore("Remaining Amount")
        {
            field("Amount Minus Freight"; Rec."Amount Minus Freight")
            {
                Caption = 'Amount Minus Freight';
                ApplicationArea = All;
                Editable = False;

                trigger OnDrillDown()
                var
                    SalesInvoiceLine: Record "Sales Invoice Line";
                begin
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", Rec."No.");
                    if SalesInvoiceLine.FindSet()then Page.Run(Page::"Posted Sales Invoice Lines", SalesInvoiceLine);
                end;
            }
        }
    }
    actions
    {
        addafter("&Invoice")
        {
            action(GetAssignedUserID)
            {
                ApplicationArea = All;
                Caption = 'Get Assigned User ID';
                Promoted = true;
                PromotedCategory = Process;
                Image = User;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    SalesHeaderArchive: Record "Sales Header Archive";
                    ModSalesInvoiceHeaderRecords: Codeunit ModSalesInvoiceHeaderRecords;
                begin
                    ModSalesInvoiceHeaderRecords.ModifySalesInvoiceHeaderRecords();
                end;
            }
            action(ModifyLocationCode)
            {
                ApplicationArea = All;
                Caption = 'Modify Location Code';
                Promoted = true;
                PromotedCategory = Process;
                Image = Edit;

                trigger OnAction()
                var
                    SDPage: Page ModifyLocationCode;
                begin
                    SDPage.GetValues(Rec."No.", Rec."Location Code");
                    if SDPage.RunModal() = Action::OK then SDPage.ModifySalesInvoiceHeaderRecord();
                end;
            }
        }
    }
    procedure GetSalesOrderNo(): Text var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Reset();
        CurrPage.SetSelectionFilter(SalesInvoiceHeader);
        if SalesInvoiceHeader.FindFirst()then exit(SalesInvoiceHeader."Order No.");
    end;
    procedure GetLocationCode(): Text var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Reset();
        CurrPage.SetSelectionFilter(SalesInvoiceHeader);
        if SalesInvoiceHeader.FindFirst()then exit(SalesInvoiceHeader."Location Code")end;
}
