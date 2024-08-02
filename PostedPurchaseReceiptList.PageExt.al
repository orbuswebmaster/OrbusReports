pageextension 55188 PostedPurchaseReceiptList extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("No.")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                Caption = 'Order No.';
            }
        }
    }
}
