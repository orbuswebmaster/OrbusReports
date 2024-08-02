reportextension 55108 OrbusSalesCreditMemo extends "Standard Sales - Credit Memo"
{
    RDLCLayout = './ReportLayouts/OrbusSalesCreditMemo.rdl';

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
            column(Orbus_Bill_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(Orbus_PaymentTermsDescription; Orbus_PaymentTermsDescription)
            {
            }
            column(Orbus_Posting_Date; Format("Posting Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(Orbus_LocationName; Orbus_LocationName)
            {
            }
            column(Orbus_UserName; Orbus_UserName)
            {
            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {
            }
            column(Applies_to_Doc__Type; "Applies-to Doc. Type")
            {
            }
            column(SalesOrderNo; SalesOrderNo)
            {
            }
            column(CurrentTime; Format(CurrentTime, 0, '<Month>/<Day>/<Year4>  <Hours12>:<Minutes,2> <AM/PM>'))
            {
            }
            column(Document_Date; "Document Date")
            {
            }
        }
        add(Line)
        {
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
            column(Orbus_TotalTaxAmount; Format(Orbus_TotalTaxAmount, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
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
            column(SalesComment; SalesComment)
            {
            }
            column(No_; "No.")
            {
            }
            column(LineItemNo; LineItemNo)
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
            GetOrderNo();
            GetCurrentTime();
        end;
        }
        modify(Line)
        {
        trigger OnAfterAfterGetRecord()
        begin
            GetSalesLineComments();
            GetTotalAmounts();
            GetPaidAmountFromCustomerLedgerEntries();
            GetLineItemNo();
        end;
        }
    }
    trigger OnPreReport()
    var
    begin
        if Header.GetFilters = '' then exit end;
    var Orbus_ShippingMethodDescription: Text;
    Orbus_PaymentTermsLongDescription: Text;
    Orbus_SellToCustomerName: Text;
    Orbus_BillToCustomerName: Text;
    Orbus_ShipToName: Text;
    Comment1: Text;
    Comment2: Text;
    SalesComment: Text;
    SalesOrderNo: Text;
    Orbus_Line_Amount: Text;
    Orbus_PaymentTermsDescription: Text;
    Orbus_LocationName: Text;
    Orbus_InvoiceDiscountTotal: Decimal;
    Orbus_PaidAmount: Decimal;
    Orbus_FinalTotal: Decimal;
    Orbus_AmountLineNoTax: Decimal;
    Orbus_AmountLineWithTax: Decimal;
    Orbus_TotalTaxAmount: Decimal;
    Orbus_CLERemainingAmount: Decimal;
    Orbus_CLEInvoiceTotal: Decimal;
    Orbus_GrossAmount: Decimal;
    Orbus_SubtotalSum: Decimal;
    Orbus_UserName: Text;
    LineItemNo: Text;
    CurrentTime: DateTime;
    Company1: Text;
    Company2: Text;
    local procedure GetCurrentTime()
    var
    begin
        CurrentTime:=CurrentDateTime;
    end;
    local procedure GetLineItemNo()
    var
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCreditMemoLine.Reset();
        SalesCreditMemoLine.SetRange("Document No.", Line."Document No.");
        SalesCreditMemoLine.SetRange("Line No.", Line."Line No.");
        if SalesCreditMemoLine.FindFirst()then LineItemNo:=SalesCreditMemoLine."No.";
    end;
    local procedure GetOrderNo()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", Header."Applies-to Doc. No.");
        if SalesInvoiceHeader.FindFirst()then SalesOrderNo:=SalesInvoiceHeader."Order No.";
    end;
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
    local procedure GetSalesLineComments()
    var
        SalesCommentLine: Record "Sales Comment Line";
        SalesLine: Record "Sales Line";
        TypeHelper: Codeunit "Type Helper";
        LineBreak: Text[2];
    begin
        begin
            SalesComment:='';
            LineBreak:=TypeHelper.CRLFSeparator();
            SalesCommentLine.Reset();
            SalesCommentLine.SetRange("No.", Line."Document No.");
            SalesCommentLine.SetRange("Document Line No.", Line."Line No.");
            if SalesCommentLine.FindSet()then repeat SalesComment:=SalesComment + SalesCommentLine.Comment + LineBreak until SalesCommentLine.Next() = 0
            else
                SalesComment:='';
        end;
    end;
    local procedure GetTotalAmounts()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Document No.", Line."Document No.");
        SalesInvoiceLine.CalcSums(Amount, "Amount Including VAT", "Inv. Discount Amount");
        Orbus_AmountLineNoTax:=SalesInvoiceLine.Amount;
        Orbus_AmountLineWithTax:=SalesInvoiceLine."Amount Including VAT";
        Orbus_TotalTaxAmount:=Orbus_AmountLineWithTax - Orbus_AmountLineNoTax;
        Orbus_InvoiceDiscountTotal:=SalesInvoiceLine."Inv. Discount Amount";
        Orbus_GrossAmount:=SalesInvoiceLine.Amount;
        Orbus_SubtotalSum:=Orbus_GrossAmount + Orbus_TotalTaxAmount - Orbus_InvoiceDiscountTotal;
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
        User.SetRange("User Security ID", Header.SystemCreatedBy);
        if User.FindFirst()then Orbus_UserName:=User."Full Name";
    end;
    local procedure GetCompany()
    var
        Company: Record Company;
    begin
    end;
}
