tableextension 55143 DSHIPPackageOptionsExt extends "DSHIP Package Options"
{
    fields
    {
        modify("Payment Type")
        {
        trigger OnAfterValidate()
        var
            SalesHeader: Record "Sales Header";
        begin
            SalesHeader.Reset();
            SalesHeader.SetRange("No.", Rec."Document No.");
            if SalesHeader.FindFirst()then begin
                SalesHeader."Payment Type (new)":=Format(Rec."Payment Type", 0, '<Text>');
                SalesHeader.Modify();
            end;
        end;
        }
    }
}
