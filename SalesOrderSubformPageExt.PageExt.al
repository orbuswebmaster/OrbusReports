pageextension 55150 SalesOrderSubformPageExt extends "Sales Order Subform"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Prepmt. Line Amount 2"; Rec."Prepmt. Line Amount")
            {
                ApplicationArea = All;
                Caption = 'Prepayment Amount';
                Visible = true;
            }
        }
    }
}
