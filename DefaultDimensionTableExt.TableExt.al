tableextension 55144 DefaultDimensionTableExt extends "Default Dimension"
{
    fields
    {
        modify("Dimension Value Code")
        {
        trigger OnAfterValidate()
        var
            Item: Record Item;
        begin
            if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'DEPT')then begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst()then begin
                    Item."Department Dimension":=Rec."Dimension Value Code";
                    Item.Modify();
                end;
            end;
            if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'DIVISION')then begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst()then begin
                    Item."Division Dimension":=Rec."Dimension Value Code";
                    Item.Modify();
                end;
            end;
            if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'PRDLN')then begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst()then begin
                    Item."Product Line Dimension":=Rec."Dimension Value Code";
                    Item.Modify();
                end;
            end;
            if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'MATERIAL')then begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst()then begin
                    Item."Material Dimension":=Rec."Dimension Value Code";
                    Item.Modify();
                end;
            end;
        end;
        }
    }
    trigger OnAfterInsert()
    var
        Item: Record Item;
    begin
        if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'MATERIAL')then begin
            Item.Reset();
            Item.SetRange("No.", Rec."No.");
            if Item.FindFirst()then begin
                Item."Material Dimension":=Rec."Dimension Value Code";
                Item.Modify();
            end;
        end;
        if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'DEPT')then begin
            Item.Reset();
            Item.SetRange("No.", Rec."No.");
            if Item.FindFirst()then begin
                Item."Department Dimension":=Rec."Dimension Value Code";
                Item.Modify();
            end;
        end;
        if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'DIVISION')then begin
            Item.Reset();
            Item.SetRange("No.", Rec."No.");
            if Item.FindFirst()then begin
                Item."Division Dimension":=Rec."Dimension Value Code";
                Item.Modify();
            end;
        end;
        if(Rec."Parent Type" = Rec."Parent Type"::Item) and (Rec."Dimension Code" = 'PRDLN')then begin
            Item.Reset();
            Item.SetRange("No.", Rec."No.");
            if Item.FindFirst()then begin
                Item."Product Line Dimension":=Rec."Dimension Value Code";
                Item.Modify();
            end;
        end;
    end;
}
