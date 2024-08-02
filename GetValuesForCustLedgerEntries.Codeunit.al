codeunit 55132 GetValuesForCustLedgerEntries
{
    Permissions = tabledata "Cust. Ledger Entry"=RIMD;
    TableNo = "Job Queue Entry";

    procedure BalancesPerEntry()
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        Date1: Integer;
        Date1Text: Text;
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        CustomerLedgerEntry.Reset();
        CustomerLedgerEntry.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
        if CustomerLedgerEntry.FindSet()then repeat CustomerLedgerEntry."1 to 30":=false;
                CustomerLedgerEntry."31 to 60":=false;
                CustomerLedgerEntry."61 to 90":=false;
                CustomerLedgerEntry."Over 90":=false;
                Date1:=Today() - CustomerLedgerEntry."Due Date";
                Date1Text:=Format(Date1);
                if(Date1 > 0) and (Date1 < 31)then CustomerLedgerEntry."1 to 30":=true
                else
                    CustomerLedgerEntry."1 to 30":=false;
                if(Date1 > 30) and (Date1 < 61)then CustomerLedgerEntry."31 to 60":=true
                else
                    CustomerLedgerEntry."31 to 60":=false;
                if(Date1 > 60) and (Date1 < 91)then CustomerLedgerEntry."61 to 90":=true
                else
                    CustomerLedgerEntry."61 to 90":=false;
                if Date1 > 90 then CustomerLedgerEntry."Over 90":=true
                else
                    CustomerLedgerEntry."Over 90":=false;
                CustomerLedgerEntry.Modify();
            until CustomerLedgerEntry.Next() = 0;
    end;
    procedure UpdateCLE(var1: Integer; var2: Date)
    var
        CLE: Record "Cust. Ledger Entry";
    begin
        CLE.Reset();
        CLE.SetRange("Entry No.", var1);
        if CLE.FindFirst()then begin
            CLE."Due Date":=var2;
            CLE.Modify();
        end;
    end;
}
