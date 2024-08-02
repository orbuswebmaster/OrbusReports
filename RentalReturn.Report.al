report 55189 RentalReturn
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/OrbusRentalReturn.rdl';
    EnableHyperlinks = true;
    ApplicationArea = All;
    Caption = 'Rental Return';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
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
            column(Source_No; "Source No.")
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
            dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
            {
                DataItemLinkReference = "Warehouse Activity Header";
                DataItemLink = "No."=field("No.");

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
                column(Line_No; "Line No.")
                {
                }
                column(Zone_Code; "Zone Code")
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                column(Bin_Code; "Bin Code")
                {
                }
                column(Activity_Type; "Activity Type")
                {
                }
                column(Action_Type; "Action Type")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Item_No; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                trigger OnAfterGetRecord()
                var
                begin
                    WarehouseShipmentNoText:="Warehouse Activity Line"."Whse. Document No.";
                end;
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Warehouse Activity Header";
                DataItemLink = "Document No."=field("Source No.");

                column(SalesLine_No; "No.")
                {
                }
                column(SalesLine_Description; Description)
                {
                }
                column(SalesLine_Quantity; Quantity)
                {
                }
                column(SalesLineComments; SalesLineComments)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
            begin
                Printed_By:=UserId();
            /*GetBarcodeValues();*/
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
    SalesLineComments: Text;
    Printed_By: Text;
/*local procedure GetBarcodeValues()
    var
        BarcodeInterface: Interface "Barcode Font Provider";
        BarcodeEnum: Enum "Barcode Font Provider";
        BarcodeStringValue: Text;
    begin
        BarcodeInterface := BarcodeEnum::IDAutomation1D;
        BarcodeStringValue := "Warehouse Activity Header"."Source No.";
        BarcodeInterface.ValidateInput(BarcodeStringValue, Enum::"Barcode Symbology"::Code39);
        EncodedWareShipmentHeaderNo := BarcodeInterface.EncodeFont(BarcodeStringValue, Enum::"Barcode Symbology"::Code39);
    end;*/
}
