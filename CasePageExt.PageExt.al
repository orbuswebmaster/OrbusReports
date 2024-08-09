pageextension 55159 CasePageExt extends "Case Card WSG"
{
    layout
    {
        addafter(General)
        {
            group(LoggingTheIssue)
            {
                Caption = 'Logging The Issue';

                field("Customer Complaint"; Rec."Customer Complaint")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustomerComplaintList: page CustomerComplaint;
                        var1: Integer;
                    begin
                        CustomerComplaintList.LookupMode(true);
                        if CustomerComplaintList.RunModal() = Action::LookupOK then begin
                            Rec."Customer Complaint" := CustomerComplaintList.ProduceValues();
                            if Rec.Modify() then
                                var1 := 1
                            else
                                Error('Record did not successfully get modified. Please try again.');
                        end;
                    end;

                    trigger OnValidate()
                    var
                        CustomerComplaint: Record CustomerComplaint;
                        var1: Integer;
                    begin
                        CustomerComplaint.Reset();
                        CustomerComplaint.SetFilter(Code, Rec."Customer Complaint");
                        if CustomerComplaint.FindFirst() then
                            var1 := 1
                        else
                            Error('"Customer Complaint" table field has to be based on record in "Customer Complaint" table object');
                    end;
                }
                field("Customer Expectation"; Rec."Customer Expectation")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustomerExpectationList: Page CustomerExpectation;
                        var1: Integer;
                    begin
                        CustomerExpectationList.LookupMode(true);
                        if CustomerExpectationList.RunModal() = Action::LookupOK then begin
                            Rec."Customer Expectation" := CustomerExpectationList.ProduceValues();
                            if Rec.Modify() then
                                var1 := 1
                            else
                                Error('Record did not successfully get modified. Please try again.');
                        end;
                    end;

                    trigger OnValidate()
                    var
                        CustomerExpectation: Record CustomerExpectation;
                        var1: Integer;
                    begin
                        CustomerExpectation.Reset();
                        CustomerExpectation.SetFilter(Code, Rec."Customer Expectation");
                        if CustomerExpectation.FindFirst() then
                            var1 := 1
                        else
                            Error('"Customer Expectation" table field has to be based on record in "Customer Expectation" table object');
                    end;
                }
                field("Must Arrive Date"; Rec."Must Arrive Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = MandatoryVarDescribeMustArriveDate;

                    trigger OnValidate()
                    var
                    begin
                        if Rec.Modify() then CurrPage.Update(false);
                    end;
                }
                /*field(OverallTextValue;OverallTextValue)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                field(DescribeIssue; DescribeIssue)
                {
                    ApplicationArea = All;
                    Caption = 'Describe Issue';

                    trigger OnValidate()
                    var
                    var1: Integer;
                    TempBlob: Codeunit "Temp Blob";
                    Inst: InStream;
                    Out: OutStream;
                    TextValue: Text;
                    LineBreak: Text;
                    TypeHelper: Codeunit "Type Helper";
                    TextValue2: Text;
                    begin

                        TextValue := '';
                        TextValue2 := '';
                        LineBreak := TypeHelper.CRLFSeparator();

                        if
                        DescribeIssue = ''
                        then
                        var1 := 1
                        else
                        begin
                            if
                            Dialog.Confirm('Would you like to add this text to the .txt file?', true)
                            then
                            begin
                                TextValue2 := OverallTextValue + LineBreak + LineBreak + DescribeIssue;
                                TempBlob.CreateInStream(Inst);
                                TempBlob.CreateOutStream(Out);
                                Out.WriteText(TextValue2);
                                Rec."Describe Issue".CreateOutStream(Out);
                                CopyStream(Out, Inst);
                                if
                                Rec.Modify()
                                then
                                begin
                                    OverallTextValue := OverallTextValue + LineBreak + LineBreak + DescribeIssue;
                                    DescribeIssue := '';
                                    Message('Succesfully added text to .txt file');
                                end
                                else
                                Message('Text value in "Describe Issue" global page variable was not added to .txt file. Please try again');
                            end;
                        end;
                    end;
                }

                field(DownloadDesribeIssueText; DownloadDesribeIssueText)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                    Inst: Instream;
                    Out: OutStream;
                    FileName: text;
                    var1: Integer;
                    TextValue: Text;
                    begin

                        FileName := 'DescribeIssueText_CaseNo_' + Rec."No." + '.txt';

                        Rec."Describe Issue".CreateInStream(Inst);
                        Rec.CalcFields("Describe Issue");
                        if
                        DownloadFromStream(Inst, '', '', '', FileName)
                        then
                        var1 := 1
                        else
                        Message('File did not successfully download. Please try again');


                    end;
                }*/
                group(ShipTo)
                {
                    Caption = 'Ship To Address: Is This Address Correct?';

                    field("Ship To Name"; Rec."Ship To Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Contact"; Rec."Ship To Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Address"; Rec."Ship To Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Address 2"; Rec."Ship To Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = All;
                    }
                    field(State; Rec.State)
                    {
                        ApplicationArea = All;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                    }
                }
                group(DescribeIssueGroup)
                {
                    ShowCaption = false;

                    field("Describe Issue"; Rec."Describe Issue")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        ColumnSpan = 2;
                        //ShowMandatory = MandatoryVarDescribeIssue;
                    }
                }
            }
            group(Product)
            {
                Caption = 'Product';

                part(CaseLineListPart; CaseLineListPart)
                {
                    ApplicationArea = All;
                    SubPageLink = "Case No." = field("No.");
                }
            }
        }
        addafter("Contact Phone")
        {
            field("Contact Email 2"; Rec."Contact Email 2")
            {
                ApplicationArea = All;
                Caption = 'Contact Email 2';

                trigger OnLookup(var Text: Text): Boolean
                var
                    Contact: Record Contact;
                    ContactListPage: Page "Contact List";
                    var1: Integer;
                begin
                    ContactListPage.LookupMode(true);
                    Contact.Reset();
                    Contact.SetFilter("Company Name", Rec."Entity Name");
                    if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                        Rec."Contact Name" := Contact.Name;
                        Rec."Contact Email 2" := Contact."E-Mail";
                        Rec."Contact Phone" := Contact."Phone No.";
                        if Rec.Modify() then
                            var1 := 1
                        else
                            Error('Record was not successfully modified. Please try again.');
                    end;
                end;
            }
        }
        addafter(Status)
        {
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Priority: Record Priority;
                    PriorityList: Page PriorityList;
                    var1: Integer;
                begin
                    PriorityList.LookupMode(true);
                    if PriorityList.RunModal() = Action::LookupOK then begin
                        Rec.Priority := PriorityList.ProduceValues();
                        if Rec.Modify() then
                            var1 := 1
                        else
                            Error('Priority table field did not successfully get modified. Please try again');
                    end;
                end;

                trigger OnValidate()
                var
                    Priority: Record Priority;
                    var1: Integer;
                begin
                    Priority.Reset();
                    Priority.SetFilter(Code, Rec.Priority);
                    if Priority.FindFirst() then
                        var1 := 1
                    else
                        Error('Data/value in priority table field has be based on existing record in "Priority" table object');
                end;
            }
            field(OpenSalesHeader; OpenSalesHeader)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                var
                    SalesHeader: Record "Sales Header";
                    SalesHeaderArchive: Record "Sales Header Archive";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", Rec."Sales Header No.");
                    if SalesHeader.FindFirst() then
                        Page.Run(page::"Sales Order", SalesHeader)
                    else begin
                        SalesHeaderArchive.Reset();
                        SalesHeaderArchive.SetFilter("No.", Rec."Sales Header No.");
                        if SalesHeaderArchive.FindFirst() then
                            Page.Run(Page::"Sales Order Archive", SalesHeaderArchive)
                        else
                            Message('No record exists in Sales Header or Sales Header Archive table with value of: ' + Rec."Sales Header No.");
                    end;
                end;
            }
            field(OpenSalesInvoiceHeader; OpenSalesInvoiceHeader)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                var
                    SalesHeader: Record "Sales Header";
                    SalesHeaderArchive: Record "Sales Header Archive";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetFilter("No.", Rec."Sales Invoice Header No.");
                    if SalesInvoiceHeader.FindFirst() then
                        Page.Run(page::"Posted Sales Invoice", SalesInvoiceHeader)
                    else
                        Message('No record exists in Sales Invoice Header table with value of: ' + Rec."Sales Invoice Header No.");
                end;
            }
        }
        addafter("Assigned User ID")
        {
            field("SalesPerson Code"; Rec."SalesPerson Code")
            {
                ApplicationArea = All;
                Caption = 'SalesPerson Code';
                Editable = false;

                trigger OnValidate()
                var
                begin
                    ModifySPCaseLines();
                end;
            }
            field("CS Status"; Rec."CS Status")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    CSStaus: Record CSStatus;
                    var1: Integer;
                begin
                    if Page.RunModal(Page::CSStatusList, CSStaus) = Action::LookupOK then begin
                        Rec."CS Status" := CSStaus.Code;
                        if Rec.Modify() then
                            var1 := 1
                        else
                            Error('Record in the table was not succesfully modified. Please click lookup action again to modify data');
                    end;
                end;

                trigger OnValidate()
                var
                    CSStaus: Record CSStatus;
                    var1: Integer;
                begin
                    CSStaus.Reset();
                    CSStaus.SetFilter(Code, Rec."CS Status");
                    if CSStaus.FindFirst() then
                        var1 := 1
                    else
                        Error('Data/value in "CS Status" tbable field has to be based on existing record in "CS Status" table');
                end;
            }
            field("Assigned Date"; Rec."Assigned Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Follow Up Date"; Rec."Follow Up Date")
            {
                ApplicationArea = All;
            }
            field("Resolution Date 2"; Rec."Resolution Date 2")
            {
                ApplicationArea = All;
                Caption = 'Resolution Date 2';
                Editable = false;
            }
            field("Second Case"; Rec."Second Case")
            {
                ApplicationArea = All;
            }
        }
        modify("Assigned User ID")
        {
            trigger OnAfterValidate()
            var
                var1: Integer;
            begin
                Rec."Assigned Date" := Today();
                if Rec.Modify() then var1 := 1;
                ModifyAssignedUserIDCaseLines();
            end;
        }
        addafter("Reason Description")
        {
            /*field(ReasonCodeLookup;ReasonCodeLookup)
            {
                ApplicationArea = All;
                Caption = 'Reason Lookup';
                Editable = false;

                trigger OnDrillDown()
                var
                CaseReason: Record "Case Reason Code WSG";
                CaseReasonlistPage: Page "Case Reason Codes WSG";
                CaseReasonDetail: Record CaseReasonDetail;
                CaseReasonDetailListPage: Page CaseReasonDetailList;
                begin
                    CaseReasonDetailListPage.LookupMode(true);
                    CaseReasonDetailListPage.GetValues(Rec."Reason Code");
                    if
                    CaseReasonDetailListPage.RunModal() = Action::LookupOK
                    then
                    begin
                        Rec."Department Specification" := CaseReasonDetailListPage.ProduceValues();
                        Rec.Modify();
                    end;  
                end;
            }*/
            field("Department Specification"; Rec."Department Specification")
            {
                ApplicationArea = All;
                Caption = 'Sub-Function';

                trigger OnLookup(var Text: Text): Boolean
                var
                    CaseReasonDetail: Record CaseReasonDetail;
                    var1: Integer;
                begin
                    CaseReasonDetail.Reset();
                    CaseReasonDetail.SetFilter("Reason Code", Rec."Reason Code");
                    if Page.RunModal(Page::CaseReasonDetailList, CaseReasonDetail) = Action::LookupOk then begin
                        Rec."Department Specification" := CaseReasonDetail.Code;
                        if Rec.Modify() then
                            ModifyDepartmentSpecificationCaseLine()
                        else
                            Error('Record was not succesffuly mdofied. Please try again')
                    end;
                end;

                trigger OnValidate()
                var
                    CaseReasonDetail: Record CaseReasonDetail;
                    var1: Integer;
                begin
                    CaseReasonDetail.Reset();
                    CaseReasonDetail.SetFilter("Reason Code", Rec."Reason Code");
                    CaseReasonDetail.SetFilter(Code, Rec."Department Specification");
                    if CaseReasonDetail.FindFirst() then
                        var1 := 1
                    else
                        Error('Value for "Department Specification" table field not a valid value based on "Reason Code" table field');
                    ModifyDepartmentSpecificationCaseLine();
                end;
            }
            field("Tracking No."; Rec."Tracking No.")
            {
                ApplicationArea = All;
            }
            field("Responsible Owner"; Rec."Responsible Owner Current")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    User: Record User;
                    var1: Integer;
                begin
                    if Page.RunModal(Page::Users, User) = Action::LookupOK then begin
                        Rec."Responsible Owner Current" := User."User Name";
                        if Rec.Modify() then
                            var1 := 1
                        else
                            Error('Record was not successfully modified. Please try again.');
                    end;
                end;

                trigger OnValidate()
                var
                    User: Record User;
                    var1: Integer;
                begin
                    if Rec."Responsible Owner Current" = '' then
                        var1 := 1
                    else begin
                        User.Reset();
                        User.SetFilter("User Name", Rec."Responsible Owner Current");
                        if User.FindFirst() then
                            var1 := 1
                        else
                            Error('Value in "Responsible Owner" table field has to be based on an existing User Record');
                    end;
                end;
            }
        }
        addafter("Entity Name")
        {
            field("Lookup Type"; Rec."Lookup Type")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                begin
                    if Rec."Lookup Type" = Rec."Lookup Type"::"Sales Order" then begin
                        SalesOrderEditableVar := true;
                        SalesQuoteEditbaleVar := false;
                        PostedSalesInvoiceEditbaleVar := false;
                    end;
                    if Rec."Lookup Type" = Rec."Lookup Type"::"Sales Quote" then begin
                        SalesQuoteEditbaleVar := true;
                        SalesOrderEditableVar := false;
                        PostedSalesInvoiceEditbaleVar := false;
                    end;
                    if Rec."Lookup Type" = Rec."Lookup Type"::"Posted Sales Invoice" then begin
                        SalesQuoteEditbaleVar := false;
                        SalesOrderEditableVar := false;
                        PostedSalesInvoiceEditbaleVar := true;
                    end;
                end;
            }
            field("Sales Quote No."; Rec."Sales Quote No.")
            {
                ApplicationArea = All;
                Editable = SalesQuoteEditbaleVar;

                trigger OnLookup(var Text: Text): Boolean
                var
                    SalesQuoteListPage: Page "Sales Quotes";
                    SalesHeader: Record "Sales Header";
                begin
                    if Rec."Lookup Type" = Rec."Lookup Type"::"Sales Quote" then begin
                        //SalesQuoteListPage.LookupMode(true);
                        if Page.RunModal(Page::"Sales Quotes", SalesHeader) = Action::LookupOK then begin
                            Rec."Sales QUote No." := SalesHeader."No.";
                            Rec."Location Code" := SalesHeader."Location Code";
                            Rec."Entity No." := SalesHeader."Sell-to Customer No.";
                            Rec."Entity Name" := SalesHeader."Sell-to Customer Name";
                            Rec."Contact Name" := SalesHeader."Sell-to Contact";
                            Rec."Contact Phone" := SalesHeader."Sell-to Phone No.";
                            Rec."Contact Email 2" := SalesHeader."Sell-to E-Mail";
                            Rec."SalesPerson Code" := SalesHeader."Salesperson Code";
                            Rec."Ship To Name" := SalesHeader."Ship-to Name (Custom)";
                            Rec."Ship To Address" := SalesHeader."Ship-to Address (Custom)";
                            Rec."Ship To Address 2" := SalesHeader."Ship-to Address 2 (Custom)";
                            Rec."Ship To Contact" := SalesHeader."Ship-to Contact (Custom)";
                            Rec.City := SalesHeader."Ship-to City (Custom)";
                            Rec."Post Code" := SalesHeader."Ship-To Post Code (Custom)";
                            Rec."External Doc No." := SalesHeader."External Document No.";
                            Rec."Shipment Date" := SalesHeader."Shipment Date";
                            Rec.State := SalesHeader."Ship-To County (Custom)";
                            Rec.Modify();
                        end;
                    end
                    else
                        Message('"Lookup Type" global page varibale has to have a value of "Sales Quote" in order to lookup to Sales Quote List Page object');
                end;

                trigger OnValidate()
                var
                    Salesheader: Record "Sales Header";
                    var1: Integer;
                begin
                    Salesheader.Reset();
                    Salesheader.SetFilter("No.", Rec."Sales Quote No.");
                    Salesheader.SetRange("Document Type", Salesheader."Document Type"::Quote);
                    if Salesheader.FindFirst() then
                        var1 := 1
                    else
                        Error('Data/Value in sales quote no table field has to be based on record in the Sales header table')
                end;
            }
            field("Sales Header No."; Rec."Sales Header No.")
            {
                ApplicationArea = All;
                Caption = 'Sales Order No.';
                Editable = SalesOrderEditableVar;

                trigger OnValidate()
                var
                begin
                    /*SalesRecordForCase.Reset();
                        if
                        SalesRecordForCase.FindLast()
                        then
                        var1 := SalesRecordForCase."Entry No." + 1
                        else
                        var1 := 1;

                        SalesRecordForCase.Init();
                        SalesRecordForCase."Entry No." := var1;
                        SalesRecordForCase."User ID" := UserId();
                        SalesRecordForCase."Case No." := Rec."No.";
                        SalesRecordForCase."Sales Record No." := Rec."Sales Header No.";
                        SalesRecordForCase.Insert();*/
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    SalesOrderListPage: Page "Sales Order List";
                    PostedSalesInvoiceListPage: Page "Posted Sales Invoices";
                    SalesRecordForCase: Record SalesRecordForCase;
                    var1: Integer;
                    SalesHeader: Record "Sales Header";
                begin
                    if Rec."Lookup Type" = Rec."Lookup Type"::"Sales Order" then begin
                        SalesOrderListPage.LookupMode(true);
                        if SalesOrderListPage.RunModal() = Action::LookupOK then begin
                            Rec."Sales Header No." := SalesOrderListPage.GetSalesHeaderNo();
                            Rec."Location Code" := SalesOrderListPage.GetLocationCode();
                            SalesHeader.Reset();
                            SalesHeader.SetFilter("No.", SalesOrderListPage.GetSalesHeaderNo());
                            if SalesHeader.FindFirst() then begin
                                //Rec."Sales QUote No." := SalesHeader."No.";
                                Rec."Location Code" := SalesHeader."Location Code";
                                Rec."Entity No." := SalesHeader."Sell-to Customer No.";
                                Rec."Entity Name" := SalesHeader."Sell-to Customer Name";
                                Rec."Contact Name" := SalesHeader."Sell-to Contact";
                                Rec."Contact Phone" := SalesHeader."Sell-to Phone No.";
                                Rec."SalesPerson Code" := SalesHeader."Salesperson Code";
                                Rec."Ship To Name" := SalesHeader."Ship-to Name (Custom)";
                                Rec."Ship To Address" := SalesHeader."Ship-to Address (Custom)";
                                Rec."Ship To Address 2" := SalesHeader."Ship-to Address 2 (Custom)";
                                Rec."Ship To Contact" := SalesHeader."Ship-to Contact (Custom)";
                                Rec.City := SalesHeader."Ship-to City (Custom)";
                                Rec."Post Code" := SalesHeader."Ship-To Post Code (Custom)";
                                Rec."External Doc No." := SalesHeader."External Document No.";
                                Rec."Shipment Date" := SalesHeader."Shipment Date";
                                Rec.State := SalesHeader."Ship-To County (Custom)";
                                Rec.Modify();
                            end;
                            SalesRecordForCase.Reset();
                            if SalesRecordForCase.FindLast() then
                                var1 := SalesRecordForCase."Entry No." + 1
                            else
                                var1 := 1;
                            SalesRecordForCase.Init();
                            SalesRecordForCase."Entry No." := var1;
                            SalesRecordForCase."User ID" := UserId();
                            SalesRecordForCase."Case No." := Rec."No.";
                            SalesRecordForCase."Sales Record No." := Rec."Sales Header No.";
                            SalesRecordForCase.Insert();
                        end;
                    end
                end;
            }
            field("Sales Invoice Header No."; Rec."Sales Invoice Header No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    SalesHeader: Record "Sales Header";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    SalesHeaderVerified: Integer;
                    SalesInvoiceHeaderVerified: Integer;
                    CaseLineListPartPage: Page CaseLineListPart;
                    SalesRecordForCase: Record SalesRecordForCase;
                    var1: Integer;
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetFilter("No.", Rec."Sales Invoice Header No.");
                    if SalesInvoiceHeader.FindFirst() then begin
                        Rec."Sales Invoice Header No." := SalesInvoiceHeader."No.";
                        Rec."Location Code" := SalesInvoiceHeader."Location Code";
                        Rec."SalesPerson Code" := SalesInvoiceHeader."Salesperson Code";
                        Rec."Entity No." := SalesInvoiceHeader."Sell-to Customer No.";
                        Rec."Entity Name" := SalesInvoiceHeader."Sell-to Customer Name";
                        Rec."Contact Name" := SalesInvoiceHeader."Sell-to Contact";
                        Rec."Contact Phone" := SalesInvoiceHeader."Sell-to Phone No.";
                        Rec."Contact Email 2" := SalesInvoiceHeader."Sell-to E-Mail";
                        Rec."Ship To Name" := SalesInvoiceHeader."Ship-to Name";
                        Rec."Ship To Address" := SalesInvoiceHeader."Ship-to Address";
                        Rec."Ship To Address 2" := SalesInvoiceHeader."Ship-to Address 2";
                        Rec."Ship To Contact" := SalesInvoiceHeader."Ship-to Contact";
                        Rec.City := SalesInvoiceHeader."Ship-to City";
                        Rec."Post Code" := SalesInvoiceHeader."Ship-to Post Code";
                        Rec."External Doc No." := SalesInvoiceHeader."External Document No.";
                        Rec."Shipment Date" := SalesInvoiceHeader."Shipment Date";
                        Rec.State := SalesInvoiceHeader."Ship-to County";
                        if Rec.Modify() then
                            var1 := 1
                        else
                            Error('Record was not successfully modifed. Please try again.');
                    end
                    else
                        Error(Rec."No." + ' is not an existing record in the Sales Invoice Header table');
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    PostedSalesInvoiceList: Page "Posted Sales Invoices";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    var1: Integer;
                begin
                    if Rec."Lookup Type" = Rec."Lookup Type"::"Posted Sales Invoice" then begin
                        if Page.RunModal(Page::"Posted Sales Invoices", SalesInvoiceHeader) = Action::LookupOK then begin
                            Rec."Sales Invoice Header No." := SalesInvoiceHeader."No.";
                            Rec."Sales Header No." := SalesInvoiceHeader."Order No.";
                            Rec."Location Code" := SalesInvoiceHeader."Location Code";
                            Rec."SalesPerson Code" := SalesInvoiceHeader."Salesperson Code";
                            Rec."Entity No." := SalesInvoiceHeader."Sell-to Customer No.";
                            Rec."Entity Name" := SalesInvoiceHeader."Sell-to Customer Name";
                            Rec."Contact Name" := SalesInvoiceHeader."Sell-to Contact";
                            Rec."Contact Phone" := SalesInvoiceHeader."Sell-to Phone No.";
                            Rec."Contact Email 2" := SalesInvoiceHeader."Sell-to E-Mail";
                            Rec."Ship To Name" := SalesInvoiceHeader."Ship-to Name";
                            Rec."Ship To Address" := SalesInvoiceHeader."Ship-to Address";
                            Rec."Ship To Address 2" := SalesInvoiceHeader."Ship-to Address 2";
                            Rec."Ship To Contact" := SalesInvoiceHeader."Ship-to Contact";
                            Rec.City := SalesInvoiceHeader."Ship-to City";
                            Rec."Post Code" := SalesInvoiceHeader."Ship-to Post Code";
                            Rec."External Doc No." := SalesInvoiceHeader."External Document No.";
                            Rec."Shipment Date" := SalesInvoiceHeader."Shipment Date";
                            Rec.State := SalesInvoiceHeader."Ship-to County";
                            if Rec.Modify() then
                                var1 := 1
                            else
                                Error('"Sales Invoice Header No." table field was not successfully mdofied. Please try again');
                        end;
                    end
                    else
                        Message('"Lookup Type table field needs a value of "Posted Sales Invoice" to lookup to Sales Invoice Header records');
                end;
            }
            field("External Doc No."; Rec."External Doc No.")
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                Caption = 'Location Code';

                trigger OnValidate()
                var
                    Location: Record Location;
                    var1: Integer;
                begin
                    Location.Reset();
                    Location.SetRange(Code, Rec."Location Code");
                    if Location.FindFirst() then begin
                        if Dialog.Confirm('Are you sure you want to modify data to: ' + Rec."Location Code" + ' ?', true) then
                            var1 := 1
                        else begin
                            Rec."Location Code" := xRec."Location Code";
                            Rec.Modify();
                        end;
                    end
                    else
                        Error('Value needs to be a valid location code based on records in Location table');
                    ModifyLocationCode();
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Location: Record Location;
                    LocationListPage: Page "Location List";
                    var1: Integer;
                begin
                    LocationListPage.LookupMode(true);
                    if LocationListPage.RunModal() = Action::LookupOK then begin
                        Rec."Location Code" := LocationListPage.GetLocationCode();
                        if Rec.Modify() then
                            var1 := 1
                        else
                            Error('Record was not successfully modified. Please try again');
                        ModifyLocationCode();
                    end;
                end;
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
            }
        }
        modify("Reason Code")
        {
            //ShowMandatory = MandatoryVarReasonCode;
            trigger OnBeforeValidate()
            var
            begin
                if Rec.Status = Rec.Status::Resolved then begin
                    if Rec."Reason Code" = '' then Error('Cannot modify "Reason Code" table field to value of "blank" when Status table field has value of "Resolved"');
                end;
            end;

            trigger OnAfterValidate()
            var
                var1: Integer;
            begin
                ModifyReasonCodeCaseLines();
                if Rec."Department Specification" <> '' then begin
                    Rec."Department Specification" := '';
                    if Rec.Modify() then
                        var1 := 1
                    else
                        Error('Department specification table field was not succesfully modified. Please try again');
                end;
            end;
        }
        modify("Entity Name")
        {
            ShowMandatory = MandatoryVarName;

            trigger OnAfterValidate()
            var
            begin
                ModifyEntityNameCaseLines();
                CurrPage.Update(false);
            end;
        }
        modify("Entity No.")
        {
            trigger OnAfterValidate()
            var
                SalesRecordForCase: Record SalesRecordForCase;
                var1: Integer;
                var2: Integer;
            begin
                /*SalesRecordForCase.Reset();
                    if
                    SalesRecordForCase.FindLast()
                    then
                    var1 := SalesRecordForCase."Entry No." + 1
                    else
                    var1 := 1;

                    SalesRecordForCase.Init();
                    SalesRecordForCase."User ID" := UserId();
                    SalesRecordForCase."Case No." := Rec."No.";
                    SalesRecordForCase."Entry No." := var1;
                    if
                    SalesRecordForCase.Insert()
                    then
                    var2 := 1
                    else
                    Error('');*/
            end;
        }
        modify("Resolution Code")
        {
            trigger OnAfterValidate()
            var
            begin
                ModifyResolutionCodeCaseLines();
            end;
        }
        modify("Contact Name")
        {
            ShowMandatory = MandatoryVarContactName;

            trigger OnLookup(var Text: Text): Boolean
            var
                Contact: Record Contact;
                var1: Integer;
            begin
                Contact.Reset();
                Contact.SetFilter("Company No.", Rec."Entity No.");
                if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then begin
                    Rec."Contact Name" := Contact.Name;
                    Rec."Contact Email 2" := Contact."E-Mail";
                    Rec."Contact Phone" := Contact."Phone No.";
                    if Rec.Modify() then
                        var1 := 1
                    else
                        Error('Record was not successfully modified. Please try again.');
                end;
            end;

            trigger OnAfterValidate()
            var
            begin
                ModifyContactNameCaseLines();
                if Rec.Modify() then CurrPage.Update(false);
            end;
        }
        modify("Resolution No.")
        {
            trigger OnAfterValidate()
            var
            begin
                ModifyResolutionNoCaseLines();
            end;
        }
        modify("Reason Notes")
        {
            trigger OnBeforeValidate()
            var
            begin
                if Rec.Status = Rec.Status::Resolved then begin
                    if Rec."Reason Notes" = '' then Error('Cannot modify "Reason Notes" table field to value of "blank" when Status table field has value of "Resolved"');
                end;
            end;
        }
        modify(Status)
        {
            trigger OnBeforeValidate()
            var
            begin
                if Rec.Status = Rec.Status::Resolved then begin
                    if Rec."Reason Code" = '' then Error('"Reason Code table field has to have a value other than "blank" before status can be modified to value of "Resolved"');
                    if Rec."Reason Notes" = '' then Error('"Reason Notes table field has to have a value other than "blank" before status can be modified to value of "Resolved"');
                end;
            end;

            trigger OnAfterValidate()
            var
                var1: Integer;
            begin
                if Rec.Status = Rec.Status::Resolved then begin
                    if Rec."Resolution Date 2" <> Today() then begin
                        Rec."Resolution Date 2" := Today();
                        if Rec.Modify() then
                            var1 := 1
                        else
                            Error('Record was not successfully modified. Please try again.');
                    end;
                end
                else begin
                    Rec."Resolution Date 2" := 0D;
                    if Rec.Modify() then
                        var1 := 1
                    else
                        Error('Record was not successfully modified. Please try again.');
                end;
                if Rec.Status = Rec.Status::"In Progress" then begin
                    Rec."CS Status" := 'New';
                    if Rec.Modify() then
                        var1 := 1
                    else
                        Error('CS Status table field was not successfully modifed. Please try again.');
                end;
                ModifyStatus();
                if Rec.Modify() then CurrPage.Update(false);
            end;
        }
    }
    actions
    {
        addafter(AddCustomer)
        {
            /*action(CaseReport)
                {
                    ApplicationArea = All;
                    Image = Report;
                    Caption = 'Case Report';
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    var
                    CaseWSG: Record "Case WSG";
                    Tempblob: Codeunit "Temp Blob";
                    Inst: Instream;
                    Out: Outstream;
                    RecRef: RecordRef;
                    Filename: Text;
                    var1: Integer;
                    begin

                        Filename := 'Case_' + Rec."No." + '_' + Format(CurrentDateTime()) + '.pdf';
                        CaseWSG.Reset();
                        CaseWSG.SetFilter("No.", Format(Rec."No."));
                        if
                        CaseWSG.FindFirst()
                        then
                        begin
                            Tempblob.CreateInStream(Inst);
                            Tempblob.CreateOutStream(Out);
                            RecRef.GetTable(CaseWSG);
                            Report.SaveAs(Report::CaseCustom, '', ReportFormat::Pdf, Out, RecRef);
                            if
                            DownloadFromStream(Inst, '', '', '', Filename)
                            then
                            var1 := 1
                            else
                            Error('Case Report did not successfully get produced and download .pdf file of the report locally. Please try again');

                        end;

                    end;



                }*/
        }
    }
    /*trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Error('Click "Insert Record" action to insert record in to Case Table');
    end;*/
    trigger OnAfterGetCurrRecord()
    var
    begin
        if Rec."Entity Name" = '' then
            MandatoryVarName := true
        else
            MandatoryVarName := false;
        if Rec."Contact Name" = '' then
            MandatoryVarContactName := true
        else
            MandatoryVarContactName := false;
        /*if
        Rec."Contact Email" = ''
        then
        MandatoryVarContactEmail := true
        else
        MandatoryVarContactEmail := false;*/
        /*if
        Rec."Describe Issue" = ''
        then
        MandatoryVarDescribeIssue := true
        else
        MandatoryVarDescribeIssue := false;*/
        if Rec."Must Arrive Date" = 0D then
            MandatoryVarDescribeMustArriveDate := true
        else
            MandatoryVarDescribeMustArriveDate := false;
        if Rec.Status = Rec.Status::Cancelled then begin
            MandatoryVarContactEmail := false;
            MandatoryVarContactName := false;
            MandatoryVarDescribeMustArriveDate := false;
            MandatoryVarName := false;
        end /*if
        Rec.Status = Rec.Status::Resolved
        then
        begin
            MandatoryVarReasonCode := true;
            MandatoryVarReasonNotes := true;
        end
        else
        begin
            MandatoryVarReasonNotes := false;
            MandatoryVarReasonNotes := false;
        end;*/
    end;

    trigger OnOpenPage()
    var
        SalesRecordForCase: Record SalesRecordForCase;
        var1: Integer;
        Inst: InStream;
        Out: OutStream;
        TempBlob: Codeunit "Temp Blob";
        var2: Text;
    begin
        DownloadDesribeIssueText := 'Download Describe Issue .txt File';
        ReasonCodeLookup := 'Reason Lookup';
        //Rec."Describe Issue".CreateInStream(Inst);
        //Rec.CalcFields("Describe Issue");
        //Inst.Read(OverallTextValue);
        if Rec."Lookup Type" = Rec."Lookup Type"::"Posted Sales Invoice" then begin
            PostedSalesInvoiceEditbaleVar := true;
            SalesOrderEditableVar := false;
            SalesQuoteEditbaleVar := false;
        end;
        if Rec."Lookup Type" = Rec."Lookup Type"::"Sales Order" then begin
            PostedSalesInvoiceEditbaleVar := false;
            SalesOrderEditableVar := true;
            SalesQuoteEditbaleVar := false;
        end;
        if Rec."Lookup Type" = Rec."Lookup Type"::"Sales Quote" then begin
            PostedSalesInvoiceEditbaleVar := false;
            SalesOrderEditableVar := false;
            SalesQuoteEditbaleVar := true;
        end;
        /*if
        Rec."Reason Code" = ''
        then
        MandatoryVarReasonCode := true
        else
        MandatoryVarReasonCode := false;

        if
        Rec."Reason Notes" = ''
        then
        MandatoryVarReasonNotes := true
        else
        MandatoryVarReasonNotes := false;*/
        SalesRecordForCase.Reset();
        if SalesRecordForCase.FindLast() then
            var1 := SalesRecordForCase."Entry No." + 1
        else
            var1 := 1;
        SalesRecordForCase.Init();
        SalesRecordForCase."Entry No." := var1;
        SalesRecordForCase."User ID" := UserId();
        SalesRecordForCase."Case No." := Rec."No.";
        SalesRecordForCase."Sales Record No." := Rec."Sales Header No.";
        SalesRecordForCase.Insert();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        CaseWSG: Record "Case WSG";
    begin
        CaseWSG.Reset();
        CaseWSG.SetRange("No.", Rec."No.");
        if CaseWSG.FindFirst() then begin
            if Rec.Status = Rec.Status::Resolved then begin
                if Rec."Reason Code" = '' then Error('"Reason Code" table field cannot have a value of blank. Current value is blank.');
                if Rec."Reason Notes" = '' then Error('"Reason Notes" table field cannot have a value of blank. Current value is blank');
            end;
        end;
        if (Rec."Contact Name" = '') or (Rec."Entity Name" = '') or (Rec."Must Arrive Date" = 0D) then Error('All fields that have a red astericks (required table fields) must have a value other than "blank"');
    end;

    var
        ReasonCodeLookup: Text;
        LookupType: Enum LookupTypeNew;
        MandatoryVarReasonCode: Boolean;
        MandatoryVarReasonNotes: Boolean;
        SalesOrderEditableVar: Boolean;
        PostedSalesInvoiceEditbaleVar: Boolean;
        SalesQuoteEditbaleVar: Boolean;
        DescribeIssue: Text;
        DownloadDesribeIssueText: Text;
        OverallTextValue: Text;
        var51: Text;
        MandatoryVarContactName: Boolean;
        MandatoryVarContactEmail: Boolean;
        MandatoryVarName: Boolean;
        MandatoryVarDescribeIssue: Boolean;
        MandatoryVarDescribeMustArriveDate: Boolean;
        MandatoryVarCustomerComplaint: Text;
        OpenSalesHeader: Text;
        OpenSalesInvoiceHeader: Text;

    procedure ModifySPCaseLines()
    var
        CaseLine: Record CaseLine;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."SalesPerson Code" <> Rec."SalesPerson Code" then begin
                    CaseLine."SalesPerson Code" := Rec."SalesPerson Code";
                    Caseline.Modify();
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyContactNameCaseLines()
    var
        CaseLine: Record CaseLine;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Contact Name" <> Rec."Contact Name" then begin
                    CaseLine."Contact Name" := Rec."Contact Name";
                    CaseLine.Modify();
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyAssignedUserIDCaseLines()
    var
        CaseLine: Record CaseLine;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Assigned User ID" <> Rec."Assigned User ID" then begin
                    CaseLine."Assigned User ID" := Rec."Assigned User ID";
                    Caseline.Modify();
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyReasonCodeCaseLines()
    var
        CaseLine: Record CaseLine;
        var1: Integer;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Reason Code" <> Rec."Reason Code" then begin
                    CaseLine."Reason Code" := Rec."Reason Code";
                    if Caseline.Modify() then
                        var1 := 1
                    else
                        Error('One or more records in case line table were not successfully modified. Please try again.');
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyResolutionNoCaseLines()
    var
        CaseLine: Record CaseLine;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Resolution No." <> Rec."Resolution No." then begin
                    CaseLine."Resolution No." := Rec."Resolution No.";
                    Caseline.Modify();
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyResolutionCodeCaseLines()
    var
        CaseLine: Record CaseLine;
        var1: Integer;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Resolution Code" <> Rec."Resolution Code" then begin
                    CaseLine."Resolution Code" := Rec."Resolution Code";
                    if Caseline.Modify() then
                        var1 := 1
                    else
                        Error('One or more records in case line table were not successfully modified. Please try again.');
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyEntityNameCaseLines()
    var
        CaseLine: Record CaseLine;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine.Name <> Rec."Entity Name" then begin
                    CaseLine.Name := Rec."Entity Name";
                    Caseline.Modify();
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyLocationCode()
    var
        CaseLine: Record CaseLine;
        var1: Integer;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Location Code" <> Rec."Location Code" then begin
                    CaseLine."Location Code" := Rec."Location Code";
                    if CaseLine.Modify() then
                        var1 := 1
                    else
                        Error('One or more records in case line table were not successfully modified. Please try again.');
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyStatus()
    var
        CaseLine: Record CaseLine;
        var1: Integer;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine.Status <> Format(Rec.Status, 0, '<Text>') then begin
                    CaseLine.Status := Format(Rec.Status, 0, '<Text>');
                    if CaseLine.Modify() then
                        var1 := 1
                    else
                        Error('One or more records in case line table were not successfully modified. Please try again.');
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyResolutionCode()
    var
        CaseLine: Record CaseLine;
    begin
        CaseLine.Reset();
        CaseLine.SetRange("Case No.", Rec."No.");
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Resolution Code" = Rec."Resolution Code" then
                    exit
                else begin
                    CaseLine."Resolution Code" := Rec."Resolution Code";
                    CaseLine.Modify();
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyDepartmentSpecificationCaseLine()
    var
        CaseLine: Record CaseLine;
        var1: Integer;
    begin
        CaseLine.Reset();
        CaseLine.SetFilter("Case No.", Format(Rec."No."));
        if CaseLine.FindSet() then
            repeat
                if CaseLine."Department Specification" <> Rec."Department Specification" then begin
                    CaseLine."Department Specification" := Rec."Department Specification";
                    if CaseLine.Modify() then
                        var1 := 1
                    else
                        Error('One or more records in case line table were not successfully modified. Please try again.');
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifyEntityNameCaseLine()
    var
        CaseLine: Record CaseLine;
        var1: Integer;
    begin
        CaseLine.Reset();
        CaseLine.SetFilter("Case No.", Format(Rec."No."));
        if CaseLine.FindSet() then
            repeat
                if CaseLine.Name <> Rec."Entity Name" then begin
                    CaseLine.Name := Rec."Entity Name";
                    if CaseLine.Modify() then
                        var1 := 1
                    else
                        Error('One or more records in case line table were not successfully modified. Please try again.');
                end;
            until CaseLine.Next() = 0;
    end;

    procedure ModifySalesPersonCodeCaseLine()
    var
        CaseLine: Record CaseLine;
        var1: Integer;
    begin
        CaseLine.Reset();
        CaseLine.SetFilter("Case No.", Format(Rec."No."));
        if CaseLine.FindSet() then
            repeat
                if CaseLine."SalesPerson Code" <> Rec."SalesPerson Code" then begin
                    CaseLine."SalesPerson Code" := Rec."SalesPerson Code";
                    if CaseLine.Modify() then
                        var1 := 1
                    else
                        Error('One or more records in case line table were not successfully modified. Please try again.');
                end;
            until CaseLine.Next() = 0;
    end;
}
