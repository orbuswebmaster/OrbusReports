pageextension 55132 VendorLedgerEntriesPageExt extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Check No"; Rec."Check No")
            {
                ApplicationArea = All;
                Caption = 'Check No.';
            }
        }
    }
}
