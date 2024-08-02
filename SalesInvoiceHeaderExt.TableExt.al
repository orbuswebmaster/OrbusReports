tableextension 55140 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(55103; "Industry Shortcut Dimension"; Text[100])
        {
        }
        field(55104; "Amount Minus Freight"; Decimal)
        {
        }
        field(55110; "Payment Type (new)"; Text[100])
        {
        }
        field(55111; "Prepayment Receieved";Enum YesNo)
        {
        }
        field(55112; "Art Email"; Text[250])
        {
        }
        field(55113; "In-Hands Date"; Date)
        {
        }
        field(55114; "Contact No. (Custom)"; Code[20])
        {
        }
        field(55115; "Sell-To Phone No. (Custom)"; Text[30])
        {
        }
        field(55116; "Sell-To Email (Custom)"; Text[80])
        {
        }
        field(55117; "Sell-To Contact Name (Custom)"; Text[100])
        {
        }
        field(55118; "Created At"; DateTime)
        {
        }
        field(55119; "Case No."; Text[100])
        {
        }
        field(55138; "SalesPerson Email"; Text[100])
        {
        }
        field(50121; Created_By; Text[50])
        {
        }
        field(59501; "Shipping Agent Service Code 2"; Code[10])
        {
        }
        field(50122; "Assigned User ID 2"; Text[100])
        {
        }
    }
}
