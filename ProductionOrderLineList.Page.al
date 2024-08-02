page 55153 ProductionOrderLineList
{
    ApplicationArea = All;
    Caption = 'Production Order Lines';
    UsageCategory = Lists;
    SourceTable = "Prod. Order Line";
    PageType = List;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Caption = 'Source No.';

                    trigger OnDrillDown()
                    var
                        SalesOrderDocumentPage: Page "Sales Order";
                        SalesHeader: Record "Sales Header";
                        Item: Record Item;
                    begin
                        SalesHeader.Reset();
                        SalesHeader.SetRange("No.", Rec."Source No.");
                        if SalesHeader.FindFirst()then Page.Run(Page::"Sales Order", SalesHeader)
                        else
                        begin
                            Item.Reset();
                            Item.SetRange("No.", Rec."Source No.");
                            if Item.FindFirst()then Page.Run(Page::"Item Card", Item)
                            else
                                Message('Sales Header record no longer exists, or could not open desired record based on value: %1', Rec."Source No.");
                        end;
                    end;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Prod Order No.';

                    trigger OnDrillDown()
                    var
                        ProdOrderHeader: Record "Production Order";
                    begin
                        ProdOrderHeader.Reset();
                        ProdOrderHeader.SetRange("No.", Rec."Prod. Order No.");
                        if ProdOrderHeader.FindFirst()then begin
                            if ProdOrderHeader.Status = ProdOrderHeader.Status::Released then Page.Run(Page::"Released Production Order", ProdOrderHeader);
                            if ProdOrderHeader.Status = ProdOrderHeader.Status::Finished then Page.Run(Page::"Finished Production Order", ProdOrderHeader);
                        end
                        else
                            Message('Record does not exist in Production Order table');
                    end;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Caption = 'Variant Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bin Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Long Description"; Rec."Long Description")
                {
                    ApplicationArea = All;
                    Caption = 'Long Description';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Caption = 'Due Date';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Reserved Quantity';
                }
                field("Finished Quantity"; Rec."Finished Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Finished Quantity';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Quantity';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Cost';
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Cost Amount';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(ProdOrderDocument)
            {
                ApplicationArea = All;
                Caption = 'Prod Order Document';
                Image = Document;

                trigger OnAction()
                var
                    ProdOrderHeader: Record "Production Order";
                begin
                    ProdOrderHeader.Reset();
                    ProdOrderHeader.SetRange("No.", Rec."Prod. Order No.");
                    if ProdOrderHeader.FindFirst()then begin
                        if ProdOrderHeader.Status = ProdOrderHeader.Status::Released then Page.Run(Page::"Released Production Order", ProdOrderHeader);
                        if ProdOrderHeader.Status = ProdOrderHeader.Status::Finished then Page.Run(Page::"Finished Production Order", ProdOrderHeader);
                    end
                    else
                        Message('Record does not exist in Production Order table');
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        ProdOrderHeader: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        var1: Code[20];
        SalesLine: Record "Sales Line";
    begin
        ProdOrderHeader.Reset();
        ProdOrderHeader.SetRange("No.", Rec."Prod. Order No.");
        if ProdOrderHeader.FindFirst()then begin
            if Rec."Source No." = '' then begin
                var1:=ProdOrderHeader."Source No.";
                Rec."Source No.":=ProdOrderHeader."Source No.";
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", var1);
                SalesLine.SetRange("No.", Rec."Item No.");
                if SalesLine.FindFirst()then Rec."Long Description":=SalesLine."Long Description";
                Rec.Modify();
            end;
        end;
    end;
    trigger OnOpenPage()
    var
    begin
        Rec.Reset();
        Rec.SetFilter(Status, 'Released|Finished');
    end;
}
