codeunit 55128 VendorLedgerEntriesCheckNo
{
    Permissions = tabledata "Vendor Ledger Entry"=RIMD,
        tabledata "Check Ledger Entry"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        VendorLedgerEntries: Record "Vendor Ledger Entry";
        CHeckLedgerEntries: Record "Check Ledger Entry";
    begin
        VendorLedgerEntries.Reset();
        VendorLedgerEntries.SetRange("Document Type", VendorLedgerEntries."Document Type"::Payment);
        if VendorLedgerEntries.FindSet()then repeat if VendorLedgerEntries."Check No" = '' then begin
                    CHeckLedgerEntries.Reset();
                    CHeckLedgerEntries.SetRange("Document No.", VendorLedgerEntries."Document No.");
                    if CHeckLedgerEntries.FindLast()then begin
                        VendorLedgerEntries."Check No":=CHeckLedgerEntries."Check No";
                        VendorLedgerEntries.Modify();
                    end;
                end until VendorLedgerEntries.Next() = 0;
    end;
}
