pageextension 55149 StockKeepingUnitPageExt extends "Stockkeeping Unit Card"
{
    layout
    {
        addafter("Qty. on Asm. Component")
        {
            field(Ecommerce; Rec.Ecommerce)
            {
                ApplicationArea = All;
                Caption = 'E-Commerce';
            }
        }
    }
}
