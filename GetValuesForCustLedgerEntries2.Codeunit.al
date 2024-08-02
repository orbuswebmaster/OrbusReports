codeunit 55133 GetValuesForCustLedgerEntries2
{
    Permissions = tabledata "Cust. Ledger Entry"=RIMD;
    TableNo = "Cust. Ledger Entry";

    trigger OnRun()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Date1: Integer;
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        DCLE.Reset();
        DCLE.SetRange("Cust. Ledger Entry No.", Rec."Entry No.");
        DCLE.CalcSums("Amount (LCY)");
        Rec."Amount 2":=DCLE."Amount (LCY)";
        if Today() <= Rec."Due Date" then Rec.Current:=true
        else
            Rec.Current:=false;
        Date1:=Today() - Rec."Due Date";
        if(Date1 > 0) and (Date1 < 31)then Rec."1 to 30":=true
        else
            Rec."1 to 30":=false;
        if(Date1 > 30) and (Date1 < 61)then Rec."31 to 60":=true
        else
            Rec."31 to 60":=false;
        if(Date1 > 60) and (Date1 < 91)then Rec."61 to 90":=true
        else
            Rec."61 to 90":=false;
        if Date1 > 90 then Rec."Over 90":=true
        else
            Rec."Over 90":=false;
        if Rec."Document Type Text" = '' then Rec."Document Type Text":=Format(Rec."Document Type", 0, '<Text>');
        Rec.Modify()end;
    procedure BalancesPerEntry()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetFilter("Document Type Text", 'Invoice|Payment|Credit Memo');
        if CustLedgerEntry.FindSet()then repeat if Today() <= CustLedgerEntry."Due Date" then begin
                    if CustLedgerEntry.Current = true then exit
                    else
                    begin
                        CustLedgerEntry.Current:=true;
                        CustLedgerEntry.Modify();
                    end;
                end
                else
                begin
                    if CustLedgerEntry.Current = false then exit
                    else
                    begin
                        CustLedgerEntry.Current:=false;
                        CustLedgerEntry.Modify();
                    end;
                end;
            until CustLedgerEntry.Next() = 0;
    end;
    procedure BalancesPerEntry2(Var1: Record "Cust. Ledger Entry")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Date1: Integer;
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        DCLE.Reset();
        DCLE.SetRange("Cust. Ledger Entry No.", Var1."Entry No.");
        DCLE.CalcSums("Amount (LCY)");
        Var1."Amount 2":=DCLE."Amount (LCY)";
        if Today() <= Var1."Due Date" then Var1.Current:=true
        else
            Var1.Current:=false;
        Date1:=Today() - Var1."Due Date";
        if(Date1 > 0) and (Date1 < 31)then Var1."1 to 30":=true
        else
            Var1."1 to 30":=false;
        if(Date1 > 30) and (Date1 < 61)then Var1."31 to 60":=true
        else
            Var1."31 to 60":=false;
        if(Date1 > 60) and (Date1 < 91)then Var1."61 to 90":=true
        else
            Var1."61 to 90":=false;
        if Date1 > 90 then Var1."Over 90":=true
        else
            Var1."Over 90":=false;
        if Var1."Document Type Text" = '' then Var1."Document Type Text":=Format(Var1."Document Type", 0, '<Text>');
        Var1.Modify()end;
    procedure BalancesPerEntry3()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Date1: Integer;
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        CustLedgerEntry.Reset();
        CustLedgerEntry.FindFirst();
        if CustLedgerEntry.BooleanCHecked = true then exit
        else
        begin
            CustLedgerEntry.Reset();
            CustLedgerEntry.SetFilter("Document Type Text", 'Invoice|Payment|Credit Memo');
            if CustLedgerEntry.FindSet()then repeat DCLE.Reset();
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
                    CustLedgerEntry.Modify();
                until CustLedgerEntry.Next() = 0;
            CustLedgerEntry.Reset();
            CustLedgerEntry.FindFirst();
            CustLedgerEntry.BooleanCHecked:=true;
            CustLedgerEntry.Modify();
        end;
    end;
}
