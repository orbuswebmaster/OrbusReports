tableextension 55111 ItemExt extends Item
{
    fields
    {
        field(55101; "Short Description"; Text[20])
        {
        }
        field(55102; "Department Dimension"; Text[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('DEPT'));
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                DefaultDimension: Record "Default Dimension";
            begin
                DefaultDimension.Reset();
                DefaultDimension.SetRange("No.", Rec."No.");
                DefaultDimension.SetFilter("Dimension Code", 'DEPT');
                if DefaultDimension.FindFirst()then begin
                    DefaultDimension."Dimension Value Code":=Rec."Department Dimension";
                    DefaultDimension.Modify();
                end
                else
                begin
                    DefaultDimension.Init();
                    DefaultDimension."Dimension Code":='DEPT';
                    DefaultDimension."Table ID":=27;
                    DefaultDimension."No.":=Rec."No.";
                    DefaultDimension."Parent Type":=DefaultDimension."Parent Type"::Item;
                    DefaultDimension."Dimension Value Code":=Rec."Department Dimension";
                    DefaultDimension.Insert();
                end;
            end;
        }
        field(55103; "Division Dimension"; Text[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('DIVISION'));
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                DefaultDimension: Record "Default Dimension";
            begin
                DefaultDimension.Reset();
                DefaultDimension.SetRange("No.", Rec."No.");
                DefaultDimension.SetFilter("Dimension Code", 'DIVISION');
                if DefaultDimension.FindFirst()then begin
                    DefaultDimension."Dimension Value Code":=Rec."Division Dimension";
                    DefaultDimension.Modify();
                end
                else
                begin
                    DefaultDimension.Init();
                    DefaultDimension."Dimension Code":='DIVISION';
                    DefaultDimension."Table ID":=27;
                    DefaultDimension."No.":=Rec."No.";
                    DefaultDimension."Parent Type":=DefaultDimension."Parent Type"::Item;
                    DefaultDimension."Dimension Value Code":=Rec."Division Dimension";
                    DefaultDimension.Insert();
                end;
            end;
        }
        field(55104; "Product Line Dimension"; Text[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('PRDLN'));
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                DefaultDimension: Record "Default Dimension";
            begin
                DefaultDimension.Reset();
                DefaultDimension.SetRange("No.", Rec."No.");
                DefaultDimension.SetFilter("Dimension Code", 'PRDLN');
                if DefaultDimension.FindFirst()then begin
                    DefaultDimension."Dimension Value Code":=Rec."Product Line Dimension";
                    DefaultDimension.Modify();
                end
                else
                begin
                    DefaultDimension.Init();
                    DefaultDimension."Dimension Code":='PRDLN';
                    DefaultDimension."Table ID":=27;
                    DefaultDimension."No.":=Rec."No.";
                    DefaultDimension."Parent Type":=DefaultDimension."Parent Type"::Item;
                    DefaultDimension."Dimension Value Code":=Rec."Product Line Dimension";
                    DefaultDimension.Insert();
                end;
            end;
        }
        field(55105; "Material Dimension"; Text[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('MATERIAL'));
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                DefaultDimension: Record "Default Dimension";
            begin
                DefaultDimension.Reset();
                DefaultDimension.SetRange("No.", Rec."No.");
                DefaultDimension.SetFilter("Dimension Code", 'MATERIAL');
                if DefaultDimension.FindFirst()then begin
                    DefaultDimension."Dimension Value Code":=Rec."Material Dimension";
                    DefaultDimension.Modify();
                end
                else
                begin
                    DefaultDimension.Init();
                    DefaultDimension."Dimension Code":='MATERIAL';
                    DefaultDimension."Table ID":=27;
                    DefaultDimension."No.":=Rec."No.";
                    DefaultDimension."Parent Type":=DefaultDimension."Parent Type"::Item;
                    DefaultDimension."Dimension Value Code":=Rec."Material Dimension";
                    DefaultDimension.Insert();
                end;
            end;
        }
        field(55106; "LV Sourced"; Boolean)
        {
        }
        modify(Blocked)
        {
        trigger OnBeforeValidate()
        var
            UserSetup: Record "User Setup";
        begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId());
            if UserSetup.FindFirst()then begin
                if UserSetup."Item Card" = false then Error('User: %1 does ot have permission to modify value for Blocked table field', UserId());
            end;
        end;
        }
        modify("Sales Blocked")
        {
        trigger OnBeforeValidate()
        var
            UserSetup: Record "User Setup";
        begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId());
            if UserSetup.FindFirst()then begin
                if UserSetup."Item Card" = false then Error('User: %1 does ot have permission to modify value for Blocked table field', UserId());
            end;
        end;
        }
        modify("Purchasing Blocked")
        {
        trigger OnBeforeValidate()
        var
            UserSetup: Record "User Setup";
        begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId());
            if UserSetup.FindFirst()then begin
                if UserSetup."Item Card" = false then Error('User: %1 does ot have permission to modify value for Blocked table field', UserId());
            end;
        end;
        }
        modify(Description)
        {
        trigger OnAfterValidate()
        var
        begin
            GetDefaultDimensionValuesOnInsert();
        end;
        }
        modify("No.")
        {
        trigger OnBeforeValidate()
        var
            UserSetup: Record "User Setup";
        begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId);
            if UserSetup.FindFirst()then begin
                if UserSetup."Can Modify Item No." = false then Error('Your user: %1 is not allowed to modify the data in the "No." table field for a record in the item table', UserId());
            end;
        end;
        }
    }
    procedure GetDefaultDimensionValuesOnInsert()
    var
        DefaultDimension: Record "Default Dimension";
    begin
        DefaultDimension.Reset();
        DefaultDimension.SetRange("No.", Rec."No.");
        if DefaultDimension.FindSet()then repeat if DefaultDimension."Dimension Code" = 'DEPT' then begin
                    Rec."Department Dimension":=DefaultDimension."Dimension Value Code";
                    Rec.Modify();
                end;
                if DefaultDimension."Dimension Code" = 'DIVISION' then begin
                    Rec."Division Dimension":=DefaultDimension."Dimension Value Code";
                    Rec.Modify();
                end;
                if DefaultDimension."Dimension Code" = 'PRDLN' then begin
                    Rec."Product Line Dimension":=DefaultDimension."Dimension Value Code";
                    Rec.Modify();
                end;
                if DefaultDimension."Dimension Code" = 'MATERIAL' then begin
                    Rec."Material Dimension":=DefaultDimension."Dimension Value Code";
                    Rec.Modify();
                end;
            until DefaultDimension.Next() = 0;
    end;
}
