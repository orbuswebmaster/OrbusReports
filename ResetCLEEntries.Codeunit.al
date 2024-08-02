codeunit 55141 ResetCLEEntries
{
    Permissions = tabledata "Cust. Ledger Entry"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Date1: Integer;
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        CustLedgerEntry.Reset();
        if CustLedgerEntry.FindSet()then repeat if CustLedgerEntry."Due Date" <> 0D then begin
                    DCLE.Reset();
                    DCLE.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                    DCLE.CalcSums("Amount (LCY)");
                    CustLedgerEntry."Amount 2":=DCLE."Amount (LCY)";
                    if Today() <= CustLedgerEntry."Due Date" then CustLedgerEntry.Current:=true
                    else
                        CustLedgerEntry.Current:=false;
                    Date1:=Today() - CustLedgerEntry."Due Date";
                    if(Date1 > 0) and (Date1 < 31)then CustLedgerEntry."1 to 30":=true
                    else
                        CustLedgerEntry."1 to 30":=false;
                    if(Date1 > 30) and (Date1 < 61)then CustLedgerEntry."31 to 60":=true
                    else
                        CustLedgerEntry."31 to 60":=false;
                    if(Date1 > 60) and (Date1 < 91)then CustLedgerEntry."61 to 90":=true
                    else
                        CustLedgerEntry."61 to 90":=false;
                    if Date1 > 90 then CustLedgerEntry."Over 90":=true
                    else
                        CustLedgerEntry."Over 90":=false;
                    if CustLedgerEntry."Document Type Text" = '' then CustLedgerEntry."Document Type Text":=Format(CustLedgerEntry."Document Type", 0, '<Text>');
                    CustLedgerEntry.Modify()end;
            until CustLedgerEntry.Next() = 0;
    end;
}
