pageextension 55143 TransferOrderSubformExt extends "Transfer Order Subform"
{
    layout
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                ItemVariant: Record "Item Variant";
            begin
                ItemVariant.Reset();
                ItemVariant.SetRange("Item No.", Rec."Item No.");
                if ItemVariant.FindSet()then begin
                    Rec."Variant Met":=true;
                    Rec.Modify();
                /*Message('Item variant(s) exist for Item No you selected. Please select variant code for item');*/
                end end;
        }
        modify("Variant Code")
        {
            ShowMandatory = ShowMandatoryVar;

            trigger OnAfterValidate()
            var
            begin
                if Rec."Variant Code" <> '' then begin
                    Rec."Variant Met":=false;
                    Rec.Modify();
                end
                else
                begin
                    Rec."Variant Met":=true;
                    Rec.Modify();
                end;
            end;
        }
    }
    trigger OnAfterGetRecord()
    var
        ItemVariant: Record "Item Variant";
    begin
        ItemVariant.Reset();
        ItemVariant.SetRange("Item No.", Rec."Item No.");
        if ItemVariant.FindSet()then ShowMandatoryVar:=true
        else
            ShowMandatoryVar:=false;
    end;
    var ShowMandatoryVar: Boolean;
}
