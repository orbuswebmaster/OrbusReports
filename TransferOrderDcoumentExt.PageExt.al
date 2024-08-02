pageextension 55144 TransferOrderDcoumentExt extends "Transfer Order"
{
    actions
    {
        modify("Create Whse. S&hipment")
        {
            trigger OnBeforeAction()
            var
                TransferLines: Record "Transfer Line";
            begin
                TransferLines.Reset;
                TransferLines.SetRange("Document No.", Rec."No.");
                if TransferLines.FindSet()then repeat if TransferLines."Variant Met" = true then Error('Variant codes are missing on one or more transfer lines. Cannot create whse. shipment until variant codes are added to required lines');
                    until TransferLines.Next() = 0;
            end;
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean var
        TransferLines: Record "Transfer Line";
        var1: Text;
    begin
        var1:='';
        TransferLines.Reset();
        TransferLines.SetRange("Document No.", Rec."No.");
        if TransferLines.FindSet()then repeat if TransferLines."Variant Met" = true then var1:=var1 + TransferLines."Item No." + ', ';
            until TransferLines.Next() = 0;
        if var1 <> '' then begin
            var1:=DelChr(var1, '>', ', ');
            Error('Transfer Line item numbers that are missing variant codes: %1', var1);
        end;
    end;
}
