pageextension 55115 CustomerCardPageExt extends "Customer Card"
{
    layout
    {
        addafter(ContactName)
        {
            field("Magento Contact No."; Rec."Magento Contact No.")
            {
                ApplicationArea = All;
                Caption = 'Magento Contact No.';

                trigger OnLookup(var Text: Text): Boolean var
                    Contact: Record Contact;
                    ContactListPage: Page "Contact List";
                    var1: Text;
                begin
                    Contact.Reset();
                    Contact.FilterGroup(20);
                    Contact.SetRange("Company Name", Rec.Name);
                    if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                        Rec."Magento Contact No.":=Contact."No.";
                        Rec."Magento Contact Name":=Contact.Name;
                        Rec."Magento Contact Email":=Contact."E-Mail";
                        Rec.Modify();
                    end;
                    Contact.FilterGroup(0);
                end;
                trigger OnValidate()
                var
                    Contact: Record Contact;
                begin
                    Contact.Reset();
                    Contact.SetRange("No.", Rec."Magento Contact No.");
                    if Contact.FindFirst()then exit
                    else
                        Error('Data in this table field nees to equal an exisiting Contact No.');
                end;
            }
            field("Magento Contact Name"; Rec."Magento Contact Name")
            {
                ApplicationArea = All;
                Caption = 'Magento Contact Name';

                trigger OnLookup(var Text: Text): Boolean var
                    Contact: Record Contact;
                    ContactListPage: Page "Contact List";
                    var1: Text;
                begin
                    Contact.Reset();
                    Contact.FilterGroup(20);
                    Contact.SetRange("Company Name", Rec.Name);
                    if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                        Rec."Magento Contact Name":=Contact.Name;
                        Rec."Magento Contact No.":=Contact."No.";
                        Rec."Magento Contact Email":=Contact."E-Mail";
                        Rec.Modify();
                    end;
                    Contact.FilterGroup(0);
                end;
                trigger OnValidate()
                var
                    Contact: Record Contact;
                begin
                    Contact.Reset();
                    Contact.SetRange(Name, Rec."Magento Contact Name");
                    if Contact.FindFirst()then exit
                    else
                        Error('Data in this table field needs to equal an exisiting Contact Name');
                end;
            }
            field("Magento Contact Email"; Rec."Magento Contact Email")
            {
                ApplicationArea = All;
                Caption = 'Magento Contact Email';
                Editable = false;
            }
        }
        addafter("Needs Approval")
        {
            field("Last Invoice Date"; Rec."Last Invoice Date")
            {
                ApplicationArea = All;
                Caption = 'Last Invoice Date';
                Editable = false;

                trigger OnDrillDown()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."No.");
                    if SalesInvoiceHeader.FindLast()then Page.Run(Page::"Posted Sales Invoice", SalesInvoiceHeader);
                end;
            }
            group(test)
            {
                ShowCaption = false;
                Visible = VisibleVar1;

                field(UpdateLastInvoiceDate; UpdateLastInvoiceDate)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        if SalesInvoiceHeader.FindLast()then begin
                            Rec."Last Invoice Date":=SalesInvoiceHeader."Posting Date";
                            if Rec.Modify()then VisibleVar1:=false
                            else
                                VisibleVar1:=true;
                        end;
                    end;
                }
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            action(CustomStatement)
            {
                Caption = 'Statement';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    ReportSelections: Record "Report Selections";
                    SelectedReport: Integer;
                begin
                    ReportSelections.Reset();
                    ReportSelections.SetRange(Usage, ReportSelections.Usage::"C.Statement");
                    ReportSelections.FindFirst();
                    SelectedReport:=ReportSelections."Report ID";
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
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    Time1: Time;
                    var1: Decimal;
                    var2: Text;
                    var3: Text;
                    var4: Text;
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst()then Report.RunModal(Report::CreditCardTransactions, true, true, SalesInvoiceHeader);
                    var1:=1.18;
                    if(var1 > 1.13) and (var1 <= 1.25)then var1:=1.25;
                    Message('%1', Format(var1));
                end;
            }
        /*action(UpdateLastInvoiceDate)
            {
                ApplicationArea = All;
                Caption = 'Update Last Invoice Date';
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."No.");
                    if
                    SalesInvoiceHeader.FindLast()
                    then begin
                        if
                        Rec."Last Invoice Date" <> SalesInvoiceHeader."Posting Date"
                        then begin
                            Rec."Last Invoice Date" := SalesInvoiceHeader."Posting Date";
                            Rec.Modify();
                        end;
                    end;
                end;
            }*/
        }
        modify("Report Statement")
        {
            Visible = false;
        }
    }
    var UpdateLastInvoiceDate: Text;
    VisibleVar1: Boolean;
    trigger OnAfterGetCurrRecord()
    var
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        UpdateLastInvoiceDate:='Update Last Invoice Date (Not up-to-date)';
        Customer.Reset();
        Customer.SetRange("No.", Rec."No.");
        if Customer.FindFirst()then begin
            SalesInvoiceHeader.Reset();
            SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."No.");
            if SalesInvoiceHeader.FindLast()then begin
                if Rec."Last Invoice Date" = SalesInvoiceHeader."Posting Date" then VisibleVar1:=false
                else
                    VisibleVar1:=true;
            end;
        end;
    end;
}
