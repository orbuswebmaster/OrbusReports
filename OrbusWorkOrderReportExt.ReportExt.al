reportextension 55104 OrbusWorkOrderReportExt extends "Work Order"
{
    RDLCLayout = './ReportLayouts/OrbusWorkOrder.rdl';

    dataset
    {
        addafter("Sales Line")
        {
            dataitem(ProductionHeader; "Production Order")
            {
                column(EncodedProdOrderNoBarcode; EncodedProdOrderNoBarcode)
                {
                }
                column(No_; "No.")
                {
                }
                trigger OnPreDataItem()
                var
                begin
                    ProductionHeader.Reset();
                    ProductionHeader.SetRange("Source Type", ProductionHeader."Source Type"::"Sales Header");
                    ProductionHeader.SetRange("Source No.", "Sales Header"."No.");
                end;
                trigger OnAfterGetRecord()
                var
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProviderInterface: Interface "Barcode Font Provider";
                    BarcodeInterfaceEnum: Enum "Barcode Font Provider";
                    ProdOrderBarcodeString: Text;
                    var1: Integer;
                begin
                    BarcodeSymbology:=barcodesymbology::Code39;
                    BarcodeFontProviderInterface:=BarcodeInterfaceEnum::IDAutomation1D;
                    ProdOrderBarcodeString:=ProductionHeader."No.";
                    BarcodeFontProviderInterface.ValidateInput(ProdOrderBarcodeString, BarcodeSymbology);
                    EncodedProdOrderNoBarcode:=BarcodeFontProviderInterface.EncodeFont(ProdOrderBarcodeString, BarcodeSymbology);
                end;
            }
        }
        add("Sales Header")
        {
            column(Orbus_ShippingMethodDescription; Orbus_ShippingMethodDescription)
            {
            }
            column(Orbus_DocumentNo; "No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(CustomShipmentDate; CustomShipmentDate)
            {
            }
            column(WorkDescription; WorkDescription)
            {
            }
            column(ProductionOrderNumbers; ProductionOrderNumbers)
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(Shipping_Agent_Service_Code; "Shipping Agent Service Code")
            {
            }
            column(Shipment_Date; Format("Shipment Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(SalesOrderNoEncodedBarcodeString; SalesOrderNoEncodedBarcodeString)
            {
            }
            column(In_Hands_Date; Format("In-Hands Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
        }
        modify("Sales Header")
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            GetShippingMethodDescription();
            GetCustomShipmentDate();
            GetWorkDescriptionFromSalesHeader();
            GetProdOrderNo();
            HeaderBarcodes();
        end;
        }
        add("Sales Line")
        {
            column(SalesComment1; SalesComment1)
            {
            }
            column(SalesComment2; SalesComment2)
            {
            }
            column(SalesComment3; SalesComment3)
            {
            }
            column(SalesComment4; SalesComment4)
            {
            }
            column(SalesComment5; SalesComment5)
            {
            }
            column(Orbus_LineNo_Line; "Line No.")
            {
            }
            column(SalesComment; SalesComment)
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Long_Description; "Long Description")
            {
            }
            column(Variant_Code; "Variant Code")
            {
            }
            column(Description; Description)
            {
            }
        }
        modify("Sales Line")
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            GetSalesLineComments();
            GetSalesLineComments2();
            BlankIfComment();
        end;
        }
    }
    var Orbus_ShippingMethodDescription: Text;
    Comment1: Text;
    Comment2: Text;
    SalesComment1: Text;
    SalesComment2: Text;
    SalesComment3: Text;
    SalesComment4: Text;
    SalesComment5: Text;
    SalesComment: Text;
    CustomShipmentDate: Text;
    WorkDescription: Text;
    ProductionOrderNumbers: Text;
    EncodedProdOrderNoBarcode: Text;
    EncodedProdOrderNoBarcode2: Text;
    EncodedProdOrderNoBarcode3: Text;
    EncodedProdOrderNoBarcode4: Text;
    EncodedProdOrderNoBarcode5: Text;
    EncodedProdOrderNoBarcode6: Text;
    EncodedProdOrderNoBarcode7: Text;
    EncodedProdOrderNoBarcode8: Text;
    SalesOrderNoEncodedBarcodeString: Text;
    local procedure GetCustomShipmentDate()
    var
        ProductionOrder: Record "Production Order";
    begin
        /*CustomShipmentDate := Format(CalcDate('-1D', "Sales Header"."Shipment Date"), 0, '<Month>/<Day>/<Year4>')*/
        ProductionOrder.Reset();
        ProductionOrder.SetRange("Source No.", "Sales Header"."No.");
        if ProductionOrder.FindFirst()then CustomShipmentDate:=Format(ProductionOrder."Due Date", 0, '<Month>/<Day>/<Year4>');
    end;
    local procedure GetShippingMethodDescription()
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        ShipmentMethod.SetRange(Code, "Sales Header"."Shipment Method Code");
        if ShipmentMethod.FindFirst()then Orbus_ShippingMethodDescription:=ShipmentMethod.Description;
    end;
    local procedure GetSalesLineComments2()
    var
        SalesCommentLine: Record "Sales Comment Line";
        SalesLine: Record "Sales Line";
        TypeHelper: Codeunit "Type Helper";
        LineBreak: Text[2];
    begin
        SalesComment:='';
        LineBreak:=TypeHelper.CRLFSeparator();
        SalesCommentLine.Reset();
        SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
        SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
        if SalesCommentLine.FindSet()then begin
            repeat SalesComment:=SalesComment + 'Comment: ' + SalesCommentLine.Comment + LineBreak until SalesCommentLine.Next() = 0;
            SalesComment:=DelChr(SalesComment, '>', LineBreak)end
        else
            SalesComment:='';
    end;
    local procedure BlankIfComment()
    var
        SalesCommentLine: Record "Sales Comment Line";
        SalesLine: Record "Sales Line";
    begin
        if "Sales Line"."No." = '' then "Sales Line"."No.":='Comment';
    end;
    local procedure GetSalesLineComments()
    var
        SalesCommentLine: Record "Sales Comment Line";
        SalesLine: Record "Sales Line";
    begin
        begin
            SalesComment1:='';
            SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
            SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
            SalesCommentLine.SetRange("Line No.", 10000);
            SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
            SalesLine.SetRange("Line No.", "Sales Line"."Line No.");
            if SalesCommentLine.FindFirst()then if SalesLine.FindFirst()then SalesComment1:=SalesCommentLine.Comment;
        end;
        begin
            SalesComment2:='';
            SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
            SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
            SalesCommentLine.SetRange("Line No.", 20000);
            SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
            SalesLine.SetRange("Line No.", "Sales Line"."Line No.");
            if SalesCommentLine.FindFirst()then if SalesLine.FindFirst()then SalesComment2:=SalesCommentLine.Comment;
        end;
        begin
            SalesComment3:='';
            SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
            SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
            SalesCommentLine.SetRange("Line No.", 30000);
            SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
            SalesLine.SetRange("Line No.", "Sales Line"."Line No.");
            if SalesCommentLine.FindFirst()then if SalesLine.FindFirst()then SalesComment3:=SalesCommentLine.Comment;
        end;
        begin
            SalesComment4:='';
            SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
            SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
            SalesCommentLine.SetRange("Line No.", 40000);
            SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
            SalesLine.SetRange("Line No.", "Sales Line"."Line No.");
            if SalesCommentLine.FindFirst()then if SalesLine.FindFirst()then SalesComment4:=SalesCommentLine.Comment;
        end;
        begin
            SalesComment5:='';
            SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
            SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
            SalesCommentLine.SetRange("Line No.", 50000);
            SalesLine.SetRange("Document No.", "Sales Line"."Document No.");
            SalesLine.SetRange("Line No.", "Sales Line"."Line No.");
            if SalesCommentLine.FindFirst()then if SalesLine.FindFirst()then SalesComment5:=SalesCommentLine.Comment;
        end;
    end;
    local procedure GetWorkDescriptionFromSalesHeader()
    var
        SalesHeader: Record "Sales Header";
    begin
        WorkDescription:="Sales Header".GetWorkDescription();
    end;
    local procedure GetProdOrderNo()
    var
        ProductionHeader: Record "Production Order";
        LineBreak: Text[2];
        TypeHelper: Codeunit "Type Helper";
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProviderInterface: Interface "Barcode Font Provider";
        BarcodeFontProviderEnum: Enum "Barcode Font Provider";
        ProdOrderBarcodeString: Text;
    begin
        ProductionOrderNumbers:='';
        LineBreak:=TypeHelper.CRLFSeparator();
        ProductionHeader.Reset();
        ProductionHeader.SetRange("Source Type", ProductionHeader."Source Type"::"Sales Header");
        ProductionHeader.SetRange("Source No.", "Sales Header"."No.");
        if ProductionHeader.FindSet()then repeat ProductionOrderNumbers:=ProductionOrderNumbers + ProductionHeader."No." + LineBreak;
            until ProductionHeader.Next() = 0;
        ProductionOrderNumbers:=DelChr(ProductionOrderNumbers, '>', LineBreak)end;
    local procedure HeaderBarcodes()
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProviderInterface: Interface "Barcode Font Provider";
        BarcodeFontProviderEnum: Enum "Barcode Font Provider";
        BarcodeStringValue: Text;
    begin
        BarcodeSymbology:=BarcodeSymbology::Code39;
        BarcodeFontProviderInterface:=BarcodeFontProviderEnum::IDAutomation1D;
        BarcodeStringValue:="Sales Header"."No.";
        BarcodeFontProviderInterface.ValidateInput(BarcodeStringValue, BarcodeSymbology);
        SalesOrderNoEncodedBarcodeString:=BarcodeFontProviderInterface.EncodeFont(BarcodeStringValue, BarcodeSymbology)end;
}
