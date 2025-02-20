reportextension 55110 OrbusPickExt extends "Picking List"
{
    //RDLCLayout = './ReportLayouts/OrbusPickSlip.rdl';

    dataset
    {
        addafter("Warehouse Activity Line")
        {
            dataitem(Line; "Sales Line")
            {
                DataItemLinkReference = "Warehouse Activity Line";
                DataItemLink = "Document No." = field("Source No.");

                column(No_; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(SalesLineComments; SalesLineComments)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                    SalesCommentLine: Record "Sales Comment Line";
                    LineBreak: Text;
                    TypeHelper: Codeunit "Type Helper";
                begin
                    SalesLineComments := '';
                    LineBreak := TypeHelper.CRLFSeparator();
                    Item.Reset();
                    Item.SetRange("No.", Line."No.");
                    if Item.FindFirst() then begin
                        if (Item.Type = Item.Type::Inventory) or (Item.Type = Item.Type::Service) then
                            CurrReport.Skip()
                        else begin
                            SalesCommentLine.Reset();
                            SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::Order);
                            SalesCommentLine.SetRange("No.", Line."Document No.");
                            SalesCommentLine.SetRange("Document Line No.", Line."Line No.");
                            if SalesCommentLine.FindSet() then
                                repeat
                                    SalesLineComments := SalesLineComments + 'Comment: ' + SalesCommentLine.Comment + LineBreak;
                                until SalesCommentLine.Next() = 0
                            else
                                SalesLineComments := '';
                            if SalesLineComments <> '' then SalesLineComments := DelChr(SalesLineComments, '>', LineBreak)
                        end;
                    end;
                end;
            }
        }
        /*addbefore("Warehouse Activity Line")
        {
            dataitem(Line2;"Sales Line")
            {

                column(ItemNo; "No.")
                {

                }
                column(ItemDescription;Description)
                {

                }
                column(ItemQuantity;Quantity)
                {

                }
                trigger OnPreDataItem()
                var

                begin
                    Line2.Reset();
                    Line2.SetFilter("Document No.", "Warehouse Activity Header"."Source No.");
                    Line2.SetRange(Type, Line2.Type::Item);
                end;



                trigger OnAfterGetRecord()
                var
                Item: Record Item;
                begin
                    Item.Reset();
                    Item.SetRange("No.", Line2."No.");
                    Item.SetRange("Assembly Policy", Item."Assembly Policy"::"Assemble-to-Order");
                    if
                    Item.FindFirst()
                    then
                    exit
                    else
                    CurrReport.Skip();
                end;
            }
        }*/
        add(WhseActLine)
        {
            column(Qty__Handled; "Qty. Handled")
            {
            }
            column(Qty__Outstanding; "Qty. Outstanding")
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(EncodedBarcodeLineItemNo; EncodedBarcodeLineItemNo)
            {
            }
            column(NonInventoryItemNo; NonInventoryItemNo)
            {
            }
            column(NonInventoryItemDescription; NonInventoryItemDescription)
            {
            }
            column(NonInventoryItemQuantity; NonInventoryItemQuantity)
            {
            }
        }
        add("Warehouse Activity Header")
        {
            column(Location_Code; "Location Code")
            {
            }
            column(Assigned_User_ID; "Assigned User ID")
            {
            }
            column(PickNo; "No.")
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
            column(WarehouseShipmentNoBarcode; WarehouseShipmentNoBarcode)
            {
            }
            column(WarehouseShipmentNoText; WarehouseShipmentNoText)
            {
            }
            column(Printed_By; Printed_By)
            {
            }
            column(AssembleToOrderNo; AssembleToOrderNo)
            {
            }
            column(AssembleToOrderDescription; AssembleToOrderDescription)
            {
            }
            column(AssembleToOrderQty; AssembleToOrderQty)
            {
            }
        }
        modify("Warehouse Activity Header")
        {
            trigger OnBeforeAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
                WarehouseActivityLine: Record "Warehouse Activity Line";
                DShipPackageOptions: Record "DSHIP Package Options";
                DShipShipmentOptions: Record "DSHIP Shipment Options";
                User: Record User;
            begin
                WarehouseActivityLine.Reset();
                WarehouseActivityLine.SetRange("No.", "Warehouse Activity Header"."No.");
                if WarehouseActivityLine.FindFirst() then SourceDocNo := WarehouseActivityLine."Source No.";
                SalesHeader.Reset();
                SalesHeader.SetRange("No.", SourceDocNo);
                if SalesHeader.FindFirst() then begin
                    CustomerNo := SalesHeader."Sell-to Customer No.";
                    PaymentTermsCode := SalesHeader."Payment Terms Code";
                    SalespersonCode := SalesHeader."Salesperson Code";
                    ExternalDocNo := SalesHeader."External Document No.";
                    ShipmentMethodCOde := SalesHeader."Shipment Method Code";
                    OrderDate := Format(SalesHeader."Order Date", 0, '<Month>/<Day>/<Year4>');
                    RequestedDeliveryDate := Format(SalesHeader."Requested Delivery Date", 0, '<Month>/<Day>/<Year4>');
                    ShipmentDate := Format(SalesHeader."Shipment Date", 0, '<Month>/<Day>/<Year4>');
                    ShipToCustomerName := SalesHeader."Ship-to Name";
                    ShipToContact := SalesHeader."Ship-to Contact";
                    ShipToAddress1 := SalesHeader."Ship-to Address";
                    ShipToAddress2 := SalesHeader."Ship-to Address 2";
                    ShipToCity := SalesHeader."Ship-to City";
                    ShipToState := SalesHeader."Ship-to County";
                    ShipToZipCode := SalesHeader."Ship-to Post Code";
                    ShipVia := SalesHeader."Shipping Agent Code" + '- ' + SalesHeader."Shipping Agent Service Code";
                    SalesHeaderWorkDescription := SalesHeader.GetWorkDescription();
                    User.Reset();
                    User.SetRange("User Security ID", SalesHeader.SystemCreatedBy);
                    if User.FindFirst() then EnteredBy := User."User Name";
                    DShipPackageOptions.Reset();
                    DShipPackageOptions.SetRange("Document No.", SalesHeader."No.");
                    if DShipPackageOptions.FindFirst() then begin
                        DShipPackagePaymentType := Format(DShipPackageOptions."Payment Type", 0, '<Text>');
                        DShipPackagePaymentAccountNo := DShipPackageOptions."Payment Account No.";
                    end;
                    DShipShipmentOptions.Reset();
                    DShipShipmentOptions.SetRange("Document No.", SalesHeader."No.");
                    if DShipShipmentOptions.FindFirst() then begin
                        ShipFromCompanyName := DShipShipmentOptions.Company;
                        ShipFromCompanyName := DShipShipmentOptions.Name;
                        ShipFromAddress1 := DShipShipmentOptions.Address;
                        ShipFromAddress2 := DShipShipmentOptions."Address 2";
                        ShipFromCity := DShipShipmentOptions.City;
                        ShipFromState := DShipShipmentOptions.County;
                        ShipFromZipCode := DShipShipmentOptions."Post Code";
                        ShipFromCountryCode := DShipShipmentOptions."Country/Region Code";
                    end;
                end;
                GetBarcodes();
                GetCurrentDateandTime();
                GetAssemblyItems();
            end;
        }
        modify(WhseActLine)
        {
            trigger OnBeforeAfterGetRecord()
            var
            begin
                WarehouseShipmentNoText := WhseActLine."Whse. Document No.";
                GetBarcodesForLineNo();
                /*GetNonInventoryItemsFromSO();*/
            end;
        }
    }
    rendering
    {
        layout(OrbusPickSlip)
        {
            Type = RDLC;
            Caption = 'OrbusPickSlip';
            Summary = 'Regular Pick Slip';
            LayoutFile = './ReportLayouts/OrbusPickSlip.rdl';
        }
        layout(OrbusInventoryPickSlip)
        {
            Type = RDLC;
            Caption = 'OrbusInventoryPickSlip';
            Summary = 'Inventory Pick Slip';
            LayoutFile = './ReportLayouts/OrbusInventoryPickSlip.rdl';
        }
    }
    trigger OnPreReport()
    var
    begin
        Printed_By := UserId();
    end;

    trigger OnPostReport()
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
    begin
        WhseActivityHeader.Reset();
        WhseActivityHeader.SetRange("No.", "Warehouse Activity Header"."No.");
        if WhseActivityHeader.FindSet() then
            repeat
                WhseActivityHeader."Printed By" := UserId();
                WhseActivityHeader."Printed At" := CurrentDateTime();
                WhseActivityHeader.Modify();
            until WhseActivityHeader.Next() = 0;
    end;

    var
        SourceDocNo: Text;
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
        NonInventoryItemNo: Text;
        NonInventoryItemQuantity: Text;
        NonInventoryItemDescription: Text;
        NonInventoryItemUOM: Text;
        NonInventoryLineNo: Text;
        SalesLineComments: Text;
        Printed_By: Text;
        AssembleToOrderNo: Text;
        AssembleToOrderDescription: Text;
        AssembleToOrderQty: Text;

    local procedure GetBarcodes()
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProviderInterface: Interface "Barcode Font Provider";
        BarcodeFontProviderEnum: Enum "Barcode Font Provider";
        BarcodeString: Text;
        BarcodeString2: Text;
        BarcodeString3: Text;
        PickLine: Record "Warehouse Activity Line";
    begin
        PickLine.Reset();
        PickLine.SetRange("No.", "Warehouse Activity Header"."No.");
        if PickLine.FindFirst() then begin
            BarcodeString3 := PickLine."Whse. Document No.";
            WarehouseShipmentNoText := PickLine."Whse. Document No.";
        end;
        PickLine.Reset();
        BarcodeSymbology := BarcodeSymbology::Code39;
        BarcodeFontProviderInterface := BarcodeFontProviderEnum::IDAutomation1D;
        BarcodeString := "Warehouse Activity Header"."No.";
        BarcodeString2 := SourceDocNo;
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        BarcodeFontProviderInterface.ValidateInput(BarcodeString2, BarcodeSymbology);
        if "Warehouse Activity Header".Type <> "Warehouse Activity Header".Type::"Invt. Pick" then
            BarcodeFontProviderInterface.ValidateInput(BarcodeString3, BarcodeSymbology);
        EncodedWareShipmentHeaderNo := BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
        EncodedSourceDocNo := BarcodeFontProviderInterface.EncodeFont(BarcodeString2, BarcodeSymbology);
        WarehouseShipmentNoBarcode := BarcodeFontProviderInterface.EncodeFont(BarcodeString3, BarcodeSymbology);
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
        if (WhseActLine."Item No." <> '') and (WhseActLine."Variant Code" <> '') then begin
            ItemReference.Reset();
            ItemReference.SetRange("Item No.", WhseActLine."Item No.");
            ItemReference.SetRange("Variant Code", WhseActLine."Variant Code");
            if ItemReference.FindFirst() then
                BarcodeString := ItemReference."Reference No."
            else
                BarcodeString := WhseActLine."Item No.";
        end
        else
            BarcodeString := WhseActLine."Item No.";
        BarcodeSymbology := BarcodeSymbology::Code39;
        BarcodeFontProviderInterface := BarcodeFontProviderEnum::IDAutomation1D;
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        EncodedBarcodeLineItemNo := BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
    end;

    local procedure GetCurrentDateandTime()
    var
    begin
        CurrentDateandTime := 'Printed: ' + Format(CurrentDateTime, 0, '<Month>/<Day>/<Year4> <Hours12>:<Minutes,2> <AM/PM>')
    end;

    procedure GetAssemblyItems()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        LineBreak: Text;
        TypeHelper: Codeunit "Type Helper";
    begin
        LineBreak := TypeHelper.CRLFSeparator();
        AssembleToOrderNo := '';
        AssembleToOrderDescription := '';
        AssembleToOrderQty := '';
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", "Warehouse Activity Header"."Source No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
                Item.Reset();
                Item.SetRange("No.", SalesLine."No.");
                Item.SetRange("Assembly Policy", Item."Assembly Policy"::"Assemble-to-Order");
                if Item.FindFirst() then begin
                    AssembleToOrderNo := AssembleToOrderNo + Item."No." + LineBreak;
                    AssembleToOrderDescription := AssembleToOrderDescription + Item.Description + LineBreak;
                    AssembleToOrderQty := AssembleToOrderQty + Format(SalesLine.Quantity) + LineBreak;
                end;
            until SalesLine.Next() = 0;
        if AssembleToOrderNo <> '' then begin
            AssembleToOrderNo := DelChr(AssembleToOrderNo, '>', LineBreak);
            AssembleToOrderDescription := DelChr(AssembleToOrderDescription, '>', LineBreak);
            AssembleToOrderQty := DelChr(AssembleToOrderQty, '>', LineBreak);
        end;
    end;
    /*local procedure GetNonInventoryItemsFromSO()
        var
            SalesLine: Record "Sales Line";
            Item: Record Item;
            LineBreak: Text;
            TypeHelper: Codeunit "Type Helper";
            WarehouseActivityLine: Record "Warehouse Activity Line";
            LineNo: Integer;
            SalesCommentLine: Record "Sales Comment Line";
        begin
            WarehouseActivityLine.Reset();
            WarehouseActivityLine.SetRange("No.", "Warehouse Activity Header"."No.");
            if
            WarehouseActivityLine.FindLast()
            then
                LineNo := WarehouseActivityLine."Line No.";

            if
            LineNo = WhseActLine."Line No."
            then begin
                NonInventoryItemNo := '';
                NonInventoryItemDescription := '';
                NonInventoryItemQuantity := '';
                NonInventoryItemUOM := '';
                SalesLineComments := '';

                LineBreak := TypeHelper.CRLFSeparator();
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", WhseActLine."Source No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                if
                SalesLine.FindSet()
                then
                    repeat
                        SalesLineComments := '';
                        Item.Reset();
                        Item.SetRange("No.", SalesLine."No.");
                        if
                        Item.FindFirst()
                        then begin
                            if
                            Item.Type = Item.Type::"Non-Inventory"
                            then begin
                                SalesCommentLine.Reset();
                                SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::Order);
                                SalesCommentLine.SetRange("No.", SalesLine."Document No.");
                                SalesCommentLine.SetRange("Document Line No.", SalesLine."Line No.");
                                if
                                SalesCommentLine.FindSet()
                                then
                                    repeat
                                        SalesLineComments := SalesLineComments + SalesCommentLine.Comment + LineBreak;
                                    until
                                    SalesCommentLine.Next() = 0;

                                if
                                SalesLineComments <> ''
                                then begin
                                    SalesLineComments := DelChr(SalesLineComments, '>', LineBreak);
                                    NonInventoryItemNo := NonInventoryItemNo + SalesLine."No." + LineBreak + 'Comment:' + LineBreak;
                                    NonInventoryItemDescription := NonInventoryItemDescription + SalesLine.Description + LineBreak + SalesLineComments + LineBreak;
                                    NonInventoryItemQuantity := NonInventoryItemQuantity + Format(SalesLine.Quantity) + LineBreak + LineBreak;
                                    NonInventoryItemUOM := NonInventoryItemUOM + SalesLine."Unit of Measure" + LineBreak + LineBreak;
                                end
                                else begin
                                    NonInventoryItemNo := NonInventoryItemNo + SalesLine."No." + LineBreak;
                                    NonInventoryItemDescription := NonInventoryItemDescription + SalesLine.Description + LineBreak + SalesLineComments + LineBreak;
                                    NonInventoryItemQuantity := NonInventoryItemQuantity + Format(SalesLine.Quantity) + LineBreak;
                                    NonInventoryItemUOM := NonInventoryItemUOM + SalesLine."Unit of Measure" + LineBreak;
                                end;
                            end;
                        end;
                    until
                    SalesLine.Next() = 0;


                if
                NonInventoryItemNo <> ''
                then begin
                    NonInventoryItemNo := DelChr(NonInventoryItemNo, '>', LineBreak);
                    NonInventoryItemDescription := DelChr(NonInventoryItemDescription, '>', LineBreak);
                    NonInventoryItemQuantity := DelChr(NonInventoryItemQuantity, '>', LineBreak);
                    NonInventoryItemUOM := DelChr(NonInventoryItemUOM, '>', LineBreak);
                end;
            end;
        end;*/
}
