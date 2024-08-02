page 55101 StandardDialogueForCLE
{
    ApplicationArea = All;
    Caption = 'Update CLE';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(EntryNo; EntryNo)
            {
                ApplicationArea = All;
                Caption = 'Entry No';
                Editable = false;
            }
            field(DueDate; DueDate)
            {
                ApplicationArea = All;
                Caption = 'Due Date';
            }
        }
    }
    procedure GetCLE(var1: Integer; var2: Date)
    var
    begin
        EntryNo:=var1;
        DueDate:=var2;
    end;
    procedure SDUpdateCLE()
    var
        GetValuesForCustLedgerEntries: Codeunit GetValuesForCustLedgerEntries;
    begin
        GetValuesForCustLedgerEntries.UpdateCLE(EntryNo, DueDate);
    end;
    var EntryNo: Integer;
    DueDate: Date;
}
