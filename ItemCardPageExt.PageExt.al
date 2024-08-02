pageextension 55113 ItemCardPageExt extends "Item Card"
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
        addafter("Long Description")
        {
            field("Department Dimension"; Rec."Department Dimension")
            {
                ApplicationArea = All;
                Caption = 'Department Dimension';
            }
            field("Division Dimension"; Rec."Division Dimension")
            {
                ApplicationArea = All;
                Caption = 'Division Dimension';
            }
            field("Product Line Dimension"; Rec."Product Line Dimension")
            {
                ApplicationArea = All;
                Caption = 'Product Line Dimension';
            }
            field("Material Dimension"; Rec."Material Dimension")
            {
                ApplicationArea = All;
                Caption = 'Material Dimension';
            }
            field("LV Sourced"; Rec."LV Sourced")
            {
                ApplicationArea = All;
                Caption = 'LV Sourced';
            }
        }
    }
}
