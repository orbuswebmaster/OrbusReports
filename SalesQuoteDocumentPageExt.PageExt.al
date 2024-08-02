pageextension 55189 SalesQuoteDocumentPageExt extends "Sales Quote"
{
    layout
    {
        addafter(Status)
        {
            field("Quote Status"; Rec."Quote Status")
            {
                ApplicationArea = All;
                Caption = 'Quote Status';
            }
            field("Last Followup Date"; Rec."Last Followup Date")
            {
                ApplicationArea = All;
                Caption = 'Last Follow Up Date';
            }
            field("Next Followup Date"; Rec."Next Followup Date")
            {
                ApplicationArea = All;
                Caption = 'Next Follow Up Date';
            }
            field("Lead Time"; Rec."Lead Time")
            {
                ApplicationArea = All;
                Caption = 'Lead Time';
            }
            field("Probability Percentage"; Rec."Probability Percentage")
            {
                ApplicationArea = All;
                Caption = 'Probability Percentage';
            }
        }
        addafter("Sell-to Country/Region Code")
        {
            field("Sell-To Contact No. (Custom)"; Rec."Sell-To Contact No. (Custom)")
            {
                ApplicationArea = All;
                Caption = 'Sell-To Contact No.';
                ShowMandatory = MandatoryVar;

                trigger OnLookup(var Text: Text): Boolean var
                    Contact: Record Contact;
                    ContactListPage: Page "Contact List";
                begin
                    Contact.Reset();
                    Contact.SetRange("Company Name", Rec."Sell-to Customer Name");
                    if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                        Rec."Sell-To Contact No. (Custom)":=Contact."No.";
                        Rec."Sell-To Contact Name (Custom)":=Contact.Name;
                        Rec."Sell-To Phone No. (Custom)":=Contact."Phone No.";
                        Rec."Sell-To Email (Custom)":=Contact."E-Mail";
                        Rec."Sell-to Contact":=Contact.Name;
                        Rec."Sell-to Contact No.":=Contact."No.";
                        Rec."Sell-to E-Mail":=Contact."E-Mail";
                        Rec."Sell-to Phone No.":=Contact."Phone No.";
                        Rec."Bill-to Contact":=Contact.Name;
                        Rec."Bill-to Contact No.":=Contact."No.";
                        Rec."Ship-to Contact":=Contact.Name;
                    end;
                end;
                trigger OnValidate()
                var
                begin
                    if Rec."Sell-To Contact No. (Custom)" = '' then MandatoryVar:=true
                    else
                        MandatoryVar:=false;
                end;
            }
            field("Sell-To Contact Name (Custom)"; Rec."Sell-To Contact Name (Custom)")
            {
                ApplicationArea = All;
                Caption = 'Sell-To Contact Name';

                trigger OnLookup(var Text: Text): Boolean var
                    Contact: Record Contact;
                    ContactListPage: Page "Contact List";
                begin
                    Contact.Reset();
                    Contact.SetRange("Company Name", Rec."Sell-to Customer Name");
                    if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                        Rec."Sell-To Contact No. (Custom)":=Contact."No.";
                        Rec."Sell-To Contact Name (Custom)":=Contact.Name;
                        Rec."Sell-To Phone No. (Custom)":=Contact."Phone No.";
                        Rec."Sell-To Email (Custom)":=Contact."E-Mail";
                        Rec."Sell-to Contact":=Contact.Name;
                        Rec."Sell-to Contact No.":=Contact."No.";
                        Rec."Sell-to E-Mail":=Contact."E-Mail";
                        Rec."Sell-to Phone No.":=Contact."Phone No.";
                        Rec."Bill-to Contact":=Contact.Name;
                        Rec."Bill-to Contact No.":=Contact."No.";
                        Rec."Ship-to Contact":=Contact.Name;
                    end;
                end;
            }
            field("Sell-To Phone No. (Custom)"; Rec."Sell-To Phone No. (Custom)")
            {
                ApplicationArea = All;
                Caption = 'Sell-To Phone No.';
            }
            field("Sell-To Email (Custom)"; Rec."Sell-To Email (Custom)")
            {
                ApplicationArea = All;
                Caption = 'Sell-To Email';
            }
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify(SellToPhoneNo)
        {
            Visible = false;
        }
        modify(SellToEmail)
        {
            Visible = false;
        }
    }
    var MandatoryVar: Boolean;
    trigger OnOpenPage()
    var
    begin
        if Rec."Sell-To Contact No. (Custom)" = '' then MandatoryVar:=true
        else
            MandatoryVar:=false;
    end;
    trigger OnQueryClosePage(CloseAction: Action): Boolean var
    begin
        if Rec."Sell-To Contact No. (Custom)" = '' then Error('Sell-To-Contact No. table field cannot have value of "blank". Modify data for Sell-To-Contact No. tbale field to a value other than blank.');
    end;
}
