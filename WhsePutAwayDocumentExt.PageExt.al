pageextension 55153 WhsePutAwayDocumentExt extends "Warehouse Put-away"
{
    actions
    {
        addafter("&Print")
        {
            action(RentalReturn)
            {
                ApplicationArea = All;
                Caption = 'Rental Return';
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    WhseActivityHeader: Record "Warehouse Activity Header";
                begin
                    WhseActivityHeader.Reset();
                    WhseActivityHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::RentalReturn, true, false, WhseActivityHeader);
                end;
            }
        }
    }
}
