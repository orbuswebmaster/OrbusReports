reportextension 55105 OrbusPurchaseOrderExt extends "Purchase Order"
{
    RDLCLayout = './ReportLayouts/OrbusPurchaseOrderNew.rdl';

    dataset
    {
        add("Purchase Header")
        {
            column(Orbus_Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
            }
            column(Orbus_Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Orbus_Order_Date; Format("Order Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(Orbus_PaymentTermsDescription; Orbus_PaymentTermsDescription)
            {
            }
            column(Orbus_Buy_from_Contact; "Buy-from Contact")
            {
            }
            column(Orbus_Ship_to_Address; "Ship-to Address")
            {
            }
            column(Orbus_Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Orbus_Ship_to_Name; "Ship-to Name")
            {
            }
            column(Orbus_Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_County; "Ship-to County")
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(Orbus_ShippingMethodDescription; Orbus_ShippingMethodDescription)
            {
            }
            column(Orbus_Purchaser_Code; "Purchaser Code")
            {
            }
            column(Orbus_Pay_to_Contact; "Pay-to Contact")
            {
            }
            column(Orbus_Pay_to_VendorName; "Pay-to Name")
            {
            }
            column(Orbus_Pay_to_Address; "Pay-to Address")
            {
            }
            column(Orbus_Pay_to_Address_2; "Pay-to Address 2")
            {
            }
            column(Orbus_Pay_to_City; "Pay-to City")
            {
            }
            column(Orbus_Pay_to_County; "Pay-to County")
            {
            }
            column(Orbus_Pay_to_Post_Code; "Pay-to Post Code")
            {
            }
            column(Orbus_CompanyInfoAddress1; Orbus_CompanyInfoAddress1)
            {
            }
            column(Orbus_CompanyInfoAddress2; Orbus_CompanyInfoAddress2)
            {
            }
            column(Orbus_CompanyInfoCity; Orbus_CompanyInfoCity)
            {
            }
            column(Orbus_CompanyInfoName; Orbus_CompanyInfoName)
            {
            }
            column(Orbus_CompanyInfoState; Orbus_CompanyInfoState)
            {
            }
            column(Orbus_CompanyInfoZipCode; Orbus_CompanyInfoZipCode)
            {
            }
        }
        add("Purchase Line")
        {
            column(Orbus_LineNo; Orbus_LineNo)
            {
            }
            column(Orbus_Expected_Receipt_Date; Format("Expected Receipt Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(Orbus_No; "No.")
            {
            }
            column(Orbus_Line_Amount; Format(Amount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_Unit_Cost; Format("Unit Cost", 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Unit_of_Measure; "Unit of Measure")
            {
            }
            column(Orbus_TotalAmount; Format(Orbus_TotalAmount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_LineDescription; Description)
            {
            }
            column(Expected_Receipt_Date; "Expected Receipt Date")
            {
            }
            column(Orbus_VendorItemNo; Orbus_VendorItemNo)
            {
            }
        }
        modify("Purchase Header")
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            GetPaymentTermsDescription();
            GetShippingMethodDescription();
            GetCompanyInfo();
        end;
        trigger OnBeforePreDataItem()
        var
        begin
            if OrbusPONumber <> '' then "Purchase Header".SetRange("No.", OrbusPONumber);
        end;
        }
        modify("Purchase Line")
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            GetLineNo();
            GetTotalAmount();
            GetVendorItemNo();
        end;
        }
    }
    requestpage
    {
        layout
        {
            addfirst(Options)
            {
                field(OrbusPONumber; OrbusPONumber)
                {
                    Caption = 'No.';
                    TableRelation = "Purchase Header"."No." where("Document Type"=const(Order));
                    Visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }
    var Orbus_PaymentTermsDescription: Text;
    Orbus_ShippingMethodDescription: Text;
    Orbus_LineNo: Integer;
    Orbus_CompanyInfoName: Text;
    Orbus_CompanyInfoAddress1: Text;
    Orbus_CompanyInfoAddress2: Text;
    Orbus_CompanyInfoCity: Text;
    Orbus_CompanyInfoState: Text;
    Orbus_CompanyInfoZipCode: Text;
    Orbus_TotalAmount: Decimal;
    OrbusPONumber: Text;
    Orbus_VendorItemNo: Text;
    local procedure GetPaymentTermsDescription()
    var
        PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms.SetRange(Code, "Purchase Header"."Payment Terms Code");
        if PaymentTerms.FindFirst()then Orbus_PaymentTermsDescription:=PaymentTerms.Description;
    end;
    local procedure GetShippingMethodDescription()
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        ShipmentMethod.SetRange(Code, "Purchase Header"."Shipment Method Code");
        if ShipmentMethod.FindFirst()then Orbus_ShippingMethodDescription:=ShipmentMethod.Description;
    end;
    local procedure GetCompanyInfo()
    var
        CompanyInformation: Record "Company Information";
    begin
        if CompanyInformation.FindFirst()then begin
            Orbus_CompanyInfoName:=CompanyInformation.Name;
            Orbus_CompanyInfoAddress1:=CompanyInformation.Address;
            Orbus_CompanyInfoAddress2:=CompanyInformation."Address 2";
            Orbus_CompanyInfoCity:=CompanyInformation.City;
            Orbus_CompanyInfoState:=CompanyInformation.County;
            Orbus_CompanyInfoZipCode:=CompanyInformation."Post Code";
        end;
    end;
    local procedure GetLineNo()
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Orbus_LineNo:=Orbus_LineNo + 1;
    end;
    local procedure GetTotalAmount()
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document No.", "Purchase Header"."No.");
        PurchaseLine.CalcSums("Line Amount");
        Orbus_TotalAmount:=PurchaseLine."Line Amount";
    end;
    local procedure GetVendorItemNo()
    var
        Item: Record Item;
        ItemReference: Record "Item Reference";
    begin
        if "Purchase Line".Type = "Purchase Line".Type::Item then begin
            Item.Reset();
            Item.SetRange("No.", "Purchase Line"."No.");
            if Item.FindFirst()then begin
                if(Item.Type = Item.Type::"Non-Inventory")then Orbus_VendorItemNo:="Purchase Line"."Variant Code";
                if(Item.Type = Item.Type::Inventory) and ("Purchase Line"."Item Reference No." <> '')then Orbus_VendorItemNo:="Purchase Line"."Item Reference No.";
                if(Item.Type = Item.Type::Inventory) and ("Purchase Line"."Item Reference No." = '')then begin
                    ItemReference.Reset();
                    ItemReference.SetRange("Item No.", "Purchase Line"."No.");
                    ItemReference.SetRange("Variant Code", "Purchase Line"."Variant Code");
                    if ItemReference.FindFirst()then Orbus_VendorItemNo:=ItemReference."Reference No."
                    else
                        Orbus_VendorItemNo:='';
                end;
            end
            else
                Orbus_VendorItemNo:='';
        end
        else
            Orbus_VendorItemNo:='';
    end;
}
