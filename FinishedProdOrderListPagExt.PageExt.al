pageextension 55152 FinishedProdOrderListPagExt extends "Finished Production Orders"
{
    layout
    {
        addafter("Source No.")
        {
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = All;
                Caption = 'Created By';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        User: Record User;
    begin
        if Rec."Created By" = '' then begin
            User.Reset();
            User.SetRange("User Security ID", Rec.SystemCreatedBy);
            if User.FindFirst()then begin
                Rec."Created By":=User."User Name";
                Rec.Modify();
            end;
        end;
    end;
}
