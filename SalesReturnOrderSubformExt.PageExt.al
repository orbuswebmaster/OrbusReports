pageextension 55185 SalesReturnOrderSubformExt extends "Sales Return Order Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field("Ship-To-State"; Rec."Ship-To-State")
            {
                ApplicationArea = All;
                Caption = 'Ship-To State';
            }
        }
    }
}
