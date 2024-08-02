codeunit 55134 GetValuesForCustLedgerEntries3
{
    Permissions = tabledata "Cust. Ledger Entry"=RIMD;

    procedure BalancesPerEntry()
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        CustomerLedgerEntry.Reset();
        CustomerLedgerEntry.SetFilter("Document Type Text", 'Invoice|Payment|Credit Memo');
        if CustomerLedgerEntry.FindSet()then repeat DCLE.Reset();
                DCLE.SetRange("Cust. Ledger Entry No.", CustomerLedgerEntry."Entry No.");
                DCLE.CalcSums("Amount (LCY)");
                if CustomerLedgerEntry."Amount 2" = DCLE."Amount (LCY)" then exit
                else
                begin
                    CustomerLedgerEntry."Amount 2":=DCLE."Amount (LCY)";
                    CustomerLedgerEntry.Modify();
                end;
            until CustomerLedgerEntry.Next() = 0;
    end;
    procedure BalancesPerEntry2(Var1: Record "Cust. Ledger Entry")
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        DCLE.Reset();
        DCLE.SetRange("Cust. Ledger Entry No.", Var1."Entry No.");
        DCLE.CalcSums("Amount (LCY)");
        Var1."Amount 2":=DCLE."Amount (LCY)";
        Var1.Modify();
    end;
}
