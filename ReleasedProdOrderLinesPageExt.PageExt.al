pageextension 55191 ReleasedProdOrderLinesPageExt extends "Released Prod. Order Lines"
{
    actions
    {
        addafter("&Reserve")
        {
            action(DeleteAllReservationEntries)
            {
                ApplicationArea = All;
                Caption = 'Delete Reservation Entries For Prod. Order';
                Image = Delete;

                trigger OnAction()
                var
                    ProdOrder: Record "Production Order";
                    ReservationEntry: Record "Reservation Entry";
                    ReservationEntry2: Record "Reservation Entry";
                    var1: Integer;
                begin
                    var1:=0;
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source ID", Rec."Prod. Order No.");
                    if ReservationEntry.FindSet()then begin
                        if Dialog.Confirm('Are you sure you want to delete all related records in Reservation Entry table for Prod. Order No.: ' + Rec."Prod. Order No." + ' ?', true)then begin
                            repeat var1:=ReservationEntry."Entry No.";
                                ReservationEntry2.Reset();
                                ReservationEntry2.SetRange("Entry No.", var1);
                                if ReservationEntry2.FindSet()then ReservationEntry2.DeleteAll();
                            until ReservationEntry.Next() = 0;
                            Message('Reservation Entry records related to Prod Order No. %1 were all successfully deleted', Rec."Prod. Order No.");
                        end
                        else
                            Message('No records were deleted out of Reservation Entry table');
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        if ProductionOrderNo = '' then exit
        else
        begin
            Rec.Reset();
            Rec.FilterGroup(11);
            Rec.SetFilter("Prod. Order No.", ProductionOrderNo);
            Rec.FilterGroup(0);
        end;
    end;
    var ProductionOrderNo: Text;
    procedure ApplyFilter(var1: Text)
    var
    begin
        ProductionOrderNo:=var1;
    end;
    procedure ProduceValues(): Text var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.Reset();
        CurrPage.SetSelectionFilter(ProdOrderLine);
        if ProdOrderLine.FindFirst()then exit(ProdOrderLine."Item No.");
    end;
}
