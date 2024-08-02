pageextension 55197 SalespersonPurchaserPageExt extends "Salespersons/Purchasers"
{
    layout
    {
        addafter(Name)
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
    }
}
