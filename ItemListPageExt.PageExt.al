pageextension 55111 ItemListPageExt extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Short Description"; Rec."Short Description")
            {
                ApplicationArea = All;
                Caption = 'Short Description';
            }
        }
        addafter(InventoryField)
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
        }
    }
    procedure ProdcueValues(): Text var
        Item: Record Item;
        var1: Text;
    begin
        var1:='';
        Item.Reset();
        CurrPage.SetSelectionFilter(Item);
        if Item.FindSet()then repeat var1:=var1 + Item."No." + '|';
            until Item.Next() = 0;
        var1:=DelChr(var1, '>', '|');
        exit(var1);
    end;
}
