pageextension 55123 SalesOrderDocumentPageExt extends "Sales Order"
{
    layout
    {
        addafter(WorkDescription)
        {
            field("Prepayment Receieved"; Rec."Prepayment Receieved")
            {
                Caption = 'Prepayment Received';
                ApplicationArea = All;
                Editable = true;
            }
        }
        modify(ArtEmail)
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                Salesperson: Record "Salesperson/Purchaser";
            begin
                Salesperson.Reset();
                Salesperson.SetRange(Code, Rec."Salesperson Code");
                if Salesperson.FindFirst() then begin
                    Rec."SalesPerson Email" := Salesperson."E-Mail";
                    Rec.Modify();
                end;
            end;
        }
        addafter("Sell-to Country/Region Code")
        {
            field("Sell-To Contact No. (Custom)"; Rec."Sell-To Contact No. (Custom)")
            {
                ApplicationArea = All;
                Caption = 'Sell-To Contact No.';
                ShowMandatory = true;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Contact: Record Contact;
                    ContactListPage: Page "Contact List";
                begin
                    Contact.Reset();
                    Contact.SetRange("Company Name", Rec."Sell-to Customer Name");
                    if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                        Rec."Sell-To Contact No. (Custom)" := Contact."No.";
                        Rec."Sell-to Contact No." := Contact."No.";
                        Rec."Sell-To Email (Custom)" := Contact."E-Mail";
                        Rec."Sell-to E-Mail" := Contact."E-Mail";
                        Rec."Sell-To Phone No. (Custom)" := Contact."Phone No.";
                        Rec."Sell-to Phone No." := Contact."Phone No.";
                        Rec."Sell-To Contact Name (Custom)" := Contact.Name;
                        Rec."Sell-to Contact" := Contact.Name;
                        Rec."Bill-to Contact No." := Contact."No.";
                        Rec."Bill-to Contact" := Contact.Name;
                        //Rec."Ship-to Contact":=Contact.Name;
                        Rec.Modify();
                    end;
                end;
            }
            field("Sell-To Contact Name (Custom)"; Rec."Sell-To Contact Name (Custom)")
            {
                ApplicationArea = All;
                Caption = 'Sell-To Contact Name';

                trigger OnLookup(var Text: Text): Boolean
                var
                    Contact: Record Contact;
                    ContactListPage: Page "Contact List";
                begin
                    Contact.Reset();
                    Contact.SetRange("Company Name", Rec."Sell-to Customer Name");
                    if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                        Rec."Sell-To Contact No. (Custom)" := Contact."No.";
                        Rec."Sell-to Contact No." := Contact."No.";
                        Rec."Sell-To Email (Custom)" := Contact."E-Mail";
                        Rec."Sell-to E-Mail" := Contact."E-Mail";
                        Rec."Sell-To Phone No. (Custom)" := Contact."Phone No.";
                        Rec."Sell-to Phone No." := Contact."Phone No.";
                        Rec."Sell-To Contact Name (Custom)" := Contact.Name;
                        Rec."Sell-to Contact" := Contact.Name;
                        Rec."Bill-to Contact No." := Contact."No.";
                        Rec."Bill-to Contact" := Contact.Name;
                        //Rec."Ship-to Contact":=Contact.Name;
                        Rec.Modify();
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
        modify("Sell-to Phone No.")
        {
            Visible = false;
        }
        modify("Sell-to E-Mail")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Editable = EditableVar;
            ShowMandatory = MandatoryVar;

            trigger OnBeforeValidate()
            var
            begin
                if Rec."Payment Terms Code" = 'CC' then begin
                    if (Rec."Payment Method Code" = 'CREDITCARD') or (Rec."Payment Method Code" = '') then
                        exit
                    else
                        Error('Only value that is allowed is "Credit Card" or blank value since data/value in payment terms code table field is currently "CC" for this record');
                end;
            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
                SalesOrderDocumentPage: Page "Sales Order";
                var1: Text;
            begin
                if Rec."Payment Terms Code" = 'CC' then
                    MandatoryVar := true
                else
                    MandatoryVar := false;
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId());
                if UserSetup.FindFirst() then begin
                    if (UserSetup."Terms Control" = true) then begin
                        if (Rec."Payment Terms OnOpenPage" = 'CC') or (Rec."Payment Terms OnOpenPage" = 'DR') then begin
                            if Rec."Payment Terms OnOpenPage" = 'CC' then begin
                                if Rec."Payment Terms Code" = 'CC' then
                                    exit
                                else begin
                                    if Rec."Payment Terms Code" = 'DR' then begin
                                        Rec."Payment Terms OnOpenPage" := Rec."Payment Terms Code";
                                        Rec.Modify();
                                    end
                                    else
                                        Error('Value currently in payment terms table field is %1. Can only modify value in this table field to "DR" value', Rec."Payment Terms OnOpenPage");
                                end;
                            end;
                            if Rec."Payment Terms OnOpenPage" = 'DR' then begin
                                if Rec."Payment Terms Code" = 'DR' then
                                    exit
                                else begin
                                    if Rec."Payment Terms Code" = 'CC' then begin
                                        Rec."Payment Terms OnOpenPage" := Rec."Payment Terms Code";
                                        Rec.Modify()
                                    end
                                    else
                                        Error('Value currently stored in payment terms table field is %1. Can only modify value in this table field to "CC"', Rec."Payment Terms OnOpenPage");
                                end
                            end;
                        end
                        else
                            Error('Cannot modify data/value in payment terms table field due to value not being either "CC" or "DR". Current value: %1', Rec."Payment Terms OnOpenPage");
                    end
                    else begin
                        if Rec."Payment Terms OnOpenPage" <> Rec."Payment Terms Code" then begin
                            Rec."Payment Terms OnOpenPage" := Rec."Payment Terms Code";
                            Rec.Modify();
                        end;
                    end;
                end
            end;
        }
        modify("EFT Payment Method Code -CL-")
        {
            Editable = EditableVar;
        }
        addafter("Needs Approval")
        {
            field("Art Email"; Rec."Art Email")
            {
                ApplicationArea = All;
                Caption = 'Email Art';
            }
            field("Needs Assessment"; Rec."Needs Assessment")
            {
                ApplicationArea = All;
                Caption = 'Needs Assessment';
            }
        }
        addafter("Due Date")
        {
            field("In-Hands Date"; Rec."In-Hands Date")
            {
                ApplicationArea = All;
                Caption = 'In-Hands Date';
            }
            field("Case No."; Rec."Case No.")
            {
                ApplicationArea = All;
                Caption = 'Case No.';
            }
        }
        addafter("Salesperson Code")
        {
            field("SalesPerson Email"; Rec."SalesPerson Email")
            {
                ApplicationArea = All;
            }
        }
        modify("Shipping Agent Service Code")
        {
            ShowMandatory = true;

            trigger OnAfterValidate()
            var
            begin
                Rec."Shipping Agent Service Code 2" := Rec."Shipping Agent Service Code";
                Rec.Modify();
            end;
        }
        modify("Shipping Agent Code")
        {
            ShowMandatory = true;
        }
    }
    actions
    {
        addafter("Work Order")
        {
            action(PrintProductionOrder)
            {
                Caption = 'Production Order';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category11;
                Image = Print;

                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange("Source No.", Rec."No.");
                    Report.RunModal(Report::"Custom Production Order", true, true, ProductionOrder);
                end;
            }
            action(InetrnalReprintReport)
            {
                ApplicationArea = All;
                Caption = 'Internal Reprint Report';
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;

                trigger OnAction()
                var
                    InternalReprintReport: Report InternalReprint;
                    ProductionHeader: Record "Production Order";
                    ProductionHeaderNo: Text;
                begin
                    ProductionHeader.Reset();
                    ProductionHeader.SetFilter(Status, 'Released|Finished');
                    ProductionHeader.SetRange("Source No.", Rec."No.");
                    if ProductionHeader.FindLast() then
                        ProductionHeaderNo := ProductionHeader."No."
                    else
                        ProductionHeaderNo := '';
                    InternalReprintReport.GetValues(Rec."No.", Rec."Sell-to Customer Name", Rec."Shipment Date", Rec."Shipping Agent Code", Rec."Shipping Agent Service Code", ProductionHeaderNo, Rec."Assigned User ID", Rec."Location Code");
                    InternalReprintReport.RunModal();
                end;
            }
        }
        /*addafter(Post)
        {
            action(UpdateDimensions)
            {
                ApplicationArea = All;
                Caption = 'Update Dimensions';
                Promoted = true;
                PromotedCategory = Category6;
                Image = ChangeDimensions;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    SalesOrderSubform: Page "Sales Order Subform";
                begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", Rec."No.");
                    if
                    SalesLine.FindSet()
                    then
                        repeat
                            SalesOrderSubform.UpdateDimValues(SalesLine."Shortcut Dimension 3 (Value)", SalesLine."Shortcut Dimension 4 (Value)", SalesLine."Shortcut Dimension 5 (Value)", SalesLine."Shortcut Dimension 6 (Value)", SalesLine."Shortcut Dimension 7 (Value)", SalesLine."Shortcut Dimension 8 (Value)");
                        until
                        SalesLine.Next() = 0
                end;
            }
        }*/
        modify(Release)
        {
            trigger OnBeforeAction()
            var
            begin
                if (Rec."Shipping Agent Code" = '') and (Rec."Shipping Agent Service Code" = '') then Error('Shipping Agent Code and Shipping Agent Service have a value of "blank". Both fields need a value other than "blank"');
                if (Rec."Shipping Agent Code" = '') then Error('Shipping Agent Code cannot have a value of "blank"');
                if Rec."Shipping Agent Service Code" = '' then Error('Shipping Agent Service Code cannot have a value of "blank"');
            end;
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
    begin
        if Rec."Sell-To Contact No. (Custom)" = '' then Error('"Sell-To-Contact No." table field must have a value other than blank before page can close. Current value is "blank"');
        if (Rec."Payment Terms Code" = 'CC') then begin
            if Rec."Payment Method Code" = 'CREDITCARD' then
                exit
            else
                Error('Payment Terms code has a value of: %1. Modify Payment Method Code value to "CREDITCARD".', Rec."Payment Terms Code");
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst() then if UserSetup."Can Delete Sales Orders" = false then Error('Your user: %1 is not allowed to delete sales orders', UserId());
    end;

    trigger OnClosePage()
    var
        DSHIPPackageOptions: Record "DSHIP Package Options";
    begin
        if Rec."Payment Type (new)" = '' then begin
            DSHIPPackageOptions.Reset();
            DSHIPPackageOptions.SetRange("Document No.", Rec."No.");
            if DSHIPPackageOptions.FindFirst() then begin
                Rec."Payment Type (new)" := Format(DSHIPPackageOptions."Payment Type", 0, '<Text>');
                Rec.Modify();
            end;
        end;
    end;

    trigger OnOpenPage()
    var
        SalesHeader: Record "Sales Header";
    begin
        if Rec."Shipping Agent Service Code 2" <> Rec."Shipping Agent Service Code" then begin
            Rec."Shipping Agent Service Code 2" := Rec."Shipping Agent Service Code";
            Rec.Modify();
        end;
        if Rec."Created At" <> Rec.SystemCreatedAt then begin
            Rec."Created At" := Rec.SystemCreatedAt;
            Rec.Modify();
        end;
        if Rec."Payment Terms OnOpenPage" <> Rec."Payment Terms Code" then begin
            Rec."Payment Terms OnOpenPage" := Rec."Payment Terms Code";
            Rec.Modify();
        end;
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst() then begin
            if UserSetup."Payment Method Block" = true then
                EditableVar := false
            else
                EditableVar := true
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        SalesPerson: Record "Salesperson/Purchaser";
    begin
        if Rec."SalesPerson Email" = '' then begin
            SalesPerson.Reset();
            SalesPerson.SetRange(Code, Rec."Salesperson Code");
            if SalesPerson.FindFirst() then begin
                if SalesPerson."E-Mail" = '' then
                    exit
                else begin
                    Rec."SalesPerson Email" := SalesPerson."E-Mail";
                    Rec.Modify();
                end;
            end;
        end;
    end;

    procedure GetPaymentTermValue(var1: Text)
    var
    begin
        PaymentTermVar := var1;
    end;

    procedure ProducePaymentTermValue(): Text
    var
    begin
        exit(PaymentTermVar)
    end;

    var
        EditableVar: Boolean;
        PaymentTermVar: Text;
        VisibleVar: Boolean;
        MandatoryVar: Boolean;
}
