reportextension 55107 OrbusPackingSlipExt extends "Whse. - Posted Shipment"
{
    RDLCLayout = './ReportLayouts/OrbusPackingSlip.rdl';

    dataset
    {
        add("Posted Whse. Shipment Header")
        {
            column(WarehouseShipmentN0; "No.")
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
            column(LineNo; LineNo)
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
            column(ShipToAddress1; ShipToAddress1)
            {
            }
            column(ShipToAddress2; ShipToAddress2)
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
        modify("Posted Whse. Shipment Header")
        {
        trigger OnBeforeAfterGetRecord()
        var
            PostedWhseShipmentLines: Record "Posted Whse. Shipment Line";
            SalesHeader: Record "Sales Header";
            SalesLine: Record "Sales Line";
            User: Record User;
            TypeHelper: Codeunit "Type Helper";
            LineBreak: Text[2];
            DShipPackageOptions: Record "DSHIP Package Options";
            DShipShipmentOptions: Record "DSHIP Shipment Options";
        begin
            LineBreak:=TypeHelper.CRLFSeparator();
            PostedWhseShipmentLines.SetRange("No.", "Posted Whse. Shipment Header"."No.");
            if PostedWhseShipmentLines.FindFirst()then SalesHeaderDocNo:=PostedWhseShipmentLines."Source No.";
            SalesHeader.Reset();
            SalesHeader.SetRange("No.", SalesHeaderDocNo);
            if SalesHeader.FindFirst()then begin
                CustomerNo:=SalesHeader."Sell-to Customer No.";
                SalesHeaderPaymentTerms:=SalesHeader."Payment Terms Code";
                SalesHeaderSalesPerson:=SalesHeader."Salesperson Code";
                SalesHeaderShipmentMethod:=SalesHeader."Shipment Method Code";
                SalesHeaderWorkDescription:=SalesHeader.GetWorkDescription();
                OrderDate:=Format(SalesHeader."Order Date", 0, '<Month>/<Day>/<Year4>');
                RequestedDeliveryDate:=Format(SalesHeader."Requested Delivery Date", 0, '<Month>/<Day>/<Year4>');
                ShipVia:=SalesHeader."Shipping Agent Code" + '- ' + SalesHeader."Shipping Agent Service Code";
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
                    ShipFromCompanyName:=DShipShipmentOptions.Name;
                    ShipFromAddress1:=DShipShipmentOptions.Address;
                    ShipFromAddress2:=DShipShipmentOptions."Address 2";
                    ShipFromCity:=DShipShipmentOptions.City;
                    ShipFromState:=DShipShipmentOptions.County;
                    ShipFromZipCode:=DShipShipmentOptions."Post Code";
                    ShipFromCountryCode:=DShipShipmentOptions."Country/Region Code";
                end;
                ShipToCustomerName:=SalesHeader."Sell-to Customer Name";
                ShipToAddress1:=SalesHeader."Ship-to Address";
                ShipToAddress2:=SalesHeader."Ship-to Address 2";
                ShipToContact:=SalesHeader."Ship-to Contact";
                ShipToCity:=SalesHeader."Ship-to City";
                ShipToState:=SalesHeader."Ship-to County";
                ShipToZipCOde:=SalesHeader."Ship-to Post Code";
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet()then repeat SalesLineItemNo:=SalesLineItemNo + SalesLine."No." + LineBreak;
                        SalesLineDescription:=SalesLineDescription + DelStr(SalesLine.Description, 41, 100) + LineBreak;
                        SalesLineQty2:=SalesLineQty2 + Format(SalesLine.Quantity) + LineBreak until SalesLine.Next() = 0;
                SalesLineItemNo:=DelChr(SalesLineItemNo, '>', LineBreak);
                SalesLineDescription:=DelChr(SalesLineDescription, '>', LineBreak);
                SalesLineQty2:=DelChr(SalesLineQty2, '>', LineBreak);
            end;
            CurrentDateandTime:=Format(CurrentDateTime, 0, '<Month>/<Day>/<Year4> <Hours12>:<Minutes,2> <AM/PM>');
            GetBarcodes();
        end;
        }
        modify("Posted Whse. Shipment Line")
        {
        trigger OnBeforeAfterGetRecord()
        var
            SalesLine: Record "Sales Line";
        begin
            LineNo:=LineNo + 1;
            SalesLine.Reset();
            SalesLine.SetRange("Document No.", "Posted Whse. Shipment Line"."Source No.");
            SalesLine.SetRange("Line No.", "Posted Whse. Shipment Line"."Source Line No.");
            if SalesLine.FindFirst()then SalesLineQty:=SalesLine.Quantity;
            GetBarcodeValuesForLines("Posted Whse. Shipment Line"."Item No.", "Posted Whse. Shipment Line"."Variant Code", "Posted Whse. Shipment Line"."Item No.");
        end;
        }
        add("Posted Whse. Shipment Line")
        {
            column(SalesLineQty; SalesLineQty)
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
    ShipToAddress1: Text;
    ShipToAddress2: Text;
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
        BarcodeString:="Posted Whse. Shipment Header"."No.";
        BarcodeString2:=SalesHeaderDocNo;
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        BarcodeFontProviderInterface.ValidateInput(BarcodeString2, BarcodeSymbology);
        EncodedPostedWhseShipNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
        EncodedSalesHeaderNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString2, BarcodeSymbology);
    end;
    procedure GetBarcodeValuesForLines(var1: Text; var2: Text; var3: Text)
    var
        ItemReference: Record "Item Reference";
        BarcodeString: Text;
        BarcodeInterface: Interface "Barcode Font Provider";
    begin
        if(var1 <> '') and (var2 <> '')then begin
            ItemReference.Reset();
            ItemReference.SetRange("Item No.", var1);
            ItemReference.SetRange("Variant Code", var2);
            if ItemReference.FindFirst()then BarcodeString:=ItemReference."Reference No."
            else
                BarcodeString:=var3;
        end;
        BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeInterface.ValidateInput(BarcodeString, Enum::"Barcode Symbology"::Code128);
        BarcodeInterface.EncodeFont(BarcodeString, Enum::"Barcode Symbology"::Code128);
    end;
}
