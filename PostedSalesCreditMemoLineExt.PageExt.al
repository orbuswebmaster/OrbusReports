pageextension 55172 PostedSalesCreditMemoLineExt extends "Posted Sales Credit Memo Lines"
{
    layout
    {
        addafter(Description)
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                Caption = 'Location Code';
            }
        }
    }
}
