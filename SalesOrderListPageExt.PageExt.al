pageextension 55122 SalesOrderListPageExt extends "Sales Order List"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Warehouse Pick No."; Rec."Warehouse Pick No.")
            {
                ApplicationArea = All;
                Caption = 'Warehouse Pick No.';
                Editable = false;

                trigger OnDrillDown()
                var
                    WhseActHeader: Record "Warehouse Activity Header";
                begin
                    WhseActHeader.Reset();
                    WhseActHeader.SetRange("No.", Rec."Warehouse Pick No.");
                    if WhseActHeader.FindFirst()then Page.Run(Page::"Warehouse Pick", WhseActHeader);
                end;
            }
            field("Registered Warehouse Pick No."; Rec."Registered Warehouse Pick No.")
            {
                ApplicationArea = All;
                Caption = 'Registered Warehouse Pick No.';
                Editable = false;

                trigger OnDrillDown()
                var
                    RegWhseActHeader: Record "Registered Whse. Activity Hdr.";
                begin
                    RegWhseActHeader.Reset();
                    RegWhseActHeader.SetRange("No.", Rec."Registered Warehouse Pick No.");
                    if RegWhseActHeader.FindFirst()then Page.Run(Page::"Registered Pick", RegWhseActHeader);
                end;
            }
        }
        addbefore("Completely Shipped")
        {
            field("Payment Type"; Rec."Payment Type (new)")
            {
                ApplicationArea = All;
                Caption = 'Payment Type';
                Editable = false;
            }
            field("Prepayment Receieved"; Rec."Prepayment Receieved")
            {
                Caption = 'Prepayment Received';
                ApplicationArea = All;
                Editable = false;
            }
            field("Art Email"; Rec."Art Email")
            {
                ApplicationArea = All;
                Caption = 'Email Art';
            }
            field("Needs Assessment"; Rec."Needs Assessment")
            {
                ApplicationArea = All;
                Caption = 'Needs Assessment';
            }
            field(ArtEmail; Rec.ArtEmail)
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Case No."; Rec."Case No.")
            {
                ApplicationArea = ALl;
                Caption = 'Case No.';
            }
        }
        addbefore(Status)
        {
            field("In-Hands Date"; Rec."In-Hands Date")
            {
                ApplicationArea = All;
                Caption = 'In-Hands Date';
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(InternalReprintReport)
            {
                Caption = 'Internal Reprint Report';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    InternalReprint: Report InternalReprint;
                    ProductionHeader: Record "Production Order";
                    var1: Text;
                begin
                    ProductionHeader.Reset();
                    ProductionHeader.SetFilter(Status, 'Released|Finished');
                    ProductionHeader.SetRange("Source No.", Rec."No.");
                    if ProductionHeader.FindLast()then var1:=ProductionHeader."No."
                    else
                        var1:='';
                    InternalReprint.GetValues(Rec."No.", Rec."Sell-to Customer Name", Rec."Shipment Date", Rec."Shipping Agent Code", Rec."Shipping Agent Service Code 2", var1, Rec."Assigned User ID", Rec."Location Code");
                    InternalReprint.RunModal();
                end;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Can Delete Sales Orders" = false then Error('Your user: %1 is not allowed to delete sales orders', UserId());
        end;
    end;
    trigger OnAfterGetRecord()
    var
        WhseActHeader: Record "Warehouse Activity Header";
        RegisteredWhseActHeader: Record "Registered Whse. Activity Hdr.";
        RegWhseActHeader: Record "Registered Whse. Activity Hdr.";
        DSHIPPackageOptions: Record "DSHIP Package Options";
    begin
        if Rec."Warehouse Pick No." = '' then begin
            WhseActHeader.Reset();
            WhseActHeader.SetRange(Type, WhseActHeader.Type::Pick);
            WhseActHeader.SetRange("Source No.", Rec."No.");
            if WhseActHeader.FindFirst()then begin
                Rec."Warehouse Pick No.":=WhseActHeader."No.";
                Rec.Modify();
            end
            else
            begin
                RegisteredWhseActHeader.Reset();
                RegisteredWhseActHeader.SetRange(Type, RegisteredWhseActHeader.Type::Pick);
                RegisteredWhseActHeader.SetRange("Source No", Rec."No.");
                if RegisteredWhseActHeader.FindFirst()then begin
                    Rec."Warehouse Pick No.":=RegisteredWhseActHeader."Whse. Activity No.";
                    Rec.Modify();
                end;
            end;
        end;
        if Rec."Registered Warehouse Pick No." = '' then begin
            RegWhseActHeader.Reset();
            RegWhseActHeader.SetRange(Type, RegWhseActHeader.Type::Pick);
            RegWhseActHeader.SetRange("Source No", Rec."No.");
            if RegWhseActHeader.FindFirst()then begin
                Rec."Registered Warehouse Pick No.":=RegWhseActHeader."No.";
                Rec.Modify();
            end;
        end;
    end;
    procedure GetSalesHeaderNo(): Text var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        CurrPage.SetSelectionFilter(SalesHeader);
        if SalesHeader.FindFirst()then exit(SalesHeader."No.");
    end;
    procedure GetLocationCode(): Text var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        CurrPage.SetSelectionFilter(SalesHeader);
        if SalesHeader.FindFirst()then exit(SalesHeader."Location Code");
    end;
}
