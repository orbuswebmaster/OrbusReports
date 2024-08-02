codeunit 55197 GetCustomerNameForGLEntries2
{
    Permissions = tabledata "G/L Entry"=RIMD;
    TableNo = "G/L Entry";

    trigger OnRun()
    var
        Customer: Record Customer;
    begin
        if Rec."Customer Name" = '' then begin
            Customer.Reset();
            Customer.SetRange("No.", Rec."Source No.");
            if Customer.FindFirst()then begin
                Rec."Customer Name":=Customer.Name;
                Rec.Modify()end
            else
            begin
                Customer.Reset();
                Customer.SetRange("No.", Rec."Bal. Account No.");
                if Customer.FindFirst()then begin
                    Rec."Customer Name":=Customer.Name;
                    Rec.Modify();
                end;
            end;
        end;
    end;
}
