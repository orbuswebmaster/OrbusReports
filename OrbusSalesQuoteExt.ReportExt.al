reportextension 55101 OrbusSalesQuoteExt extends "Standard Sales - Quote"
{
    RDLCLayout = './ReportLayouts/OrbusSalesQuotenew.rdl';

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
            column(Orbus_Document_Date; Format("Document Date", 0, '<Month Text> <Day>, <Year4>'))
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
            column(Orbus_Your_Reference; "Your Reference")
            {
            }
            column(Orbus_Shipment_Date; "Shipment Date")
            {
            }
            column(Orbus_Work_Description; "Work Description")
            {
            }
            column(Orbus_SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(No_; "No.")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Orbus_PaymentTermsDescription; Orbus_PaymentTermsDescription)
            {
            }
            column(Quote_Valid_Until_Date; "Quote Valid Until Date")
            {
            }
            column(Your_Reference; "Your Reference")
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(WorkDescriptionVar; WorkDescriptionVar)
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(TotalExcludingTaxText; TotalExcludingTaxText)
            {
            }
            column(TotalDiscountPercentageText; TotalDiscountPercentageText)
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
            column(Orbus_AmountLineNoTax; Format(Orbus_AmountLineNoTax, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_AmountLineWithTax; Format(Orbus_AmountLineWithTax, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_TotalTaxAmount; Format(Orbus_TotalTaxAmount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_TotalGrossAmount; Format(Orbus_TotalGrossAmount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_TotalNetAmount; Format(Orbus_TotalNetAmount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_TotalInclTaxText; Orbus_TotalInclTaxText)
            {
            }
            column(Orbus_SubtotalText; Orbus_SubtotalText)
            {
            }
            column(Orbus_SubtotalDecimal; Orbus_SubtotalDecimal)
            {
            }
            column(Orbus_DiscountTotalText; Orbus_DiscountTotalText)
            {
            }
            column(Orbus_DiscountTotalDecimal; Orbus_DiscountTotalDecimal)
            {
            }
            column(Orbus_TotalInclTaxDecimal; Orbus_TotalInclTaxDecimal)
            {
            }
            column(Orbus_TotalTaxAmountText; Orbus_TotalTaxAmountText)
            {
            }
            column(Orbus_TotalTaxAmountDecimal; Orbus_TotalTaxAmountDecimal)
            {
            }
            column(Ava_Tax_Rate; Format("Ava Tax Rate", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(SalesComments; SalesComments)
            {
            }
            column(Shipment_Date_Line; Format("Shipment Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
        }
        modify(Header)
        {
        trigger OnAfterAfterGetRecord()
        begin
            GetDescriptionValues();
            GetPaymentTermsDescription();
            GetTotalAmounts2();
            WorkDescriptionVar:=GetWorkDescription2();
        end;
        }
        modify(Line)
        {
        trigger OnAfterAfterGetRecord()
        begin
            GetSalesLineComments();
            GetTaxTotals();
            GetGrossandNetTotals();
        end;
        }
    }
    var Orbus_ShippingMethodDescription: Text;
    SalesComments: Text;
    Orbus_PaymentTermsLongDescription: Text;
    Orbus_PaymentTermsDescription: Text;
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
    Orbus_Line_Amount: Decimal;
    Orbus_AmountLineNoTax: Decimal;
    Orbus_AmountLineWithTax: Decimal;
    Orbus_TotalTaxAmount: Decimal;
    Orbus_TotalGrossAmount: Decimal;
    Orbus_TotalNetAmount: Decimal;
    Orbus_TotalInclTaxText: Text;
    Orbus_SubtotalText: Text;
    Orbus_SubtotalDecimal: Decimal;
    Orbus_DiscountTotalText: Text;
    Orbus_DiscountTotalDecimal: Decimal;
    Orbus_TotalInclTaxDecimal: Decimal;
    Orbus_TotalTaxAmountText: Text;
    Orbus_TotalTaxAmountDecimal: Decimal;
    WorkOrderText: Text;
    WorkDescriptionVar: text;
    TotalExcludingTax: Decimal;
    TotalExcludingTaxText: Text;
    TotalDiscountPercentage: Decimal;
    TotalDiscountPercentageText: Text;
    local procedure GetDescriptionValues()
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        ShipmentMethod.SetRange(Code, Header."Shipment Method Code");
        if ShipmentMethod.FindFirst()then Orbus_ShippingMethodDescription:=ShipmentMethod.Description;
    end;
    local procedure GetPaymentTermsDescription()
    var
        PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms.Reset();
        PaymentTerms.SetRange(Code, Header."Payment Terms Code");
        if PaymentTerms.FindFirst()then Orbus_PaymentTermsDescription:=PaymentTerms.Description;
    end;
    local procedure GetTaxTotals()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", Line."Document No.");
        SalesLine.CalcSums(Amount, "Amount Including VAT");
        Orbus_AmountLineNoTax:=SalesLine.Amount;
        Orbus_AmountLineWithTax:=SalesLine."Amount Including VAT";
        Orbus_TotalTaxAmount:=Orbus_AmountLineWithTax - Orbus_AmountLineNoTax;
    end;
    local procedure GetGrossandNetTotals()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", Line."Document No.");
        SalesLine.CalcSums(Amount);
        Orbus_TotalGrossAmount:=SalesLine.Amount;
        Orbus_TotalNetAmount:=Orbus_TotalGrossAmount - Orbus_TotalTaxAmount;
    end;
    local procedure GetTotalAmounts2()
    var
        SalesLine: Record "Sales Line";
        Subtotal: Decimal;
        InvoiceDiscountTotal: Decimal;
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", Header."No.");
        if SalesLine.FindSet()then begin
            SalesLine.CalcSums("Ava Tax Amount", "Line Amount", "Inv. Discount Amount");
            Orbus_TotalTaxAmountText:=Format(SalesLine."Ava Tax Amount", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_SubtotalText:=Format(SalesLine."Line Amount", 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_DiscountTotalText:=Format(SalesLine."Inv. Discount Amount", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_TotalTaxAmountDecimal:=SalesLine."Ava Tax Amount";
            Orbus_SubtotalDecimal:=SalesLine."Line Amount";
            Orbus_DiscountTotalDecimal:=SalesLine."Inv. Discount Amount";
            TotalExcludingTax:=Orbus_SubtotalDecimal - Orbus_DiscountTotalDecimal;
            TotalExcludingTaxText:=Format(TotalExcludingTax, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>');
            TotalDiscountPercentage:=Orbus_DiscountTotalDecimal / Orbus_SubtotalDecimal;
            TotalDiscountPercentage:=TotalDiscountPercentage * 100;
            TotalDiscountPercentageText:=Format(TotalDiscountPercentage, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            if TotalDiscountPercentageText.EndsWith('.00')then begin
                TotalDiscountPercentageText:=TotalDiscountPercentageText.Replace('.00', '');
                TotalDiscountPercentageText:=TotalDiscountPercentageText + ' %';
            end
            else
                TotalDiscountPercentageText:=TotalDiscountPercentageText + ' %';
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
    procedure GetWorkDescription2(): Text var
        TempBlob: Codeunit "Temp Blob";
        Inst: Instream;
        Out: OutStream;
        var1: Text;
    begin
        TempBlob.CreateInStream(Inst);
        TempBlob.CreateOutStream(Out);
        Header."Work Description".CreateInStream(Inst);
        Inst.ReadText(var1);
        exit(var1);
    end;
}
