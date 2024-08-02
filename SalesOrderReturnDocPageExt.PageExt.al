pageextension 55138 SalesOrderReturnDocPageExt extends "Sales Return Order"
{
    layout
    {
        addafter("Ship-to")
        {
            group(ShipToCustom)
            {
                Caption = 'Return-To';

                field("Location Code (Custom)"; Rec."Location Code (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code (Return)';
                    Editable = false;
                }
                field("Ship-to Name (Custom)"; Rec."Ship-to Name (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Name (Return)';
                    Editable = false;
                }
                /*field(MakeVisible;MakeVisible)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                    begin
                        if
                        MakeVisible = 'Visible'
                        then
                        begin
                            VisibleVar := true;
                            MakeVisible := 'Non-Visible'
                        end
                        else
                        begin
                            //VisibleVar := false;
                            //MakeVisible := 'Visible';
                        end;
                    end;
                }*/
                field("Ship-to Name 2 (Custom)"; Rec."Ship-to Name 2 (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Name 2 (Return)';
                    Editable = false;
                }
                field("Ship-to Address (Custom)"; Rec."Ship-to Address (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address (Return)';
                    Editable = false;
                }
                field("Ship-to Address 2 (Custom)"; Rec."Ship-to Address 2 (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address 2 (Return)';
                    Editable = false;
                }
                field("Ship-to City (Custom)"; Rec."Ship-to City (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to City (Return)';
                    Editable = false;
                }
                field("Ship-To County (Custom)"; Rec."Ship-To County (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-To County';
                    Editable = false;
                }
                field("Ship-To Post Code (Custom)"; Rec."Ship-To Post Code (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-To Post Code (Return)';
                    Editable = false;
                }
                field("Ship-To CountryRegion (Custom)"; Rec."Ship-To CountryRegion (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-To CountryRegion (Return)';
                    Editable = false;
                }
                field("Ship-to Code (Custom)"; Rec."Ship-to Code (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Code (Return)';
                    Editable = false;
                }
                field("Ship-to Contact (Custom)"; Rec."Ship-to Contact (Custom)")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Contact (Return)';
                    Editable = false;
                }
            }
        }
        modify("Ship-to Address")
        {
            Editable = false;
        }
        modify("Ship-to Address 2")
        {
            Editable = false;
        }
        modify("Ship-to City")
        {
            Editable = false;
        }
        modify("Ship-to Contact")
        {
            Editable = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Ship-to Name")
        {
            Editable = false;
        }
        modify("Ship-to Post Code")
        {
            Editable = false;
        }
        modify("Ship-to County")
        {
            Editable = false;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                Location: Record Location;
            begin
                Location.Reset();
                Location.SetRange(Code, Rec."Location Code");
                if Location.FindFirst()then begin
                    if Location."Return Name" = '' then begin
                        Location."Return Name":='RETURNS';
                        Location."Return Contact":='ATTN: ';
                        Location.Modify();
                    end;
                    Rec."Location Code (Custom)":=Location.Code;
                    Rec."Ship-to Address (Custom)":=Location.Address;
                    Rec."Ship-to Address 2 (Custom)":=Location."Address 2";
                    Rec."Ship-to City (Custom)":=Location.City;
                    Rec."Ship-to County (Custom)":=Location.County;
                    Rec."Ship-To CountryRegion (Custom)":=Location."Country/Region Code";
                    Rec."Ship-to Name (Custom)":=Location."Return Name";
                    Rec."Ship-to Name 2 (Custom)":=Location."Name 2";
                    Rec."Ship-To Post Code (Custom)":=Location."Post Code";
                    Rec."Ship-to Contact (Custom)":=Location."Return Contact" + Rec."No.";
                    Rec."Ship-to Name":=xRec."Ship-to Name";
                    Rec."Ship-to Address":=xRec."Ship-to Address";
                    Rec."Ship-to Contact":=xRec."Ship-to Contact";
                    Rec."Ship-to Country/Region Code":=xRec."Ship-to Country/Region Code";
                    Rec."Ship-to County":=xRec."Ship-to County";
                    Rec."Ship-to Post Code":=xRec."Ship-to Post Code";
                    Rec."Ship-to Name":=xRec."Ship-to Name";
                    Rec."Ship-to Address 2":=xRec."Ship-to Address 2";
                    Rec.Modify();
                end;
            end;
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(RegisteredPickReport)
            {
                ApplicationArea = All;
                Caption = 'Inspection Sheet Report';
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::InspectionSheet, true, true, SalesHeader);
                end;
            }
            action(Test)
            {
                ApplicationArea = All;
                Caption = 'Test';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    SalesInvoiceLines: Record "Sales Invoice Line";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    GetPostDoc: Page "Get Post.Doc - S.InvLn Subform";
                    SalesLine: Record "Sales Line";
                    var1: Text;
                    var2: Integer;
                    SalesInvoiceLinesCustomPage: Page SalesInvoiceLinesCustom;
                    var10: Text;
                    SalesHeaderNo: Text;
                    SalesShipmentHeader: Record "Sales Shipment Header";
                    SalesShipmentLine: Record "Sales Shipment Line";
                    GetPostDocSInvLnSubform: Page "Get Post.Doc - S.InvLn Subform";
                    DocType: Text;
                    PostedSalesInvoiceSubform: Page "Posted Sales Invoice Subform";
                    var15: Text;
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                    SalesCreditMemoLine: Record "Sales Cr.Memo Line";
                    ReturnReceiptLine: Record "Return Receipt Line";
                    ReturnReceiptHeader: Record "Return Receipt Header";
                    RecordsSelected: Text;
                begin
                    SalesInvoiceLinesCustomPage.LookupMode(true);
                    SalesInvoiceLinesCustomPage.ApplyFilter(Rec."Sell-to Customer No.");
                    if SalesInvoiceLinesCustomPage.RunModal() = Action::LookupOK then begin
                        RecordsSelected:='';
                        RecordsSelected:=SalesInvoiceLinesCustomPage.GetValues1();
                        if RecordsSelected = '' then Error('Need to select records to insert into sales line table');
                        DocType:=SalesInvoiceLinesCustomPage.GetDocType();
                        if DocType = 'Posted Sales Invoice' then begin
                            SalesInvoiceLines.Reset();
                            SalesInvoiceLines.SetFilter(SystemId, SalesInvoiceLinesCustomPage.GetValues1());
                            if SalesInvoiceLines.FindSet()then repeat SalesHeaderNo:='';
                                    SalesInvoiceHeader.Reset();
                                    SalesInvoiceHeader.SetRange("No.", SalesInvoiceLines."Document No.");
                                    if SalesInvoiceHeader.FindFirst()then begin
                                        var1:=SalesInvoiceHeader."Ship-to County";
                                        SalesHeaderNo:='Invoice No. ' + SalesInvoiceHeader."No.";
                                        SalesShipmentHeader.Reset();
                                        SalesShipmentHeader.SetRange("Order No.", SalesInvoiceHeader."Order No.");
                                        if SalesShipmentHeader.FindFirst()then SalesHeaderNo:=SalesHeaderNo + ': ' + SalesShipmentHeader."No.";
                                    end;
                                    SalesLine.Reset();
                                    SalesLine.SetRange("Document No.", Rec."No.");
                                    if SalesLine.FindLast()then var2:=SalesLine."Line No." + 10000
                                    else
                                        var2:=10000;
                                    SalesLine.Init();
                                    SalesLine.TransferFields(SalesInvoiceLines);
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine."Line No.":=var2;
                                    SalesLine."Ship-To-State":=var1;
                                    SalesLine.Insert();
                                    Commit();
                                    SalesLine.Init();
                                    SalesLine."Line No.":=var2 + 10000;
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine.Type:=SalesLine.Type::" ";
                                    SalesLine.Description:=SalesHeaderNo;
                                    SalesLine.Insert()until SalesInvoiceLines.Next() = 0;
                        end;
                        if DocType = 'Posted Credit Memos' then begin
                            SalesCreditMemoLine.Reset();
                            SalesCreditMemoLine.SetFilter(SystemId, SalesInvoiceLinesCustomPage.GetValues1());
                            if SalesCreditMemoLine.FindSet()then repeat SalesHeaderNo:='';
                                    SalesCreditMemoHeader.Reset();
                                    SalesCreditMemoHeader.SetRange("No.", SalesCreditMemoLine."Document No.");
                                    if SalesCreditMemoHeader.FindFirst()then begin
                                        var1:=SalesCreditMemoHeader."Ship-to County";
                                        SalesHeaderNo:='Credit Memo No.: ' + SalesCreditMemoHeader."No.";
                                    end;
                                    SalesLine.Reset();
                                    SalesLine.SetRange("Document No.", Rec."No.");
                                    if SalesLine.FindLast()then var2:=SalesLine."Line No." + 10000
                                    else
                                        var2:=10000;
                                    SalesLine.Init();
                                    SalesLine.TransferFields(SalesCreditMemoLine);
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine."Line No.":=var2;
                                    SalesLine."Ship-To-State":=var1;
                                    SalesLine.Insert();
                                    Commit();
                                    SalesLine.Init();
                                    SalesLine."Line No.":=var2 + 10000;
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine.Type:=SalesLine.Type::" ";
                                    SalesLine.Description:=SalesHeaderNo;
                                    SalesLine.Insert()until SalesCreditMemoLine.Next() = 0;
                        end;
                        if DocType = 'Posted Return Receipts' then begin
                            ReturnReceiptLine.Reset();
                            ReturnReceiptLine.SetFilter(SystemId, SalesInvoiceLinesCustomPage.GetValues1());
                            if ReturnReceiptLine.FindSet()then repeat SalesHeaderNo:='';
                                    ReturnReceiptHeader.Reset();
                                    ReturnReceiptHeader.SetRange("No.", ReturnReceiptLine."Document No.");
                                    if ReturnReceiptHeader.FindFirst()then begin
                                        var1:=ReturnReceiptHeader."Ship-to County";
                                        SalesHeaderNo:='Receipt No.: ' + ReturnReceiptHeader."No.";
                                    end;
                                    SalesLine.Reset();
                                    SalesLine.SetRange("Document No.", Rec."No.");
                                    if SalesLine.FindLast()then var2:=SalesLine."Line No." + 10000
                                    else
                                        var2:=10000;
                                    SalesLine.Init();
                                    SalesLine.TransferFields(ReturnReceiptLine);
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine."Line No.":=var2;
                                    SalesLine."Ship-To-State":=var1;
                                    SalesLine.Insert();
                                    Commit();
                                    SalesLine.Init();
                                    SalesLine."Line No.":=var2 + 10000;
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine.Type:=SalesLine.Type::" ";
                                    SalesLine.Description:=SalesHeaderNo;
                                    SalesLine.Insert()until ReturnReceiptLine.Next() = 0;
                        end;
                        if DocType = 'Posted Shipments' then begin
                            SalesShipmentLine.Reset();
                            SalesShipmentLine.SetFilter(SystemId, SalesInvoiceLinesCustomPage.GetValues1());
                            if SalesShipmentLine.FindSet()then repeat SalesHeaderNo:='';
                                    SalesShipmentHeader.Reset();
                                    SalesShipmentHeader.SetRange("No.", SalesShipmentLine."Document No.");
                                    if SalesShipmentHeader.FindFirst()then begin
                                        var1:=SalesShipmentHeader."Ship-to County";
                                        SalesHeaderNo:='Shipment No.: ' + SalesShipmentHeader."No.";
                                    end;
                                    SalesLine.Reset();
                                    SalesLine.SetRange("Document No.", Rec."No.");
                                    if SalesLine.FindLast()then var2:=SalesLine."Line No." + 10000
                                    else
                                        var2:=10000;
                                    SalesLine.Init();
                                    SalesLine.TransferFields(SalesShipmentLine);
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine."Line No.":=var2;
                                    SalesLine."Ship-To-State":=var1;
                                    SalesLine.Insert();
                                    Commit();
                                    SalesLine.Init();
                                    SalesLine."Line No.":=var2 + 10000;
                                    SalesLine."Document No.":=Rec."No.";
                                    SalesLine.Type:=SalesLine.Type::" ";
                                    SalesLine.Description:=SalesHeaderNo;
                                    SalesLine.Insert()until SalesShipmentLine.Next() = 0;
                        end;
                    end;
                end;
            }
        }
        modify(GetPostedDocumentLinesToReverse)
        {
            trigger OnAfterAction()
            var
            begin
                GetShipToDate();
            end;
        }
        addafter("&Print")
        {
            action(ReturnOrder)
            {
                ApplicationArea = All;
                Caption = 'Print Return Order';
                Promoted = true;
                PromotedCategory = Category10;
                Image = Print;

                trigger OnAction()
                var
                    ReturnOrderCustom: Report ReturnOrderCustom;
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst()then Report.RunModal(Report::ReturnOrderCustom, true, true, SalesHeader);
                end;
            }
        }
        modify("&Print")
        {
            Visible = false;
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        var1: Text;
        Location: Record Location;
        ReturnName: Text;
        ReturnCOntact: Text;
    begin
        if Rec."Location Code (Custom)" <> Rec."Location Code" then begin
            Location.Reset();
            Location.SetRange(Code, Rec."Location Code");
            if Location.FindFirst()then begin
                if Location."Return Name" = '' then begin
                    Location."Return Name":='RETURNS';
                    Location."Return Contact":='ATTN: ';
                    Location.Modify();
                end;
                Rec."Location Code (Custom)":=Location.Code;
                Rec."Ship-to Name (Custom)":=Location."Return Name";
                Rec."Ship-to City (Custom)":=Location.City;
                Rec."Ship-to Address (Custom)":=Location.Address;
                Rec."Ship-to Address 2 (Custom)":=Location."Address 2";
                Rec."Ship-to Contact (Custom)":=Location."Return Contact" + Rec."No.";
                Rec."Ship-To County (Custom)":=Location.County;
                Rec."Ship-To CountryRegion (Custom)":=Location."Country/Region Code";
                Rec."Ship-To Post Code (Custom)":=Location."Post Code";
                Rec.Modify();
            end;
        end;
        Location.Reset();
        Location.SetRange(Code, Rec."Location Code");
        if Location.FindFirst()then begin
            if Rec."Ship-to Name (Custom)" <> Location."Return Name" then begin
                Rec."Ship-to Name (Custom)":=Location."Return Name";
                Rec."Ship-to Contact (Custom)":=Location."Return Contact" + Rec."No.";
                Rec.Modify();
            end;
        end;
    end;
    trigger OnOpenPage()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        var1: Text;
        Location: Record Location;
        ReturnName: Text;
        ReturnCOntact: Text;
    begin
        //MakeVisible := 'Visible';
        //VisibleVar := false;
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."No.");
        if SalesHeader.FindFirst()then begin
            if Rec."Ship To Data Modified" = false then begin
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetRange(Type, SalesLine.Type::" ");
                if SalesLine.FindFirst()then begin
                    var1:=DelStr(SalesLine.Description, 1, 12);
                    var1:=var1.Replace(':', '');
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", var1);
                    if SalesInvoiceHeader.FindFirst()then begin
                        Rec."Location Code":=SalesInvoiceHeader."Location Code";
                        Rec."Ship-to City":=SalesInvoiceHeader."Ship-to City";
                        Rec."Ship-to County":=SalesInvoiceHeader."Ship-to County";
                        Rec."Ship-to Name":=SalesInvoiceHeader."Ship-to Name";
                        Rec."Ship-to Country/Region Code":=SalesInvoiceHeader."Ship-to Country/Region Code";
                        Rec."Ship-to Address":=SalesInvoiceHeader."Ship-to Address";
                        Rec."Ship-to Name 2":=SalesInvoiceHeader."Ship-to Name 2";
                        Rec."Ship-to Address 2":=SalesInvoiceHeader."Ship-to Address 2";
                        Rec."Ship-to Contact":=SalesInvoiceHeader."Ship-to Contact";
                        Rec."Ship-to Post Code":=SalesInvoiceHeader."Ship-to Post Code";
                        Rec."Ship-to Code":=SalesInvoiceHeader."Ship-to Code";
                        Rec."Ship To Data Modified":=true;
                        Rec.Modify();
                    end;
                end;
            end;
        end;
    //if
    //(Rec."Location Code (Custom)" = '') and (Rec."Ship-to Name (Custom)" = '')
    // then
    //begin
    //Rec."Ship-to Name (Custom)" := Rec."Ship-to Name";
    //Rec."Ship-to Code (Custom)" := Rec."Ship-to Code";
    //Rec.
    //end;
    end;
    var VisibleVar: Boolean;
    MakeVisible: Text;
    procedure GetShipToDate()
    var
        SalesLine: Record "Sales Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        var1: Text;
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange(Type, SalesLine.Type::" ");
        if SalesLine.FindFirst()then begin
            var1:=SalesLine.Description;
            var1:=DelStr(var1, 1, 12);
            var1:=DelChr(var1, '>', ':');
            SalesInvoiceHeader.Reset();
            SalesInvoiceHeader.SetFilter("No.", var1);
            if SalesInvoiceHeader.FindFirst()then begin
                Rec."Location Code (Custom)":=Rec."Location Code";
                Rec."Ship-to Name (Custom)":=Rec."Ship-to Name";
                Rec."Ship-to Code (Custom)":=Rec."Ship-to Code";
                Rec."Ship-to City (Custom)":=Rec."Ship-to City";
                Rec."Ship-to Address (Custom)":=Rec."Ship-to Address";
                Rec."Ship-to Name 2 (Custom)":=Rec."Ship-to Name 2";
                Rec."Ship-to Address 2 (Custom)":=Rec."Ship-to Address 2";
                Rec."Ship-to Contact (Custom)":=Rec."Ship-to Contact";
                Rec."Ship-To County (Custom)":=Rec."Ship-to County";
                Rec."Ship-To CountryRegion (Custom)":=Rec."Ship-to Country/Region Code";
                Rec."Ship-To Post Code (Custom)":=Rec."Ship-to Post Code";
                Rec."Location Code":=SalesInvoiceHeader."Location Code";
                Rec."Ship-to City":=SalesInvoiceHeader."Ship-to City";
                Rec."Ship-to County":=SalesInvoiceHeader."Ship-to County";
                Rec."Ship-to Name":=SalesInvoiceHeader."Ship-to Name";
                Rec."Ship-to Country/Region Code":=SalesInvoiceHeader."Ship-to Country/Region Code";
                Rec."Ship-to Address":=SalesInvoiceHeader."Ship-to Address";
                Rec."Ship-to Name 2":=SalesInvoiceHeader."Ship-to Name 2";
                Rec."Ship-to Address 2":=SalesInvoiceHeader."Ship-to Address 2";
                Rec."Ship-to Contact":=SalesInvoiceHeader."Ship-to Contact";
                Rec."Ship-to Post Code":=SalesInvoiceHeader."Ship-to Post Code";
                Rec."Ship-to Code":=SalesInvoiceHeader."Ship-to Code";
                if Rec.Modify()then begin
                    Rec."Ship To Data Modified":=true;
                    Rec.Modify();
                end;
            end;
        end;
    end;
}
