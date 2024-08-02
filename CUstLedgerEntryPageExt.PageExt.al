pageextension 55145 CUstLedgerEntryPageExt extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Remaining Amount")
        {
            field("Amount 2"; Rec."Amount 2")
            {
                ApplicationArea = All;
            }
            field(Current; Rec.Current)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Cancel")
        {
            action(Update)
            {
                ApplicationArea = All;
                Caption = 'Update';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    StandardDialogueForCLE: Page StandardDialogueForCLE;
                    GetValuesForCustLedgerEntries: Codeunit GetValuesForCustLedgerEntries;
                begin
                    StandardDialogueForCLE.GetCLE(Rec."Entry No.", Rec."Due Date");
                    if StandardDialogueForCLE.RunModal() = Action::OK then StandardDialogueForCLE.SDUpdateCLE();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        GetValuesForCustLedgerEntries2: Codeunit GetValuesForCustLedgerEntries2;
        CLE: Record "Cust. Ledger Entry";
    begin
        CLE.Reset();
        CLE.FindFirst();
        if CLE.BooleanCHecked = true then begin
            GetValuesForCustLedgerEntries2.Run(Rec);
            CLE.BooleanCHecked:=false;
            CLE.Modify();
        end;
    end;
}
