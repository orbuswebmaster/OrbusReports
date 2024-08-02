tableextension 55145 SalesLineTableExt extends "Sales Line"
{
    fields
    {
        field(55101; "Assembly BOM";enum YesNo)
        {
        }
        field(55102; "Assigned User ID"; Code[50])
        {
        }
        field(55103; "Ship-To-State"; Text[50])
        {
        }
        field(55104; "Sales Order Created At"; Text[50])
        {
            ObsoleteState = Removed;
        }
        field(55105; "SalesOrder Created At"; DateTime)
        {
        }
        field(55106; "Shortcut Dimension 3 (Value)"; Text[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(3), Blocked=filter(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Global Dimension No.", 3);
                DimensionValue.SetRange(Code, Rec."Shortcut Dimension 3 (Value)");
                if DimensionValue.FindFirst()then exit
                else
                    Error('Data for this table field needs to be a valid dimension value for Shortcut Dimension 3');
            end;
        }
        field(55107; "Shortcut Dimension 4 (Value)"; Text[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(4), Blocked=filter(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Global Dimension No.", 4);
                DimensionValue.SetRange(Code, Rec."Shortcut Dimension 4 (Value)");
                if DimensionValue.FindFirst()then exit
                else
                    Error('Data for this table field needs to be a valid dimension value for Shortcut Dimension 4');
            end;
        }
        field(55108; "Shortcut Dimension 5 (Value)"; Text[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(5), Blocked=filter(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Global Dimension No.", 5);
                DimensionValue.SetRange(Code, Rec."Shortcut Dimension 5 (Value)");
                if DimensionValue.FindFirst()then exit
                else
                    Error('Data for this table field needs to be a valid dimension value for Shortcut Dimension 5');
            end;
        }
        field(55109; "Shortcut Dimension 6 (Value)"; Text[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(6), Blocked=filter(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Global Dimension No.", 6);
                DimensionValue.SetRange(Code, Rec."Shortcut Dimension 6 (Value)");
                if DimensionValue.FindFirst()then exit
                else
                    Error('Data for this table field needs to be a valid dimension value for Shortcut Dimension 6');
            end;
        }
        field(55110; "Shortcut Dimension 7 (Value)"; Text[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(7), Blocked=filter(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Global Dimension No.", 7);
                DimensionValue.SetRange(Code, Rec."Shortcut Dimension 7 (Value)");
                if DimensionValue.FindFirst()then exit
                else
                    Error('Data for this table field needs to be a valid dimension value for Shortcut Dimension 7');
            end;
        }
        field(55111; "Shortcut Dimension 8 (Value)"; Text[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(8), Blocked=filter(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Global Dimension No.", 8);
                DimensionValue.SetRange(Code, Rec."Shortcut Dimension 8 (Value)");
                if DimensionValue.FindFirst()then exit
                else
                    Error('Data for this table field needs to be a valid dimension value for Shortcut Dimension 8');
            end;
        }
        field(55112; Status;Enum "Sales Document Status")
        {
        }
        modify(Quantity)
        {
        trigger OnAfterValidate()
        var
            AssemblyHeader: Record "Assembly Header";
            Item: Record Item;
        begin
            if Rec.Type = Rec.Type::Item then begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst()then begin
                    if Item."Assembly Policy" = Item."Assembly Policy"::"Assemble-to-Order" then begin
                        AssemblyHeader.Reset();
                        if AssemblyHeader.FindLast()then begin
                            AssemblyHeader."Sales Header No.":=Rec."Document No.";
                            AssemblyHeader.Modify();
                        end;
                    end;
                end;
            end;
        end;
        }
        modify("No.")
        {
        trigger OnAfterValidate()
        var
            Item: Record Item;
            SalesLine: Record "Sales Line";
            BOMComponent: Record "BOM Component";
        begin
            SalesLine.Reset();
            SalesLine.SetRange("Document No.", Rec."Document No.");
            SalesLine.SetRange("Line No.", Rec."Line No.");
            if SalesLine.FindFirst()then begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst()then begin
                    BOMComponent.Reset();
                    BOMComponent.SetRange("Parent Item No.", Item."No.");
                    if BOMComponent.FindSet()then Rec."Assembly BOM":=Rec."Assembly BOM"::Yes
                    else
                        Rec."Assembly BOM":=Rec."Assembly BOM"::No;
                    Rec.Modify();
                end end
            else
            begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst()then begin
                    BOMComponent.Reset();
                    BOMComponent.SetRange("Parent Item No.", Item."No.");
                    if BOMComponent.FindSet()then Rec."Assembly BOM":=Rec."Assembly BOM"::Yes
                    else
                        Rec."Assembly BOM":=Rec."Assembly BOM"::No;
                end;
            end;
        end;
        }
    }
    trigger OnAfterInsert()
    var
        SalesHeader: Record "Sales Header";
        AssemblyHeader: Record "Assembly Header";
        Item: Record Item;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", Rec."Document No.");
        if SalesHeader.FindFirst()then begin
            Rec."Assigned User ID":=SalesHeader."Assigned User ID";
            Rec."SalesOrder Created At":=SalesHeader."Created At";
            Rec.Modify();
        end;
    end;
}
