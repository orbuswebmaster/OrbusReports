codeunit 55188 GetCustomerNameForGLEntries
{
    Permissions = tabledata "G/L Entry"=RIMD;

    trigger OnRun()
    var
        GLEntry: Record "G/L Entry";
        Customer: Record Customer;
    begin
        GLEntry.Reset();
        GLEntry.SetFilter("Customer Name", '');
        if GLEntry.FindSet()then repeat Customer.Reset();
                Customer.SetRange("No.", GLEntry."Source No.");
                if Customer.FindFirst()then begin
                    GLEntry."Customer Name":=Customer.Name;
                    GLEntry.Modify();
                end
                else
                begin
                    Customer.Reset();
                    Customer.SetRange("No.", GLEntry."Bal. Account No.");
                    if Customer.FindFirst()then begin
                        GLEntry."Customer Name":=Customer.Name;
                        GLEntry.Modify();
                    end;
                end;
            until GLEntry.Next() = 0;
    end;
/*procedure GetCustomerNameForGLEntries(var1: Text; CustomerName: Text): Boolean
    var
    Customer: Record Customer;
    begin
        Customer.Reset();
        Customer.SetRange("No.", var1);
        if
        Customer.FindFirst()
        then
        begin
            CustomerName := Customer.Name;

        end;
    end;*/
}
