report 55108 RegisteredWarehousePick
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Registered Warehouse Pick';
    RDLCLayout = 'ReportLayouts/OrbusRegisteredPick.rdl';

    dataset
    {
        dataitem("Registered Whse. Activity Hdr."; "Registered Whse. Activity Hdr.")
        {
            RequestFilterFields = "No.";

            column(No_; "No.")
            {
            }
            column(Location_Code_Header; "Location Code")
            {
            }
            column(Assigned_User_ID; "Assigned User ID")
            {
            }
            column(SourceDocNo; SourceDocNo)
            {
            }
            column(SalespersonCode; SalespersonCode)
            {
            }
            column(PaymentTermsCode; PaymentTermsCode)
            {
            }
            column(ShipmentMethodCOde; ShipmentMethodCOde)
            {
            }
            column(ExternalDocNo; ExternalDocNo)
            {
            }
            column(CustomerNo; CustomerNo)
            {
            }
            column(EncodedSourceDocNo; EncodedSourceDocNo)
            {
            }
            column(EncodedWareShipmentHeaderNo; EncodedWareShipmentHeaderNo)
            {
            }
            column(CurrentDateandTime; CurrentDateandTime)
            {
            }
            column(OrderDate; OrderDate)
            {
            }
            column(RequestedDeliveryDate; RequestedDeliveryDate)
            {
            }
            column(ShipmentDate; ShipmentDate)
            {
            }
            column(DShipPackagePaymentType; DShipPackagePaymentType)
            {
            }
            column(DShipPackagePaymentAccountNo; DShipPackagePaymentAccountNo)
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
            column(ShipToCustomerName; ShipToCustomerName)
            {
            }
            column(ShipToContact; ShipToContact)
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
            column(ShipToZipCode; ShipToZipCode)
            {
            }
            column(ShipVia; ShipVia)
            {
            }
            column(EnteredBy; EnteredBy)
            {
            }
            column(SalesHeaderWorkDescription; SalesHeaderWorkDescription)
            {
            }
            column(Printed_By; "Printed By")
            {
            }
            dataitem("Registered Whse. Activity Line"; "Registered Whse. Activity Line")
            {
                DataItemLinkReference = "Registered Whse. Activity Hdr.";
                DataItemLink = "No."=field("No.");

                column(Location_Code; "Location Code")
                {
                }
                column(ActivityLine_No_; "No.")
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                column(Item_No_; "Item No.")
                {
                }
                column(Zone_Code; "Zone Code")
                {
                }
                column(Bin_Code; "Bin Code")
                {
                }
                column(Activity_Type; "Activity Type")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Action_Type; "Action Type")
                {
                }
                column(Description; Description)
                {
                }
                column(EncodedBarcodeLineItemNo; EncodedBarcodeLineItemNo)
                {
                }
                column(WarehouseShipmentNoBarcode; WarehouseShipmentNoBarcode)
                {
                }
                column(WarehouseShipmentNoText; WarehouseShipmentNoText)
                {
                }
                trigger OnPreDataItem()
                var
                begin
                    "Registered Whse. Activity Line".Reset();
                    "Registered Whse. Activity Line".SetRange("No.", "Registered Whse. Activity Hdr."."No.");
                end;
                trigger OnAfterGetRecord()
                var
                begin
                    WarehouseShipmentNoText:="Registered Whse. Activity Line"."Whse. Document No.";
                    GetBarcodesForLineNo();
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
                RegisteredWarehouseActivityLine: Record "Registered Whse. Activity Line";
                DShipPackageOptions: Record "DSHIP Package Options";
                DShipShipmentOptions: Record "DSHIP Shipment Options";
                User: Record User;
            begin
                RegisteredWarehouseActivityLine.Reset();
                RegisteredWarehouseActivityLine.SetRange("No.", "Registered Whse. Activity Hdr."."No.");
                if RegisteredWarehouseActivityLine.FindFirst()then SourceDocNo:=RegisteredWarehouseActivityLine."Source No.";
                SalesHeader.Reset();
                SalesHeader.SetRange("No.", SourceDocNo);
                if SalesHeader.FindFirst()then begin
                    CustomerNo:=SalesHeader."Sell-to Customer No.";
                    PaymentTermsCode:=SalesHeader."Payment Terms Code";
                    SalespersonCode:=SalesHeader."Salesperson Code";
                    ExternalDocNo:=SalesHeader."External Document No.";
                    ShipmentMethodCOde:=SalesHeader."Shipment Method Code";
                    OrderDate:=Format(SalesHeader."Order Date", 0, '<Month>/<Day>/<Year4>');
                    RequestedDeliveryDate:=Format(SalesHeader."Requested Delivery Date", 0, '<Month>/<Day>/<Year4>');
                    ShipmentDate:=Format(SalesHeader."Shipment Date", 0, '<Month>/<Day>/<Year4>');
                    ShipToCustomerName:=SalesHeader."Ship-to Name";
                    ShipToContact:=SalesHeader."Ship-to Contact";
                    ShipToAddress1:=SalesHeader."Ship-to Address";
                    ShipToAddress2:=SalesHeader."Ship-to Address 2";
                    ShipToCity:=SalesHeader."Ship-to City";
                    ShipToState:=SalesHeader."Ship-to County";
                    ShipToZipCode:=SalesHeader."Ship-to Post Code";
                    ShipVia:=SalesHeader."Shipping Agent Code" + '- ' + SalesHeader."Shipping Agent Service Code";
                    SalesHeaderWorkDescription:=SalesHeader.GetWorkDescription();
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
                end;
                GetBarcodes();
                GetCurrentDateandTime();
            end;
        }
    }
    var SourceDocNo: Text;
    PaymentTermsCode: Text;
    CustomerNo: Text;
    SalespersonCode: Text;
    ExternalDocNo: Text;
    ShipmentMethodCOde: Text;
    EncodedWareShipmentHeaderNo: Text;
    EncodedSourceDocNo: Text;
    CurrentDateandTime: Text;
    OrderDate: Text;
    RequestedDeliveryDate: Text;
    ShipmentDate: Text;
    DShipPackagePaymentType: Text;
    DShipPackagePaymentAccountNo: Text;
    ShipToCustomerName: Text;
    ShipToContact: Text;
    ShipToAddress1: Text;
    ShipToAddress2: Text;
    ShipToCity: Text;
    ShipToState: Text;
    ShipToZipCode: Text;
    ShipFromCompanyName: Text;
    ShipFromContact: Text;
    ShipFromAddress1: Text;
    ShipFromAddress2: Text;
    ShipFromCity: Text;
    ShipFromState: Text;
    ShipFromZipCode: Text;
    ShipFromCountryCode: Text;
    ShipVia: Text;
    EnteredBy: Text;
    SalesHeaderWorkDescription: Text;
    EncodedBarcodeLineItemNo: Text;
    WarehouseShipmentNoBarcode: Text;
    WarehouseShipmentNoText: Text;
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
        BarcodeString:="Registered Whse. Activity Hdr."."No.";
        BarcodeString2:=SourceDocNo;
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        BarcodeFontProviderInterface.ValidateInput(BarcodeString2, BarcodeSymbology);
        EncodedWareShipmentHeaderNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
        EncodedSourceDocNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString2, BarcodeSymbology);
    end;
    local procedure GetBarcodesForLineNo()
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProviderInterface: Interface "Barcode Font Provider";
        BarcodeFontProviderEnum: Enum "Barcode Font Provider";
        BarcodeString: Text;
        BarcodeString2: Text;
        ItemReference: Record "Item Reference";
    begin
        BarcodeString:='';
        ItemReference.Reset();
        ItemReference.SetRange("Item No.", "Registered Whse. Activity Line"."Item No.");
        ItemReference.SetRange("Variant Code", "Registered Whse. Activity Line"."Variant Code");
        if ItemReference.FindFirst()then BarcodeString:=ItemReference."Reference No."
        else
            BarcodeString:="Registered Whse. Activity Line"."Item No.";
        BarcodeSymbology:=BarcodeSymbology::Code39;
        BarcodeFontProviderInterface:=BarcodeFontProviderEnum::IDAutomation1D;
        BarcodeString2:="Registered Whse. Activity Line"."Whse. Document No.";
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        EncodedBarcodeLineItemNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
        WarehouseShipmentNoBarcode:=BarcodeFontProviderInterface.EncodeFont(BarcodeString2, BarcodeSymbology);
    end;
    local procedure GetCurrentDateandTime()
    var
    begin
        CurrentDateandTime:='Printed: ' + Format(CurrentDateTime, 0, '<Month>/<Day>/<Year4> <Hours12>:<Minutes,2> <AM/PM>')end;
}
