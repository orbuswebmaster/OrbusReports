pageextension 55148 SalesLineFactboxPageExt extends "Sales Line FactBox"
{
    layout
    {
        addafter(SalesLineDiscounts)
        {
            field("Assembly BOM"; Rec."Assembly BOM")
            {
                ApplicationArea = All;
                Caption = 'Assembly BOM';
                Editable = false;

                trigger OnDrillDown()
                var
                    BOMComponent: Record "BOM Component";
                begin
                    BOMComponent.Reset();
                    BOMComponent.SetRange("Parent Item No.", Rec."No.");
                    Page.Run(Page::"Assembly BOM", BOMComponent);
                end;
            }
        }
    }
}
