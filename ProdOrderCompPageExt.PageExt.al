pageextension 55112 ProdOrderCompPageExt extends "Prod. Order Components"
{
    layout
    {
        addafter(Description)
        {
            field("Short Description"; Rec."Short Description")
            {
                ApplicationArea = All;
                Caption = 'Short Description';
                Editable = true;
            }
        }
    }
}
