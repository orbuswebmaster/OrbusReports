reportextension 55121 OrbusSalesShipment extends "Sales Shipment NA"
{
    RDLCLayout = './ReportLayouts/OrbusSalesShipmentnew.rdl';

    dataset
    {
        add("Sales Shipment Header")
        {
            column(SalesShipmentNo; "No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(CustomerNo; CustomerNo)
            {
            }
            column(SalesHeaderDocNo; SalesHeaderDocNo)
            {
            }
            column(SalesInvoiceDocNo; SalesInvoiceDocNo)
            {
            }
            column(SalesHeaderPaymentTerms; SalesHeaderPaymentTerms)
            {
            }
            column(SalesHeaderSalesPerson; SalesHeaderSalesPerson)
            {
            }
            column(SalesHeaderShipmentMethod; SalesHeaderShipmentMethod)
            {
            }
            column(SalesHeaderWorkDescription; SalesHeaderWorkDescription)
            {
            }
            column(CurrentDateandTime; CurrentDateandTime)
            {
            }
            column(EncodedPostedWhseShipNo; EncodedPostedWhseShipNo)
            {
            }
            column(EncodedSalesHeaderNo; EncodedSalesHeaderNo)
            {
            }
            column(EnteredBy; EnteredBy)
            {
            }
            column(SalesLineItemNo; SalesLineItemNo)
            {
            }
            column(SalesLineDescription; SalesLineDescription)
            {
            }
            column(SalesLineQty2; SalesLineQty2)
            {
            }
            column(Shipment_Date; Format("Shipment Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(ShipToCustomerName; ShipToCustomerName)
            {
            }
            column(Orbus_ShipToAddress1; Orbus_ShipToAddress1)
            {
            }
            column(Orbus_ShipToAddress2; Orbus_ShipToAddress2)
            {
            }
            column(ShipToCity; ShipToCity)
            {
            }
            column(ShipToState; ShipToState)
            {
            }
            column(ShipToZipCOde; ShipToZipCOde)
            {
            }
            column(ShipToContact; ShipToContact)
            {
            }
            column(ShipFromCompanyName; ShipFromCompanyName)
            {
            }
            column(ShipFromContact; ShipFromContact)
            {
            }
            column(ShipFromAddress1; ShipFromAddress1)
            {
            }
            column(ShipFromAddress2; ShipFromAddress2)
            {
            }
            column(ShipFromCity; ShipFromCity)
            {
            }
            column(ShipFromState; ShipFromState)
            {
            }
            column(ShipFromZipCode; ShipFromZipCode)
            {
            }
            column(ShipFromCountryCode; ShipFromCountryCode)
            {
            }
            column(RequestedDeliveryDate; RequestedDeliveryDate)
            {
            }
            column(OrderDate; OrderDate)
            {
            }
            column(DShipPackagePaymentType; DShipPackagePaymentType)
            {
            }
            column(DShipPackagePaymentAccountNo; DShipPackagePaymentAccountNo)
            {
            }
            column(ShipVia; ShipVia)
            {
            }
        }
        modify("Sales Shipment Header")
        {
        trigger OnBeforeAfterGetRecord()
        var
            PostedWhseShipmentLines: Record "Posted Whse. Shipment Line";
            SalesInvoiceHeader: Record "Sales Invoice Header";
            SalesHeader: Record "Sales Header";
            SalesInvoiceLine: Record "Sales Invoice Line";
            User: Record User;
            TypeHelper: Codeunit "Type Helper";
            LineBreak: Text[2];
            DShipPackageOptions: Record "DSHIP Package Options";
            DShipShipmentOptions: Record "DSHIP Shipment Options";
        begin
            LineBreak:=TypeHelper.CRLFSeparator();
            SalesHeaderDocNo:="Sales Shipment Header"."Order No.";
            SalesHeader.Reset();
            SalesHeader.SetFilter("No.", SalesHeaderDocNo);
            if SalesHeader.FindFirst()then begin
                SalesInvoiceDocNo:=SalesHeader."No.";
                CustomerNo:=SalesHeader."Sell-to Customer No.";
                SalesHeaderPaymentTerms:=SalesHeader."Payment Terms Code";
                SalesHeaderSalesPerson:=SalesHeader."Salesperson Code";
                SalesHeaderShipmentMethod:=SalesHeader."Shipment Method Code";
                SalesHeaderWorkDescription:=SalesHeader.GetWorkDescription();
                OrderDate:=Format(SalesHeader."Order Date", 0, '<Month>/<Day>/<Year4>');
                RequestedDeliveryDate:=Format(SalesHeader."Requested Delivery Date", 0, '<Month>/<Day>/<Year4>');
                ShipVia:=SalesInvoiceHeader."Shipping Agent Code" + '- ' + SalesHeader."Shipping Agent Service Code";
                User.Reset();
                User.SetRange("User Security ID", SalesHeader.SystemCreatedBy);
                if User.FindFirst()then EnteredBy:=User."User Name";
                DShipPackageOptions.Reset();
                DShipPackageOptions.SetRange("Document No.", SalesHeader."No.");
                if DShipPackageOptions.FindFirst()then begin
                    DShipPackagePaymentType:=Format(DShipPackageOptions."Payment Type", 0, '<Text>');
                    DShipPackagePaymentAccountNo:=DShipPackageOptions."Payment Account No.";
                end;
                DShipShipmentOptions.Reset();
                DShipShipmentOptions.SetRange("Document No.", SalesHeader."No.");
                if DShipShipmentOptions.FindFirst()then begin
                    ShipFromCompanyName:=DShipShipmentOptions.Company;
                    ShipFromContact:=DShipShipmentOptions.Name;
                    ShipFromAddress1:=DShipShipmentOptions.Address;
                    ShipFromAddress2:=DShipShipmentOptions."Address 2";
                    ShipFromCity:=DShipShipmentOptions.City;
                    ShipFromState:=DShipShipmentOptions.County;
                    ShipFromZipCode:=DShipShipmentOptions."Post Code";
                    ShipFromCountryCode:=DShipShipmentOptions."Country/Region Code";
                end;
                ShipToCustomerName:=SalesHeader."Ship-to Name";
                Orbus_ShipToAddress1:=SalesHeader."Ship-to Address";
                Orbus_ShipToAddress2:=SalesHeader."Ship-to Address 2";
                ShipToContact:=SalesHeader."Ship-to Contact";
                ShipToCity:=SalesHeader."Ship-to City";
                ShipToState:=SalesHeader."Ship-to County";
                ShipToZipCOde:=SalesHeader."Ship-to Post Code";
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", SalesHeader."No.");
                if SalesInvoiceLine.FindSet()then repeat SalesLineItemNo:=SalesLineItemNo + SalesInvoiceLine."No." + LineBreak;
                        SalesLineDescription:=SalesLineDescription + DelStr(SalesInvoiceLine.Description, 41, 100) + LineBreak;
                        SalesLineQty2:=SalesLineQty2 + Format(SalesInvoiceLine.Quantity) + LineBreak until SalesInvoiceLine.Next() = 0;
                SalesLineItemNo:=DelChr(SalesLineItemNo, '>', LineBreak);
                SalesLineDescription:=DelChr(SalesLineDescription, '>', LineBreak);
                SalesLineQty2:=DelChr(SalesLineQty2, '>', LineBreak);
            end
            else
            begin
                SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetFilter("Order No.", SalesHeaderDocNo);
                if SalesInvoiceHeader.FindFirst()then begin
                    SalesInvoiceDocNo:=SalesInvoiceHeader."No.";
                    CustomerNo:=SalesInvoiceHeader."Sell-to Customer No.";
                    SalesHeaderPaymentTerms:=SalesInvoiceHeader."Payment Terms Code";
                    SalesHeaderSalesPerson:=SalesInvoiceHeader."Salesperson Code";
                    SalesHeaderShipmentMethod:=SalesInvoiceHeader."Shipment Method Code";
                    SalesHeaderWorkDescription:=SalesInvoiceHeader.GetWorkDescription();
                    OrderDate:=Format(SalesInvoiceHeader."Order Date", 0, '<Month>/<Day>/<Year4>');
                    /*RequestedDeliveryDate := Format(SalesInvoiceHeader.deli, 0, '<Month>/<Day>/<Year4>');
                        ShipVia := SalesInvoiceHeader."Shipping Agent Code" + '- ' + SalesInvoiceHeader."Shipping Agent Service Code";*/
                    User.Reset();
                    User.SetRange("User Security ID", SalesInvoiceHeader.SystemCreatedBy);
                    if User.FindFirst()then EnteredBy:=User."User Name";
                    DShipPackageOptions.Reset();
                    DShipPackageOptions.SetRange("Document No.", "Sales Shipment Header"."Order No.");
                    if DShipPackageOptions.FindFirst()then begin
                        DShipPackagePaymentType:=Format(DShipPackageOptions."Payment Type", 0, '<Text>');
                        DShipPackagePaymentAccountNo:=DShipPackageOptions."Payment Account No.";
                    end;
                    DShipShipmentOptions.Reset();
                    DShipShipmentOptions.SetRange("Document No.", "Sales Shipment Header"."Order No.");
                    if DShipShipmentOptions.FindFirst()then begin
                        ShipFromCompanyName:=DShipShipmentOptions.Company;
                        ShipFromContact:=DShipShipmentOptions.Name;
                        ShipFromAddress1:=DShipShipmentOptions.Address;
                        ShipFromAddress2:=DShipShipmentOptions."Address 2";
                        ShipFromCity:=DShipShipmentOptions.City;
                        ShipFromState:=DShipShipmentOptions.County;
                        ShipFromZipCode:=DShipShipmentOptions."Post Code";
                        ShipFromCountryCode:=DShipShipmentOptions."Country/Region Code";
                    end;
                    ShipToCustomerName:=SalesInvoiceHeader."Ship-to Name";
                    Orbus_ShipToAddress1:=SalesInvoiceHeader."Ship-to Address";
                    Orbus_ShipToAddress2:=SalesInvoiceHeader."Ship-to Address 2";
                    ShipToContact:=SalesInvoiceHeader."Ship-to Contact";
                    ShipToCity:=SalesInvoiceHeader."Ship-to City";
                    ShipToState:=SalesInvoiceHeader."Ship-to County";
                    ShipToZipCOde:=SalesInvoiceHeader."Ship-to Post Code";
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Order No.", "Sales Shipment Header"."Order No.");
                    if SalesInvoiceLine.FindSet()then repeat SalesLineItemNo:=SalesLineItemNo + SalesInvoiceLine."No." + LineBreak;
                            SalesLineDescription:=SalesLineDescription + DelStr(SalesInvoiceLine.Description, 41, 100) + LineBreak;
                            SalesLineQty2:=SalesLineQty2 + Format(SalesInvoiceLine.Quantity) + LineBreak until SalesInvoiceLine.Next() = 0;
                    SalesLineItemNo:=DelChr(SalesLineItemNo, '>', LineBreak);
                    SalesLineDescription:=DelChr(SalesLineDescription, '>', LineBreak);
                    SalesLineQty2:=DelChr(SalesLineQty2, '>', LineBreak);
                end;
            end;
            CurrentDateandTime:=Format(CurrentDateTime, 0, '<Month>/<Day>/<Year4> <Hours12>:<Minutes,2> <AM/PM>');
            GetBarcodes();
        end;
        }
        modify("Sales Shipment Line")
        {
        trigger OnBeforeAfterGetRecord()
        var
            SalesInvoiceLine: Record "Sales Invoice Line";
            SalesLine: Record "Sales Line";
        begin
            LineNo:=LineNo + 1;
            SalesLine.Reset();
            SalesLine.SetRange("No.", "Sales Shipment Line"."Order No.");
            if SalesLine.FindSet()then begin
                SalesLine.Reset();
                SalesLine.SetRange("No.", "Sales Shipment Line"."Order No.");
                SalesLine.SetRange("Line No.", "Sales Shipment Line"."Order Line No.");
                SalesLine.FindFirst();
                SalesLineQty:=SalesLine.Quantity;
            end
            else
            begin
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Order No.", "Sales Shipment Line"."Order No.");
                SalesInvoiceLine.SetRange("Order Line No.", "Sales Shipment Line"."Order Line No.");
                if SalesInvoiceLine.FindFirst()then SalesLineQty:=SalesInvoiceLine.Quantity;
            end;
        end;
        }
        add("Sales Shipment Line")
        {
            column(SalesLineQty; SalesLineQty)
            {
            }
            column(No_; "No.")
            {
            }
            column(LineNo; LineNo)
            {
            }
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
        }
    }
    var CustomerNo: Text;
    SalesHeaderPaymentTerms: Text;
    SalesHeaderShipmentMethod: Text;
    SalesHeaderSalesPerson: Text;
    SalesHeaderWorkDescription: Text;
    SalesHeaderDocNo: Text;
    CurrentDateandTime: Text;
    EncodedSalesHeaderNo: Text;
    EncodedPostedWhseShipNo: Text;
    LineNo: Integer;
    EnteredBy: Text;
    SalesLineQty: Decimal;
    SalesLineItemNo: Text;
    SalesLineQty2: Text;
    SalesLineDescription: Text;
    ShipToCustomerName: Text;
    ShipToContact: Text;
    Orbus_ShipToAddress1: Text;
    Orbus_ShipToAddress2: Text;
    ShipToCity: Text;
    ShipToState: Text;
    ShipToZipCOde: Text;
    ShipFromCompanyName: Text;
    ShipFromContact: Text;
    ShipFromAddress1: Text;
    ShipFromAddress2: Text;
    ShipFromCity: Text;
    ShipFromState: Text;
    ShipFromZipCode: Text;
    ShipFromCountryCode: Text;
    DShipPackagePaymentType: Text;
    DShipPackagePaymentAccountNo: Text;
    OrderDate: Text;
    RequestedDeliveryDate: Text;
    ShipVia: Text;
    SalesInvoiceDocNo: Text;
    local procedure GetBarcodes()
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProviderInterface: Interface "Barcode Font Provider";
        BarcodeFontProviderEnum: Enum "Barcode Font Provider";
        BarcodeString: Text;
        BarcodeString2: Text;
    begin
        BarcodeSymbology:=BarcodeSymbology::Code39;
        BarcodeFontProviderInterface:=BarcodeFontProviderEnum::IDAutomation1D;
        BarcodeString:="Sales Shipment Header"."No.";
        BarcodeString2:=SalesInvoiceDocNo;
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        BarcodeFontProviderInterface.ValidateInput(BarcodeString2, BarcodeSymbology);
        EncodedPostedWhseShipNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
        EncodedSalesHeaderNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString2, BarcodeSymbology);
    end;
}
