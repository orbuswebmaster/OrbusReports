reportextension 55123 IWCommercialInvoiceExt extends "DSHIP Commercial Invoice"
{
    dataset
    {
        modify(diLPHeader)
        {
        trigger OnBeforeAfterGetRecord()
        var
            WarehouseShipmentLine: Record "Warehouse Shipment Line";
            SalesHeader: Record "Sales Header";
            DSHIPCustomsHeader: Record "DSHIP Shipment Customs Header";
            dsh: Record "DSHIP Shipment Customs Line";
            CompanyInfo: Record "Company Information";
        begin
            WarehouseShipmentLine.Reset();
            WarehouseShipmentLine.SetRange("No.", diLPHeader."Source No.");
            if WarehouseShipmentLine.FindFirst()then SalesHeaderNo1:=WarehouseShipmentLine."Source No.";
            SalesHeader.Reset();
            SalesHeader.SetFilter("No.", SalesHeaderNo1);
            if SalesHeader.FindFirst()then begin
                ContactFromSO:=SalesHeader."Ship-to Contact";
                PhoneNoFromSO:=SalesHeader."Sell-to Phone No.";
            end;
            DSHIPCustomsHeader.Reset();
            DSHIPCustomsHeader.SetRange("Document No.", diLPHeader."Source No.");
            if DSHIPCustomsHeader.FindFirst()then ContentFromDSHIPHeader:=Format(DSHIPCustomsHeader."Content Type", 0, '<Text>');
            CompanyInfo.Reset();
            CompanyInfo.FindFirst();
            TaxIDLocation:=CompanyInfo."Federal ID No.";
        end;
        /*dataitem("Sales Header"; "Sales Header")
            {
                DataItemTableView = where("Document Type" = const(Order));

                column(No_; "No.")
                {

                }
                column(Ship_to_Contact; "Ship-to Contact")
                {

                }
                column(Sell_to_Phone_No_; "Sell-to Phone No.")
                {

                }

                trigger OnAfterGetRecord()
                var
                    CompanyInfo: Record "Company Information";
                begin
                    CompanyInfo.Reset();
                    CompanyInfo.FindFirst();
                    TaxIDLocation := CompanyInfo."Federal ID No.";


                end;
            }*/
        }
        modify(diCustomsLine)
        {
        trigger OnBeforeAfterGetRecord()
        var
            WarehouseShipmentLine: Record "Warehouse Shipment Line";
            Item: Record Item;
        begin
        /*if
                diCustomsLine."Variant Code" <> ''
                then begin
                    Item.Reset();
                    Item.SetRange("No.", diCustomsLine."Item No.");
                    if
                    Item.FindFirst()
                    then
                        if
                        Item."Production BOM No."
                end;*/
        end;
        }
    }
    var TaxIDLocation: Text;
    SalesHeaderNo1: Text;
    ContactFromSO: Text;
    PhoneNoFromSO: Text;
    ContentFromDSHIPHeader: Text;
}
