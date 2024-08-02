reportextension 55103 OrbusSalesInvoiceExt extends "Standard Sales - Invoice"
{
    RDLCLayout = './ReportLayouts/OrbusSalesInvoicenew.rdl';

    dataset
    {
        add(Header)
        {
            column(Orbus_ShippingMethodDescription; Orbus_ShippingMethodDescription)
            {
            }
            column(Orbus_PaymentTermsLongDescription; Orbus_PaymentTermsLongDescription)
            {
            }
            column(Orbus_SellToCustomerName; "Sell-to Customer Name")
            {
            }
            column(Orbus_BillToName; "Bill-to Name")
            {
            }
            column(Orbus_ShipToName; Orbus_ShipToName)
            {
            }
            column(Orbus_Document_Date; Format("Document Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(Orbus_Order_Date; Format("Order Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(Orbus_Salesperson_Code; "Salesperson Code")
            {
            }
            column(Orbus_Ship_to_City; "Ship-to City")
            {
            }
            column(Orbus_Ship_to_County; "Ship-to County")
            {
            }
            column(Orbus_Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(Orbus_Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {
            }
            column(Orbus_Ship_to_Address; "Ship-to Address")
            {
            }
            column(Orbus_Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Orbus_Bill_to_City; "Bill-to City")
            {
            }
            column(Orbus_Bill_to_Contact; "Bill-to Contact")
            {
            }
            column(Orbus_Bill_to_County; "Bill-to County")
            {
            }
            column(Orbus_Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            {
            }
            column(Orbus_Bill_to_Post_Code; "Bill-to Post Code")
            {
            }
            column(Orbus_Bill_to_Address; "Bill-to Address")
            {
            }
            column(Orbus_Bill_to_Address_2; "Bill-to Address 2")
            {
            }
            column(Orbus_Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(Orbus_SalesOrder_No_; "Order No.")
            {
            }
            column(Orbus_Bill_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(Orbus_PaymentTermsDescription; Orbus_PaymentTermsDescription)
            {
            }
            column(Orbus_Posting_Date; Format("Posting Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(Orbus_LocationName; Orbus_LocationName)
            {
            }
            column(Orbus_UserName; Orbus_UserName)
            {
            }
            column(WarehousePickNo; WarehousePickNo)
            {
            }
            column(Package_Tracking_No_; "Package Tracking No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(Orbus_SubtotalText; Orbus_SubtotalText)
            {
            }
            column(Orbus_TotalInclTaxText; Orbus_TotalInclTaxText)
            {
            }
            column(Orbus_DiscountTotalText; Orbus_DiscountTotalText)
            {
            }
            column(Orbus_TotalTaxAmountText; Orbus_TotalTaxAmountText)
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(No_; "No.")
            {
            }
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(Shipment_Date; Format("Shipment Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
        }
        add(Line)
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
            column(Orbus_Line_Amount; Format("Line Amount", 0, '$<Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_Unit_Price; Format("Unit Price", 0, '$<Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(Orbus_PaidAmount; Format(Orbus_PaidAmount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_FinalTotal; Format(Orbus_FinalTotal, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_InvoiceDiscountTotal; Format(Orbus_InvoiceDiscountTotal, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_GrossAmount; Format(Orbus_GrossAmount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_SubtotalSum; Format(Orbus_SubtotalSum, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Shipment_Date_Line; Format("Shipment Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(Ava_Tax_Rate; Format("Ava Tax Rate", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(SalesComments; SalesComments)
            {
            }
        }
        modify(Header)
        {
        trigger OnAfterAfterGetRecord()
        begin
            GetDescriptionValues();
            GetPaymentTermsLongDescription();
            GetLocationName();
            GetUserName();
            GetTotalAmounts2();
            GetPaymentTermsDescription()end;
        }
        modify(Line)
        {
        trigger OnAfterAfterGetRecord()
        begin
            GetSalesLineComments();
            GetTotalAmounts();
            GetPaidAmountFromCustomerLedgerEntries();
            if Line.Quantity = 0 then CurrReport.Skip();
        end;
        }
    }
    var Orbus_ShippingMethodDescription: Text;
    Orbus_PaymentTermsLongDescription: Text;
    Orbus_SellToCustomerName: Text;
    Orbus_BillToCustomerName: Text;
    Orbus_ShipToName: Text;
    Comment1: Text;
    Comment2: Text;
    SalesComment1: Text;
    SalesComment2: Text;
    SalesComment3: Text;
    SalesComment4: Text;
    SalesComment5: Text;
    Orbus_Line_Amount: Text;
    Orbus_PaymentTermsDescription: Text;
    Orbus_LocationName: Text;
    Orbus_InvoiceDiscountTotal: Decimal;
    Orbus_PaidAmount: Decimal;
    Orbus_FinalTotal: Decimal;
    Orbus_AmountLineNoTax: Decimal;
    Orbus_AmountLineWithTax: Decimal;
    Orbus_CLERemainingAmount: Decimal;
    Orbus_CLEInvoiceTotal: Decimal;
    Orbus_GrossAmount: Decimal;
    Orbus_SubtotalSum: Decimal;
    Orbus_UserName: Text;
    WarehousePickNo: Text;
    Orbus_OverallTotal: Text;
    Orbus_TotalInclTaxText: Text;
    Orbus_SubtotalText: Text;
    Orbus_SubtotalDecimal: Decimal;
    Orbus_DiscountTotalText: Text;
    Orbus_DiscountTotalDecimal: Decimal;
    Orbus_TotalInclTaxDecimal: Decimal;
    Orbus_TotalTaxAmountText: Text;
    Orbus_TotalTaxAmountDecimal: Decimal;
    SalesComments: Text;
    local procedure GetDescriptionValues()
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        ShipmentMethod.SetRange(Code, Header."Shipment Method Code");
        if ShipmentMethod.FindFirst()then Orbus_ShippingMethodDescription:=ShipmentMethod.Description;
    end;
    local procedure GetPaymentTermsLongDescription()
    var
        PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms.SetRange(Code, Header."Payment Terms Code");
        if PaymentTerms.FindFirst()then Orbus_PaymentTermsLongDescription:=PaymentTerms."Long Description";
    end;
    local procedure GetPaymentTermsDescription()
    var
        PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms.SetRange(Code, Header."Payment Terms Code");
        if PaymentTerms.FindFirst()then Orbus_PaymentTermsDescription:=PaymentTerms.Description;
    end;
    local procedure GetLocationName()
    var
        Location: Record Location;
    begin
        Location.SetRange(Code, Header."Location Code");
        if Location.FindFirst()then Orbus_LocationName:=Location.Name;
    end;
    local procedure GetTotalAmounts()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Document No.", Line."Document No.");
        SalesInvoiceLine.CalcSums(Amount, "Amount Including VAT", "Inv. Discount Amount");
        Orbus_AmountLineNoTax:=SalesInvoiceLine.Amount;
        Orbus_AmountLineWithTax:=SalesInvoiceLine."Amount Including VAT";
        Orbus_InvoiceDiscountTotal:=SalesInvoiceLine."Inv. Discount Amount";
        Orbus_GrossAmount:=SalesInvoiceLine.Amount;
    end;
    local procedure GetPaidAmountFromCustomerLedgerEntries()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        CustomerLedgerEntries: Record "Cust. Ledger Entry";
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        begin
            DetailedCustLedgerEntry.SetRange("Cust. Ledger Entry No.", Header."Cust. Ledger Entry No.");
            if CustomerLedgerEntries.FindSet()then begin
                DetailedCustLedgerEntry.CalcSums(Amount);
                Orbus_PaidAmount:=DetailedCustLedgerEntry.Amount;
            end;
        end;
        Orbus_FinalTotal:=Orbus_SubtotalSum - Orbus_PaidAmount;
    end;
    local procedure GetUserName()
    var
        User: Record User;
    begin
        User.Reset();
        User.SetRange("User Security ID", Header.SystemCreatedBy);
        if User.FindFirst()then Orbus_UserName:=User."Full Name";
    end;
    local procedure GetPickNumber()
    var
        WarehousePickLine: Record "Warehouse Activity Line";
    begin
        WarehousePickLine.Reset();
        WarehousePickLine.SetRange("Source No.", Header."No.");
        if WarehousePickLine.FindFirst()then WarehousePickNo:=WarehousePickLine."Whse. Document No."
        else
            WarehousePickNo:='' end;
    local procedure GetTotalAmounts2()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        Subtotal: Decimal;
        InvoiceDiscountTotal: Decimal;
    begin
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", Header."No.");
        if SalesInvoiceLine.FindSet()then begin
            SalesInvoiceLine.CalcSums("Ava Tax Amount", "Line Amount", "Inv. Discount Amount");
            Orbus_TotalTaxAmountText:=Format(SalesInvoiceLine."Ava Tax Amount", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_SubtotalText:=Format(SalesInvoiceLine."Line Amount", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_DiscountTotalText:=Format(SalesInvoiceLine."Inv. Discount Amount", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_TotalTaxAmountDecimal:=SalesInvoiceLine."Ava Tax Amount";
            Orbus_SubtotalDecimal:=SalesInvoiceLine."Line Amount";
            Orbus_DiscountTotalDecimal:=SalesInvoiceLine."Inv. Discount Amount";
            Orbus_TotalInclTaxDecimal:=Orbus_SubtotalDecimal - Orbus_DiscountTotalDecimal + Orbus_TotalTaxAmountDecimal;
            Orbus_TotalInclTaxText:=Format(Orbus_TotalInclTaxDecimal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
        end;
    end;
    local procedure GetSalesLineComments()
    var
        SalesCommentLine: Record "Sales Comment Line";
        SalesLine: Record "Sales Line";
        TypeHelper: Codeunit "Type Helper";
        LineBreak: Text[2];
    begin
        SalesComments:='';
        LineBreak:=TypeHelper.CRLFSeparator();
        SalesCommentLine.Reset();
        SalesCommentLine.SetRange("No.", Line."Document No.");
        SalesCommentLine.SetRange("Document Line No.", Line."Line No.");
        if SalesCommentLine.FindSet()then repeat SalesComments:=SalesComments + 'Comment: ' + SalesCommentLine.Comment + LineBreak;
            until SalesCommentLine.Next() = 0;
        if SalesComments <> '' then SalesComments:=DelChr(SalesComments, '>', LineBreak)
        else
            SalesComments:='';
    end;
}
