pageextension 55114 CustomerListPageExt extends "Customer List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Last Invoice Date"; Rec."Last Invoice Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Functions)
        {
            action(CustomStatement)
            {
                Caption = 'Statement';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ShortcutKey = 'Ctrl+Z';

                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    ReportSelections: Record "Report Selections";
                    SelectedReport: Integer;
                    Customer: Record Customer;
                    CustomerListPage: Page "Customer List";
                    CustomerFilter: Text;
                    CustomCustomerStatement: Report "Custom Customer Statement";
                begin
                    ReportSelections.Reset();
                    ReportSelections.SetRange(Usage, ReportSelections.Usage::"C.Statement");
                    ReportSelections.FindFirst();
                    SelectedReport := ReportSelections."Report ID";
                    CLE.Reset();
                    CLE.SetRange("Customer No.", Rec."No.");
                    Report.RunModal(SelectedReport, true, true, CLE);
                end;
            }
            action(CreditCardTransactionsReport)
            {
                ApplicationArea = All;
                Caption = 'Credit Card Transactions';
                Image = Report;
                PromotedCategory = Report;
                Promoted = true;

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    //Report.RunModal(Report::CreditCardTransactions, true, true);
                end;
            }
        }
        modify(Statement)
        {
            Visible = false;
        }
    }
    procedure ProduceValues2(): Text
    var
        Customer: Record Customer;
        var1: Text;
    begin
        var1 := '';
        Customer.Reset();
        CurrPage.SetSelectionFilter(Customer);
        if Customer.FindSet() then
            repeat
                var1 := var1 + Customer.Name + '|';
            until Customer.Next() = 0;
        var1 := DelChr(var1, '>', '|');
        exit(var1);
    end;
    /*trigger OnAfterGetRecord()
        var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        begin
            SalesInvoiceHeader.Reset();
            SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."No.");
            if
            SalesInvoiceHeader.FindLast()
            then
            begin
                if
                Rec."Last Invoice Date" <> SalesInvoiceHeader."Posting Date"
                then
                begin
                    Rec."Last Invoice Date" := SalesInvoiceHeader."Posting Date";
                    Rec.Modify();
                end;
            end;
        end;*/
}
