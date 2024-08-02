tableextension 55139 SalesHeaderTableExt extends "Sales Header"
{
    fields
    {
        field(55101; "Warehouse Pick No."; Text[100])
        {
        }
        field(55102; "Registered Warehouse Pick No."; Text[100])
        {
        }
        field(55104; "Payment Type"; Text[100])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'incorrect data type';
        }
        field(55110; "Payment Type (new)"; Text[100])
        {
        }
        field(55111; "Prepayment Receieved"; Enum YesNo)
        {
        }
        field(55112; "Art Email"; Text[250])
        {
        }
        field(55113; "In-Hands Date"; Date)
        {
        }
        field(55114; "Sell-To Contact No. (Custom)"; Code[20])
        {
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                Contact.Reset();
                Contact.SetRange("No.", Rec."Sell-To Contact No. (Custom)");
                if Contact.FindFirst() then
                    exit
                else
                    Error('Data in this table field needs to be based on an existing record (No.) in Contact table');
            end;
        }
        field(55115; "Sell-To Phone No. (Custom)"; Text[30])
        {
        }
        field(55116; "Sell-To Email (Custom)"; Text[80])
        {
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                //Contact.Reset();
                //Contact.SetRange("E-Mail", Rec."Sell-To Email (Custom)");
                //if
                //Contact.FindFirst()
                //then
                //begin
                //Rec."Sell-To Contact No. (Custom)" := Contact."No.";
                //Rec."Sell-To Contact Name (Custom)" := Contact.Name;
                //Rec."Sell-to E-Mail" := Rec."Sell-To Email (Custom)";
                //Rec.Modify();
                //end
                //exit
                //else
                //begin
                //if
                //Dialog.Confirm('There is no record in Contact table with value of ' + Rec."Sell-To Email (Custom)" + ' for email. Would you still like to modify data to this value?', true)
                //then
                //begin
                Rec."Sell-to E-Mail" := Rec."Sell-To Email (Custom)";
                Rec.Modify();
                //end
                //else
                //begin
                //Rec."Sell-To Email (Custom)" := xRec."Sell-To Email (Custom)";
                //Rec.Modify();
                //end;
                //end;
            end;
        }
        field(55117; "Sell-To Contact Name (Custom)"; Text[100])
        {
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                Contact.Reset();
                Contact.SetRange(Name, "Sell-To Contact Name (Custom)");
                if Contact.FindFirst() then
                    exit
                else
                    Error('Data in this table field needs to be based on an exisitng record (Name) in Contact table');
            end;
        }
        field(55118; "Created At"; DateTime)
        {
        }
        field(55119; "Case No."; Text[100])
        {
        }
        field(50122; "Assigned User ID 2"; Text[100])
        {
        }
        field(55123; "Payment Terms OnOpenPage"; Code[50])
        {
        }
        field(55124; "Quote Status"; Enum QuoteStatus)
        {
        }
        field(55125; "Last Followup Date"; Date)
        {
        }
        field(55126; "Next Followup Date"; Date)
        {
        }
        field(55127; "Lead Time"; Integer)
        {
        }
        field(55128; "Ship-to Code (Custom)"; Code[10])
        {
        }
        field(55129; "Ship-to Name (Custom)"; Text[100])
        {
        }
        field(55130; "Ship-to Name 2 (Custom)"; Text[50])
        {
        }
        field(55131; "Ship-to Address (Custom)"; Text[100])
        {
        }
        field(55132; "Ship-to Address 2 (Custom)"; Text[50])
        {
        }
        field(55133; "Ship-to City (Custom)"; Text[30])
        {
        }
        field(55134; "Ship-To County (Custom)"; Text[50])
        {
        }
        field(55135; "Ship-to Contact (Custom)"; Text[100])
        {
        }
        field(55136; "Ship-To Post Code (Custom)"; Text[50])
        {
        }
        field(55137; "Ship-To CountryRegion (Custom)"; Text[50])
        {
        }
        field(55138; "SalesPerson Email"; Text[100])
        {
        }
        field(59501; "Shipping Agent Service Code 2"; Code[10])
        {
        }
        field(59502; "Probability Percentage"; Integer)
        {
        }
        field(59503; "Sell-to-Customer No. Has Value"; Boolean)
        {
        }
        field(59504; "Location Code (Custom)"; Text[50])
        {
        }
        field(59505; "Ship To Data Modified"; Boolean)
        {
        }
        field(59510; "Needs Assessment"; Boolean)
        {
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
            begin
                GetUPSandFedExCodes();
                GetCreatedAt();
                UpdateCustomPaymentTerms();
            end;
        }
        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            var
            begin
                GetCreatedAt();
                UpdateCustomPaymentTerms2();
            end;
        }
        modify("Payment Method Code")
        {
            trigger OnBeforeValidate()
            var
            begin
                if Rec."Payment Terms Code" = 'DR' then begin
                    if Rec."Payment Method Code" = '' then
                        exit
                    else
                        Error('Only value that allowed is "blank" when value is %1 for payment terms code table field', Rec."Payment Terms Code");
                end;
            end;
        }
        modify("Assigned User ID")
        {
            trigger OnAfterValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.FindSet() then SalesLine.ModifyAll("Assigned User ID", Rec."Assigned User ID");
                Rec."Assigned User ID 2" := Rec."Assigned User ID";
                Rec.Modify();
            end;
        }
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                SalesInvoiceHeader: Record "Sales Invoice Header";
                var1: Text;
                DateCreated: Date;
                Days: Integer;
            begin
                if Rec."Document Type" = Rec."Document Type"::Order then begin
                    if Rec."External Document No." = '' then
                        exit
                    else begin
                        var1 := '';
                        SalesHeader.Reset();
                        SalesHeader.SetRange("External Document No.", Rec."External Document No.");
                        if SalesHeader.FindSet() then
                            repeat
                                DateCreated := 0D;
                                Days := 0;
                                DateCreated := DT2Date(SalesHeader.SystemCreatedAt);
                                Days := Today() - DateCreated;
                                if Days < 31 then var1 := var1 + SalesHeader."No." + '|';
                            until SalesHeader.Next() = 0;
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetRange("External Document No.", Rec."External Document No.");
                        if SalesInvoiceHeader.FindSet() then
                            repeat
                                DateCreated := 0D;
                                Days := 0;
                                DateCreated := DT2Date(SalesInvoiceHeader.SystemCreatedAt);
                                Days := Today() - DateCreated;
                                if Days < 31 then var1 := var1 + SalesInvoiceHeader."No." + '|';
                            until SalesInvoiceHeader.Next() = 0;
                        var1 := DelChr(var1, '>', '|');
                        if var1 <> '' then Message('Sales Header/Sales Invoice Header records with same external doc. nos: %1', var1);
                    end;
                end;
            end;
        }
        modify("Your Reference")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                SalesInvoiceHeader: Record "Sales Invoice Header";
                var1: Text;
                DateCreated: Date;
                Days: Integer;
            begin
                if Rec."Document Type" = Rec."Document Type"::Order then begin
                    if Rec."Your Reference" = '' then
                        exit
                    else begin
                        var1 := '';
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Your Reference", Rec."Your Reference");
                        if SalesHeader.FindSet() then
                            repeat
                                DateCreated := 0D;
                                Days := 0;
                                DateCreated := DT2Date(SalesHeader.SystemCreatedAt);
                                Days := Today() - DateCreated;
                                if Days < 31 then var1 := var1 + SalesHeader."No." + '|';
                            until SalesHeader.Next() = 0;
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetRange("Your Reference", Rec."Your Reference");
                        if SalesInvoiceHeader.FindSet() then
                            repeat
                                DateCreated := 0D;
                                Days := 0;
                                DateCreated := DT2Date(SalesInvoiceHeader.SystemCreatedAt);
                                Days := Today() - DateCreated;
                                if Days < 31 then var1 := var1 + SalesInvoiceHeader."No." + '|';
                            until SalesInvoiceHeader.Next() = 0;
                        var1 := DelChr(var1, '>', '|');
                        if var1.Contains(Rec."No.") then var1 := var1.Replace(Rec."No.", '');
                        if var1.StartsWith('|') then var1 := DelChr(var1, '<', '|');
                        if var1 <> '' then Message('Sales Header/Sales Invoice Header records with same "Your Reference No": %1', var1);
                    end;
                end;
            end;
        }
        modify("Ship-to Name")
        {
            trigger OnBeforeValidate()
            var
            begin
                Max35CharacterLimit(Rec."Ship-to Name", Rec.FieldName(Rec."Ship-to Name"));
            end;
        }
        modify("Ship-to Address")
        {
            trigger OnBeforeValidate()
            var
            begin
                Max35CharacterLimit(Rec."Ship-to Address", Rec.FieldName(Rec."Ship-to Address"));
            end;
        }
        modify("Ship-to Address 2")
        {
            trigger OnBeforeValidate()
            var
            begin
                Max35CharacterLimit(Rec."Ship-to Address 2", Rec.FieldName(Rec."Ship-to Address 2"));
            end;
        }
        modify("Ship-to Contact")
        {
            trigger OnBeforeValidate()
            var
            begin
                Max35CharacterLimit(Rec."Ship-to Contact", Rec.FieldName(Rec."Ship-to Contact"))
            end;
        }
    }
    trigger OnAfterInsert()
    var
    begin
        GetCreatedAt();
        if Rec."Shipping Agent Service Code 2" <> Rec."Shipping Agent Service Code" then begin
            Rec."Shipping Agent Service Code 2" := Rec."Shipping Agent Service Code";
            Rec.Modify();
        end;
    end;

    trigger OnModify()
    var
        DSHIPPackageOptions: Record "DSHIP Package Options";
    begin
        /*if
                (Rec."Payment Terms Code" = 'CC') and (Rec."Payment Method Code" <> 'CREDITCARD')
            then
                Error('Need to modify data in payment method code table field to "CREDITCARD" before you can modify any other table field for this record. Current valuye is: %1', Rec."Payment Method Code");
            end;*/
        if Rec."Payment Type (new)" = '' then begin
            DSHIPPackageOptions.Reset();
            DSHIPPackageOptions.SetRange("Document No.", Rec."No.");
            if DSHIPPackageOptions.FindFirst() then begin
                Rec."Payment Type (new)" := Format(DSHIPPackageOptions."Payment Type", 0, '<Text>');
                //Rec.Modify();
            end;
        end;
        if Rec."Created At" <> Rec.SystemCreatedAt then begin
            Rec."Created At" := Rec.SystemCreatedAt;
            //Rec.Modify();
        end;
    end;

    procedure GetUPSandFedExCodes()
    var
        Customer: Record Customer;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."No.");
        if SalesHeader.FindFirst() then begin
            if Rec."Document Type" = Rec."Document Type"::Order then begin
                Customer.Reset();
                Customer.SetRange("No.", Rec."Sell-to Customer No.");
                if Customer.FindFirst() then begin
                    Rec."UPS Account Number" := Customer."UPS Account Number";
                    Rec."FedEx Account Number" := Customer."FedEx Account Number";
                    Rec.Modify();
                end;
            end;
        end
        else begin
            if Rec."Document Type" = Rec."Document Type"::Order then begin
                Customer.Reset();
                Customer.SetRange("No.", Rec."Sell-to Customer No.");
                if Customer.FindFirst() then begin
                    Rec."UPS Account Number" := Customer."UPS Account Number";
                    Rec."FedEx Account Number" := Customer."FedEx Account Number";
                end;
            end;
        end;
    end;

    procedure GetCreatedAt()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."No.");
        if SalesHeader.FindFirst() then begin
            if Rec."Created At" = 0DT then begin
                Rec."Created At" := CurrentDateTime();
                Rec.Modify();
            end;
        end
        else if Rec."Created At" = 0DT then Rec."Created At" := CurrentDateTime();
    end;

    procedure UpdateCustomPaymentTerms()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."No.");
        if SalesHeader.FindFirst() then begin
            Customer.Reset();
            Customer.SetRange("No.", Rec."Sell-to Customer No.");
            if Customer.FindFirst() then begin
                Rec."Payment Terms OnOpenPage" := Customer."Payment Terms Code";
                Rec.Modify();
            end;
        end
        else begin
            Customer.Reset();
            Customer.SetRange("No.", Rec."Sell-to Customer No.");
            if Customer.FindFirst() then begin
                Rec."Payment Terms OnOpenPage" := Customer."Payment Terms Code";
            end;
        end;
    end;

    procedure UpdateCustomPaymentTerms2()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."No.");
        if SalesHeader.FindFirst() then begin
            Customer.Reset();
            Customer.SetRange(Name, Rec."Sell-to Customer Name");
            if Customer.FindFirst() then begin
                Rec."Payment Terms OnOpenPage" := Customer."Payment Terms Code";
                Rec.Modify();
            end;
        end
        else begin
            Customer.Reset();
            Customer.SetRange(Name, Rec."Sell-to Customer Name");
            if Customer.FindFirst() then begin
                Rec."Payment Terms OnOpenPage" := Customer."Payment Terms Code";
            end;
        end;
    end;

    procedure Max35CharacterLimit(var1: Text; var2: Text)
    var
    begin
        if StrLen(var1) > 35 then Error('Max character limit for table field: %1 is 35 characters. Number of characters entered: %2', var2, StrLen(var1));
    end;
}
