codeunit 55148 UpdateEmailArt
{
    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        if SalesHeader.FindSet()then repeat SalesHeader."Art Email":=SalesHeader.ArtEmail;
                SalesHeader.Modify();
            until SalesHeader.Next() = 0;
    end;
}
