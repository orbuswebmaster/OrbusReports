page 55192 CaseLineListPart
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = CaseLine;

    layout
    {
        area(Content)
        {
            field(CaseNo; CaseNo)
            {
                ApplicationArea = All;
                Visible = false;
            }
            repeater(Main)
            {
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        SalesHeader: Record "Sales Header";
                        SalesInvoiceHeader: Record "Sales Invoice Header";
                        SalesInvoiceLine: Record "Sales Invoice Line";
                        SalesLine: Record "Sales Line";
                        CaseWSG: Record "Case WSG";
                        var1: Enum LookupTypeNew;
                        PostedSalesInvoiceLisPage: Page "Posted Sales Invoices";
                        CaseLine: Record CaseLine;
                        SalesRecordFOrCase: Record SalesRecordForCase;
                        SourceNo: Text;
                        var2: Integer;
                    begin
                        if Rec.Type = Rec.Type::" " then Error('"Type" table field needs value other than "blank" before looking up to records in a table');
                        CaseWSG.Reset();
                        CaseWSG.SetFilter("No.", Rec."Case No.");
                        if CaseWSG.FindFirst()then begin
                            var1:=CaseWSG."Lookup Type";
                            if CaseWSG."Lookup Type" = CaseWSG."Lookup Type"::"Posted Sales Invoice" then SourceNo:=CaseWSG."Sales Invoice Header No.";
                            if CaseWSG."Lookup Type" = CaseWSG."Lookup Type"::"Sales Order" then SourceNo:=CaseWSg."Sales Header No.";
                            if CaseWSG."Lookup Type" = CaseWSG."Lookup Type"::"Sales Quote" then SourceNo:=CaseWSG."Sales QUote No.";
                        end;
                        if Rec.Type = Rec.Type::Item then begin
                            if(var1 = var1::"Sales Order") or (var1 = var1::"Sales Quote")then begin
                                SalesLine.Reset();
                                SalesLine.FilterGroup(11);
                                SalesLine.SetFilter("Document No.", SourceNo);
                                SalesLine.SetRange(Type, SalesLine.Type::Item);
                                if Page.RunModal(Page::"Sales Lines", SalesLine) = Action::LookupOK then begin
                                    Rec."No.":=SalesLine."No.";
                                    Rec.Quantity:=SalesLine.Quantity;
                                    Rec."Department Dimension":=SalesLine."Shortcut Dimension 2 Code";
                                    Rec."Variant Code":=SalesLine."Variant Code";
                                    Rec.Modify();
                                end;
                            end;
                            if var1 = var1::"Posted Sales Invoice" then begin
                                SalesInvoiceLine.Reset();
                                SalesInvoiceLine.FilterGroup(11);
                                SalesInvoiceLine.SetFilter("Document No.", SourceNo);
                                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                                if Page.RunModal(Page::"Posted Sales Invoice Lines", SalesInvoiceLine) = Action::LookupOK then begin
                                    Rec."No.":=SalesInvoiceLine."No.";
                                    Rec.Quantity:=SalesInvoiceLine.Quantity;
                                    Rec."Department Dimension":=SalesInvoiceLine."Shortcut Dimension 2 Code";
                                    Rec."Variant Code":=SalesInvoiceLine."Variant Code";
                                    Rec.Modify();
                                end;
                            end;
                        end
                        else
                        begin
                            if Rec.Type = Rec.Type::Resource then begin
                                if(var1 = var1::"Sales Order") or (var1 = var1::"Sales Quote")then begin
                                    SalesLine.Reset();
                                    SalesLine.FilterGroup(11);
                                    SalesLine.SetFilter("Document No.", SourceNo);
                                    SalesLine.SetRange(Type, SalesLine.Type::Resource);
                                    if Page.RunModal(Page::"Sales Lines", SalesLine) = Action::LookupOK then begin
                                        Rec."No.":=SalesLine."No.";
                                        Rec.Quantity:=SalesLine.Quantity;
                                        Rec."Department Dimension":=SalesLine."Shortcut Dimension 2 Code";
                                        Rec."Variant Code":=SalesInvoiceLine."Variant Code";
                                        if Rec.Modify()then var2:=2
                                        else
                                            Error('');
                                    end;
                                end;
                                if var1 = var1::"Posted Sales Invoice" then begin
                                    SalesInvoiceLine.Reset();
                                    SalesInvoiceLine.FilterGroup(11);
                                    SalesInvoiceLine.SetFilter("Document No.", SourceNo);
                                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Resource);
                                    if Page.RunModal(Page::"Posted Sales Invoice Lines", SalesInvoiceLine) = Action::LookupOK then begin
                                        Rec."No.":=SalesInvoiceLine."No.";
                                        Rec.Quantity:=SalesInvoiceLine.Quantity;
                                        Rec."Department Dimension":=SalesInvoiceLine."Shortcut Dimension 2 Code";
                                        Rec."Variant Code":=SalesInvoiceLine."Variant Code";
                                        if Rec.Modify()then var2:=1
                                        else
                                            Error('Case Line record was not successfully modified. Please try again.');
                                    end;
                                end;
                            end;
                        end;
                    end;
                    trigger OnValidate()
                    var
                        Item: Record Item;
                        Resource: Record Resource;
                        var1: Integer;
                    begin
                        if Rec.Type = Rec.Type::" " then Error('Cannot modify value in"Type" table field to "blank" value ');
                        if Rec.Type = Rec.Type::Item then begin
                            Item.Reset();
                            Item.SetFilter("No.", Rec."No.");
                            if Item.FindFirst()then var1:=1
                            else
                                Error('Value in "No." table field has to be based on an existing Item record since value in "Type" table field is "Item"');
                        end;
                        if Rec.Type = Rec.Type::Resource then begin
                            Resource.Reset();
                            Resource.SetFilter("No.", Rec."No.");
                            if Resource.FindFirst()then var1:=1
                            else
                                Error('Value in "No." table field has to be based on an existing Resource record, since value in "Type" table field is "Resource"');
                        end;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        ItemVariant: Record "Item Variant";
                        var1: Integer;
                    begin
                        if Rec.Type = Rec.Type::Item then begin
                            ItemVariant.Reset();
                            ItemVariant.FilterGroup(11);
                            ItemVariant.SetFilter("Item No.", Rec."No.");
                            if Page.RunModal(Page::"Item Variants", ItemVariant) = Action::LookupOK then begin
                                Rec."Variant Code":=ItemVariant.Code;
                                if Rec.Modify()then var1:=1
                                else
                                    Error('Record was not successfully modified. Please try again.');
                            end;
                        end
                        else
                            Message('Type table field needs a value of "Item" in order to lookup to Item Variant table');
                    end;
                    trigger OnValidate()
                    var
                        ItemVariant: Record "Item Variant";
                        var1: Integer;
                    begin
                        ItemVariant.Reset();
                        ItemVariant.SetFilter("Item No.", Rec."No.");
                        ItemVariant.SetFilter(Code, Rec."Variant Code");
                        if ItemVariant.FindFirst()then var1:=1
                        else
                            Error('No record in Item Varaint table field value of: ' + Rec."Variant Code" + ' for given item no: ' + Rec."No.");
                    end;
                }
                /*field("Department Specification";Rec."Department Specification")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                    CaseReasonDetail: Record CaseReasonDetail;
                    CaseHeader: Record "Case WSG";
                    var1: Integer;
                    begin
                        CaseReasonDetail.Reset();
                        CaseReasonDetail.SetFilter("Reason Code", Rec."Reason Code");
                        if
                        Page.RunModal(Page::CaseReasonDetailList, CaseReasonDetail) = Action::LookupOK
                        then
                        begin
                            Rec."Department Specification" := CaseReasonDetail.Code;
                            if
                            Rec.Modify()
                            then
                            var1 := 1
                            else
                            Error('Record was not successfully modified. Please try again.');
                        end;
                    end;
                    trigger OnValidate()
                    var
                    CaseReasonDetail: Record CaseReasonDetail;
                    CaseHeader: Record "Case WSG";
                    var1: Integer;
                    begin
                        CaseReasonDetail.Reset();
                        CaseReasonDetail.SetFilter("Reason Code", Rec."Reason Code");
                        CaseReasonDetail.SetFilter(Code, Rec."Department Specification");
                        if
                        CaseReasonDetail.FindFirst()
                        then
                        begin
                            CaseHeader.Reset();
                            CaseHeader.SetFilter("No.", Rec."Case No.");
                            if
                            CaseHeader.FindFirst()
                            then
                            begin
                                if
                                Rec."Department Specification" <> CaseHeader."Department Specification"
                                then
                                begin
                                    if
                                    Dialog.Confirm('Dpeartment Specification for Case Header record has a diferent value than: ' + Rec."Department Specification" + '. Are you sure you want to modify?', true)
                                    then
                                    var1 := 1
                                    else
                                    begin
                                        Rec."Department Specification" := xRec."Department Specification";
                                        if
                                        Rec.Modify()
                                        then
                                        var1 := 1
                                        else
                                        Error('Data/Value reverted back to original value in department specification table field for this record in the Case Line table');
                                    end;
                                end;
                            end;
                        end
                        else
                        Error('');

                    end;
                }*/
                field("Department Dimension"; Rec."Department Dimension")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ViewSalesLineRecords)
            {
                Caption = 'View Sales Lines';
                ApplicationArea = All;
                Image = View;

                trigger OnAction()
                var
                    SalesLineListPage: Page "Sales Lines";
                    SalesRecordForCase: Record SalesRecordForCase;
                    var1: Text;
                begin
                    SalesRecordForCase.Reset();
                    SalesRecordForCase.SetRange("User ID", UserId());
                    SalesRecordForCase.SetRange("Case No.", Rec."Case No.");
                    if SalesRecordForCase.FindLast()then var1:=SalesRecordForCase."Sales Record No.";
                    SalesLineListPage.LookupMode(true);
                    SalesLineListPage.ApplyFilter(var1);
                    if SalesLineListPage.RunModal() = Action::LookupOK then begin
                    end;
                end;
            }
        }
    }
    var CaseNo: Text;
    EditableVar1: Boolean;
    /*trigger OnAfterGetCurrRecord()
    var
    begin
        if
        Rec.Type = Rec.type::" "
        then
        EditableVar1 := false
        else
        EditableVar1 := true;
    end;*/
    trigger OnOpenPage()
    var
        SalesRecordForCase: Record SalesRecordForCase;
    begin
        SalesRecordForCase.Reset();
        SalesRecordForCase.SetRange("User ID", UserId());
        if SalesRecordForCase.FindLast()then CaseNo:=SalesRecordForCase."Case No.";
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean var
        SalesRecordForCase: Record SalesRecordForCase;
        CaseWSG: Record "Case WSG";
        CaseLine: Record CaseLine;
    begin
        //SalesRecordForCase.Reset();
        //SalesRecordForCase.SetFilter("User ID", UserId());
        //if
        //SalesRecordForCase.FindLast()
        //then
        //begin
        CaseWSG.Reset();
        CaseWSG.SetFilter("No.", Rec."Case No.");
        if CaseWSG.FindFirst()then begin
            Rec."Assigned User ID":=CaseWSG."Assigned User ID";
            Rec."Sales Record No.":=CaseWSG."Sales Header No.";
            Rec."Contact Name":=CaseWSG."Contact Name";
            Rec."Created By":=UserId();
            Rec."DateTime Created":=CurrentDateTime();
            Rec.Name:=CaseWSG."Entity Name";
            Rec.Status:=Format(CaseWSG.Status, 0, '<Text>');
            Rec."Reason Code":=CaseWSG."Reason Code";
            Rec."Resolution Document":=CaseWSG."Resolution Page Name";
            Rec."Resolution No.":=CaseWSG."Resolution No.";
            Rec."Resolution Code":=CaseWSG."Resolution Code";
            Rec."SalesPerson Code":=CaseWSG."SalesPerson Code";
            Rec."Location Code":=CaseWSG."Location Code";
            Rec."Department Specification":=CaseWSG."Department Specification";
        //Rec."Retrieved Intial Values" := true;
        //Rec.Modify();
        end;
    end;
    //end;
    procedure GetCaseNo(var1: Text)
    var
    begin
        CaseNo:=var1;
    end;
