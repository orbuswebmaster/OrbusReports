pageextension 55173 ProdOrderComponentList extends "Prod. Order Comp. Line List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code")
            {
                ApplicationArea = All;
                Caption = 'Unit of Measure Code';
            }
        }
    }
}
