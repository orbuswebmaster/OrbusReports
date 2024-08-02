pageextension 55171 ItemLedgerEntriesPageExt extends "Item Ledger Entries"
{
    layout
    {
        addafter("Location Code")
        {
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
                Caption = 'Bin Code';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        WarehouseEntry: Record "Warehouse Entry";
        ModifyItemLedgerEntries: Codeunit ModifyItemLedgerEntries;
    begin
    /*if
        Rec."Bin Code" = ''
        then*/
    /*ModifyItemLedgerEntries.Run(Rec);*/
    end;
}