/*if
                        CaseNo = ''
                        then
                        begin
                            SalesRecordFOrCase.Reset();
                            SalesRecordFOrCase.SetRange("User ID", UserId());
                            if
                            SalesRecordFOrCase.FindLast()
                            then
                            begin
                                CaseNo := SalesRecordFOrCase."Case No.";
                                var1 := SalesRecordFOrCase."Sales Record No.";
                            end;
                        end
                        else
                        begin
                        CaseWSG.Reset();
                        CaseWSG.SetRange("No.", CaseNo);
                        if
                        CaseWSG.FindFirst()
                        then
                        var1 := CaseWSG."Sales Header No.";
                        end;

                        if
                        Rec.Type = Rec.Type::Item
                        then
                        begin

                        end;

                        if
                        Rec.Type = Rec.Type::"G/L Account"
                        then
                        begin
                            SalesInvoiceLine.Reset();
                            SalesInvoiceLine.SetFilter("Document No.", var1);
                            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::"G/L Account");
                            if
                            Page.RunModal(Page::"Sales Lines", SalesLine) = Action::LookupOK
                            then
                            begin
                                CaseLine.Reset();
                                CaseLine.SetRange("Entry No.", Rec."Entry No.");
                                if
                                CaseLine.FindFirst()
                                then
                                begin
                                    Rec."No." := SalesInvoiceLine."No.";
                                    Rec.Quantity := SalesInvoiceLine.Quantity;
                                    Rec."Department Dimension" := SalesInvoiceLine."Shortcut Dimension 2 Code";
                                    Rec.Modify();
                                end
                                else
                                    Rec."No." := SalesInvoiceLine."No.";
                                    Rec.Quantity := SalesInvoiceLine.Quantity;
                                    Rec."Department Dimension" := SalesInvoiceLine."Shortcut Dimension 2 Code";
                            end;
                        end;

                        if
                        rec.Type = rec.Type::"Fixed Asset"
                        then
                        begin

                        end;



                        if
                        var1.StartsWith('PS-INV')
                        then
                        begin
                            SalesInvoiceLine.Reset();
                            SalesInvoiceLine.SetFilter("Document No.", var1);
                            if
                            Page.RunModal(Page::"Posted Sales Invoice Lines", SalesInvoiceLine) = Action::LookupOK
                            then
                            begin
                                
                                CaseLine.Reset();
                                CaseLine.SetRange("Entry No.", Rec."Entry No.");
                                if
                                CaseLine.FindFirst()
                                then
                                begin
                                    Rec."No." := SalesInvoiceLine."No.";
                                    Rec."Department Dimension" := SalesInvoiceLine."Shortcut Dimension 2 Code";
                                    Rec.Quantity := SalesInvoiceLine.Quantity;
                                    Rec.Type := Rec.Type::Item;
                                    Rec.Modify();
                                end
                                else
                                begin
                                    Rec."No." := SalesInvoiceLine."No.";
                                    Rec."Department Dimension" := SalesInvoiceLine."Shortcut Dimension 2 Code";
                                    Rec.Quantity := SalesInvoiceLine.Quantity;
                                    Rec.Type := Rec.Type::Item;
                                end;

                                CaseWSG.Reset();
                                CaseWSG.SetFilter("No.", CaseNo);
                                if
                                CaseWSG.FindFirst()
                                then
                                begin
                                    CaseWSG."Location Code" := SalesInvoiceLine."Location Code";
                                    CaseWSG.Modify();
                                end;
                            end;
                        end
                        else
                        begin
                            SalesLine.Reset();
                            SalesLine.SetFilter("Document No.", var1);
                            if
                            Page.RunModal(Page::"Sales Lines", SalesLine) = Action::LookupOK
                            then
                            begin
                                CaseLine.Reset();
                                CaseLine.SetRange("Entry No.", Rec."Entry No.");
                                if
                                CaseLine.FindFirst()
                                then
                                begin
                                    Rec."No." := SalesLine."No.";
                                    Rec."Department Dimension" := SalesLine."Shortcut Dimension 2 Code";
                                    Rec.Quantity := SalesLine.Quantity;
                                    Rec.Type := Rec.Type::Item;
                                    Rec.Modify();              
                                end
                                else
                                begin
                                    Rec."No." := SalesLine."No.";
                                    Rec."Department Dimension" := SalesLine."Shortcut Dimension 2 Code";
                                    Rec.Quantity := SalesLine.Quantity;
                                    Rec.Type := Rec.Type::Item;
                                end;

                                CaseWSG.Reset();
                                CaseWSG.SetFilter("No.", CaseNo);
                                if
                                CaseWSG.FindFirst()
                                then
                                begin
                                    CaseWSG."Location Code" := SalesLine."Location Code";
                                    CaseWSG.Modify();
                                end;
                            end;
                        end;
                    end;*/
}
