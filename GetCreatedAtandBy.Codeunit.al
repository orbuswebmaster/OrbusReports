codeunit 55159 GetCreatedAtandBy
{
    Permissions = tabledata "Sales Header"=RIMD,
        tabledata "Sales Invoice Header"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        User: Record User;
        var1: GUID;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet()then repeat var1:=SalesHeader.SystemCreatedBy;
                User.Reset();
                User.SetRange("User Security ID", var1);
                if User.FindFirst()then SalesHeader.Created_By:=User."User Name";
                SalesHeader."Created At":=SalesHeader.SystemCreatedAt;
                SalesHeader.Modify();
            until SalesHeader.Next() = 0 end;
}
