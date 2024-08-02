report 55188 CustomWorkOrder
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/OrbusCustomWorkOrder.rdl';
    Caption = 'Work Order';
    ApplicationArea = All;
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Invoice Header';

            column(No_; "No.")
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
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
            column(WorkDescriptionText; GetWorkDescription())
            {
            }
            column(ProductionOrderNumbers; ProductionOrderNumbers)
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(Shipping_Agent_Service_Code_2; "Shipping Agent Service Code 2")
            {
            }
            column(Shipment_Date; Format("Shipment Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(In_Hands_Date; Format("In-Hands Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(EncodedSalesOrderNoBarcode; EncodedSalesOrderNoBarcode)
            {
            }
            dataitem("Production Order"; "Production Order")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Source No."=field("Order No.");

                column(ProdOrderNo; "No.")
                {
                }
                column(EncodedProdOrderBarcode; EncodedProdOrderBarcode)
                {
                }
                trigger OnPreDataItem()
                var
                begin
                    "Production Order".Reset();
                    "Production Order".SetRange("Source No.", "Sales Invoice Header"."Order No.");
                end;
                trigger OnAfterGetRecord()
                var
                begin
                    GetProdOrderNoBarcodes();
                end;
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(No_SalesLine; "No.")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(UnitofMeasure_SalesLine; "Unit of Measure")
                {
                }
                column(Type_SalesLine; Type)
                {
                }
                column(SalesLineComments; SalesLineComments)
                {
                }
                column(Orbus_LineNo_Line; "Line No.")
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
                trigger OnAfterGetRecord()
                var
                    SalesCommentLine: Record "Sales Comment Line";
                    TypeHelper: Codeunit "Type Helper";
                    LineBreak: Text;
                begin
                    SalesLineComments:='';
                    LineBreak:=TypeHelper.CRLFSeparator();
                    SalesCommentLine.Reset();
                    SalesCommentLine.SetRange("No.", "Sales Invoice Line"."Document No.");
                    SalesCommentLine.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                    if SalesCommentLine.FindSet()then repeat SalesLineComments:=SalesLineComments + SalesCommentLine.Comment + LineBreak;
                        until SalesCommentLine.Next() = 0
                    else
                        SalesLineComments:='';
                    if SalesLineComments <> '' then SalesLineComments:=DelChr(SalesLineComments, '>', LineBreak);
                end;
            }
            trigger OnAfterGetRecord()
            var
                Inst: InStream;
                Out: OutStream;
                TempBlob: Codeunit "Temp Blob";
                Test1: Text;
            begin
                GetSalesOrderNoBarcode();
                GetWorkDescription();
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    local procedure GetSalesOrderNoBarcode()
    var
        BarcodeInterface: Interface "Barcode Font Provider";
        BarcodeEnum: Enum "Barcode Font Provider";
        BarcodeString: Text;
    begin
        BarcodeInterface:=BarcodeEnum::IDAutomation1D;
        BarcodeString:="Sales Invoice Header"."Order No.";
        BarcodeInterface.ValidateInput(BarcodeString, Enum::"Barcode Symbology"::Code39);
        EncodedSalesOrderNoBarcode:=BarcodeInterface.EncodeFont(BarcodeString, Enum::"Barcode Symbology"::Code39);
    end;
    local procedure GetProdOrderNoBarcodes()
    var
        BarcodeInterface: Interface "Barcode Font Provider";
        BarcodeEnum: Enum "Barcode Font Provider";
        BarcodeString: Text;
    begin
        BarcodeInterface:=BarcodeEnum::IDAutomation1D;
        BarcodeString:="Production Order"."No.";
        BarcodeInterface.ValidateInput(BarcodeString, Enum::"Barcode Symbology"::Code39);
        EncodedProdOrderBarcode:=BarcodeInterface.EncodeFont(BarcodeString, Enum::"Barcode Symbology"::Code39);
    end;
    local procedure GetShippingMethodDescription()
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        ShipmentMethod.Reset();
        ShipmentMethod.SetRange(Code, "Sales Invoice Header"."Shipment Method Code");
        if ShipmentMethod.FindFirst()then Orbus_ShippingMethodDescription:=ShipmentMethod.Description;
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
        ProductionHeader.SetRange("Source No.", "Sales Invoice Header"."Order No.");
        if ProductionHeader.FindSet()then repeat ProductionOrderNumbers:=ProductionOrderNumbers + ProductionHeader."No." + LineBreak;
            until ProductionHeader.Next() = 0;
        ProductionOrderNumbers:=DelChr(ProductionOrderNumbers, '>', LineBreak)end;
    local procedure GetCustomShipmentDate()
    var
        ProductionOrder: Record "Production Order";
    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange("Source No.", "Sales Invoice Header"."Order No.");
        if ProductionOrder.FindFirst()then CustomShipmentDate:=Format(ProductionOrder."Due Date", 0, '<Month>/<Day>/<Year4>');
    end;
    local procedure GetWorkDescription(): Text var
        TempBlob: Codeunit "Temp Blob";
        Inst: Instream;
        Out: OutStream;
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", "Sales Invoice Header"."No.");
        if SalesInvoiceHeader.FindFirst()then begin
            TempBlob.CreateInStream(Inst);
            TempBlob.CreateOutStream(Out);
            SalesInvoiceHeader.CalcFields(SalesInvoiceHeader."Work Description");
            SalesInvoiceHeader."Work Description".CreateInStream(Inst);
            Inst.ReadText(WorkDescriptionText);
            exit(WorkDescriptionText);
        end;
    end;
    var SalesLineComments: Text;
    Orbus_ShippingMethodDescription: Text;
    ProductionOrderNumbers: Text;
    CustomShipmentDate: Text;
    TestVar: Text;
    EncodedSalesOrderNoBarcode: Text;
    EncodedProdOrderBarcode: Text;
    WorkDescriptionText: Text;
}
