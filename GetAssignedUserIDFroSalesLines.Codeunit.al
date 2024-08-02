codeunit 55152 GetAssignedUserIDFroSalesLines
{
    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetFilter("Assigned User ID", '');
        if SalesLine.FindSet()then repeat SalesHeader.Reset();
                SalesHeader.SetRange("No.", SalesLine."Document No.");
                if SalesHeader.FindFirst()then begin
                    SalesLine."Assigned User ID":=SalesHeader."Assigned User ID";
                    SalesLine.Modify();
                end;
            until SalesLine.Next() = 0;
    end;
}
